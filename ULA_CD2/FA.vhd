library IEEE;
use ieee.std_logic_1164.all;
entity FA is 
port (
a : in std_logic;
b: in std_logic;
c: in std_logic;
carry: out std_logic;
saida: out std_logic  
);
end FA;


architecture soma2 of FA is
begin 
carry <= (a and b) or (a and c) or (b and c);
saida <= a xor b xor c;
end soma2;
  