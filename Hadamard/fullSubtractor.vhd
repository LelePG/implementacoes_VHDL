library IEEE;
use ieee.std_logic_1164.all;
entity fullSubtractor is 

port (
	a, b, cin : in std_logic;
	cout, saida: out std_logic
);
end fullSubtractor;


architecture fullSubtractorArch of fullSubtractor is
begin 
	cout <= ((not a) and b) or ((not a) and cin) or (b and cin);
	saida <= a xor b xor cin;
end fullSubtractorArch;
  