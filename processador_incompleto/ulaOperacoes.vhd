library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Operações da ULA
entity ulaOperacoes is 
generic(TAMANHO: integer:= 8);
port (
	funct: in std_logic_vector(4 downto 0);
	registradorA: in std_logic_vector(TAMANHO-1 downto 0);
	registradorB: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(TAMANHO-1 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end ulaOperacoes;

architecture ulaOperacoesArch of ulaOperacoes is
signal registradorR, resultadoSoma, resultadoSub: std_logic_vector (7 downto 0);--sinais que representam os registradores (ainda não implementados) 
signal SinalOverflow, SinalcarryOut, Sinalnegativo, Sinalzero: std_logic; -- sinais que representam as flags da ULA
signal SinalOverflowSoma: std_logic;
signal SinalOverflowSub, SinalnegativoSub:std_logic;

component somadorNbits is --Componente somador
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;

component subtratorNbits is -- Componente subtrator
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSub: out std_logic_vector(TAMANHO-1 downto 0);
		overflow, negativo: out std_logic
	);
end component;

begin 
--Chamada dos componentes subtrator e somador e redirecionamento destes elementos para um sinal
	somador: somadorNbits port map(
			entrada1 => registradorA,
			entrada2 => registradorB,
			resultadoSoma => resultadoSoma,
			overflow => SinalOverflowSoma); 
		
	subtrator: subtratorNbits port map(
			entrada1 => registradorA,
			entrada2 => registradorB,
			resultadoSub => resultadoSub,
			overflow => SinalOverflowSub,
			negativo => SinalnegativoSub); 

	
	SinalOverflow <= SinalOverflowSoma or SinalOverflowSub;
	SinalcarryOut <= SinalOverflowSoma or SinalOverflowSub;
	Sinalnegativo <= registradorR(7);
	
	with funct select
	registradorR <= resultadoSoma when "00001",
	                resultadoSub when "00010",
	                registradorA XOR registradorB when "00100",
	                registradorA AND registradorB when "01000",
	                registradorA OR registradorB when "10000",
	                (others => '0') when others;
	Sinalzero <= '1' when registradorR = "00000000" else '0';

	
	--Atribuição às saídas dos sinais utilizados
	overflow <= SinalOverflow;
	carryOut <= SinalcarryOut;
	zero<= Sinalzero;
	negativo <= Sinalnegativo;
	resultado <= registradorR;
	
end ulaOperacoesArch;
  