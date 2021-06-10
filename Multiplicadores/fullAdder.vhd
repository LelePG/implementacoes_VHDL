library IEEE;
use ieee.std_logic_1164.all;

entity fullAdder is 
	port (
		a, b, cin : in std_logic;
		cout, saida: out std_logic  
	);
end fullAdder;


architecture fullAdderArch of fullAdder is
begin 
	cout <= (a and b) or (a and cin) or (b and cin);
	saida <= a xor b xor cin;
end fullAdderArch;