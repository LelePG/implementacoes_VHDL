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
	registradorDest: out std_logic_vector(TAMANHO-1 downto 0);
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

	process(funct)
	begin
		--Atribuição inicial de valores para os sinais de saida
		SinalOverflow <= '0';
		SinalcarryOut <= '0';
		Sinalnegativo <= '0';
		Sinalzero <= '0';
		if funct = "000001" then -- A+B
			SinalOverflow <= SinalOverflowSoma;
			SinalcarryOut <= SinalOverflowSoma;
			registradorR <= resultadoSoma;
		elsif funct = "000010" then -- A -B
			SinalOverflow <= SinalOverflowSub;
			SinalcarryOut <= SinalOverflowSub;
			Sinalnegativo <= SinalnegativoSub;
			registradorR <= resultadoSub;
		elsif funct = "000100" then -- (A and B) or (not B)
			registradorR <=(registradorA AND registradorB) OR (NOT registradorB);
		elsif funct = "001000" then -- A and B
			registradorR <= registradorA AND registradorB;
		elsif funct = "010000" then --A xor B
			registradorR <= registradorA XOR registradorB;
		elsif funct = "100000" then  -- not A
			registradorR <= not registradorA;
		end if;
		if unsigned( registradorR ) = 0 then --verificador de zero
			Sinalzero <= '1';
		end if;
	end process;
	--Atribuição às saídas dos sinais utilizados
	overflow <= SinalOverflow;
	carryOut <= SinalcarryOut;
	zero<= Sinalzero;
	negativo <= Sinalnegativo;
	registradorDest <= registradorR;
end ulaOperacoesArch;
  