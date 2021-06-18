library IEEE;
use ieee.std_logic_1164.all;
entity somadorNbits is 
	generic(TAMANHO: integer:= 4);
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end somadorNbits;


architecture somadorNbitsArch of somadorNbits is
signal carriesAux: std_logic_vector (TAMANHO downto 0); 

component fullAdder is 
port (
a, b, cin : in std_logic;
cout, saida: out std_logic  
);
end component;

begin 
	carriesAux(0) <= '0';

	somador: 
	  for i in 0 to TAMANHO-1 generate
		componenteSomador: fullAdder port map(
		a => entrada1(i),
		b => entrada2(i),
		cin => carriesAux(i),
		cout => carriesAux(i+1),
		saida => resultadoSoma(i));
	end generate somador;

	overflow <= carriesAux(1) xor carriesAux(0);

end somadorNbitsArch;


