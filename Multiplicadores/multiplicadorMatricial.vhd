library IEEE;
use ieee.std_logic_1164.all;

entity multiplicadorMatricial is
	generic(TAMANHO: integer:= 8);
	port(
	op1, op2: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(2*TAMANHO-1 downto 0)
	);
end entity;

architecture multiplicadorMatricialArch of multiplicadorMatricial is
component somadorNbits is 
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;
signal a, b: std_logic_vector(TAMANHO-1 downto 0);
signal saida: std_logic_vector(2*TAMANHO-1 downto 0);
signal carries: std_logic_vector(TAMANHO-1 downto 0);
type matrizDeParciais is array (7 downto 0) of std_logic_vector(TAMANHO-1 downto 0);--Cria um tipo matriz para armazenar os produtos parciais com tamanho TAMANHO-1
signal produtosParciais : matrizDeParciais;	--cria uma matriz para armazenar os produtosparciais
begin 
a <= op1;
b <= op2;
saida(0) <= a(0) and b(0);
carries(0) <= '0';

produtosParciais(0)(7 downto 1) <=  (a(0) and b(7)) & (a(0) and b(6)) & (a(0) and b(5)) & (a(0) and b(4)) & (a(0) and b(3)) & (a(0) and b(2)) & (a(0) and b(1));

multiplicador: 
	  for i in 0 to TAMANHO-2 generate
		componenteSomador: somadorNbits port map(
		entrada1 => carries(i) & produtosParciais(i)(7 downto 1),
		entrada2 => (a(i+1) and b(7)) & (a(i+1) and b(6)) & (a(i+1) and b(5)) & (a(i+1) and b(4)) & (a(i+1) and b(3)) & (a(i+1) and b(2)) & (a(i+1) and b(1)) & (a(i+1) and b(0)),
		resultadoSoma => produtosParciais(i+1),
		overflow => carries(i+1)
		);
		saida(i+1) <= produtosParciais(i+1)(0);
	end generate multiplicador;


saida(15 downto 8)<= carries(7) & produtosParciais(7)(7 downto 1);

resultado<= saida;
	
end multiplicadorMatricialArch;