library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Operações da ULA
entity ulaOperacoes is 
generic(TAMANHO: integer:= 32);
port (
	funct: in std_logic_vector(5 downto 0);
	registradorA: in std_logic_vector(TAMANHO-1 downto 0);
	registradorB: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(TAMANHO-1 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end ulaOperacoes;

architecture ulaOperacoesArch of ulaOperacoes is
signal registradorR, resultadoSoma, resultadoSub: std_logic_vector (31 downto 0);--sinais que representam os registradores (ainda não implementados) 
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
	Sinalnegativo <= registradorR(31);
	
	with funct select
	registradorR <= resultadoSoma when "000001",
	                resultadoSub when "000010",
	                (registradorA AND registradorB) OR (NOT registradorB) when "000100",
	                registradorA AND registradorB when "001000",
	                registradorA XOR registradorB when "010000",
	                not registradorA when "100000",
	                (others => '0') when others;
	                
	Sinalzero <= '1' when registradorR = "00000000000000000000000000000000" else '0';
	
	
	
	--Atribuição às saídas dos sinais utilizados
	overflow <= SinalOverflow;
	carryOut <= SinalcarryOut;
	zero<= Sinalzero;
	negativo <= Sinalnegativo;
	resultado <= registradorR;
end ulaOperacoesArch;
  