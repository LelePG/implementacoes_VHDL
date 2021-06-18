library IEEE;
use ieee.std_logic_1164.all;
entity subtratorNbits is 
	generic(TAMANHO: integer:= 4);
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSub: out std_logic_vector(TAMANHO-1 downto 0);
		overflow, negativo: out std_logic
	);
end subtratorNbits;

architecture subtratorNbitsArch of subtratorNbits is
signal carriesAux: std_logic_vector (TAMANHO downto 0); 
signal resultadoSubAux: std_logic_vector(TAMANHO-1 downto 0);

component fullSubtractor is 
port (
a, b, cin : in std_logic;
cout, saida: out std_logic  
);
end component;

begin 
	carriesAux(0) <= '0';
	subtrator: 
	  for i in 0 to TAMANHO-1 generate
		componenteSomador: fullSubtractor port map(
		a => entrada1(i),
		b => entrada2(i),
		cin => carriesAux(i),
		cout => carriesAux(i+1),
		saida => resultadoSubAux(i));
	end generate subtrator;

	overflow <= carriesAux(TAMANHO);
	negativo <= resultadoSubAux(TAMANHO-1);
	resultadoSub <= resultadoSubAux;

end subtratorNbitsArch;


