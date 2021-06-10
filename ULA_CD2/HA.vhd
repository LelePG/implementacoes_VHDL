library IEEE;
use ieee.std_logic_1164.all;

entity HA is 
port (
a : in std_logic;
b: in std_logic;
carry: out std_logic;
saida: out std_logic  
);
end HA;

architecture soma of HA is
begin 
carry <= a and b;
saida <= a xor b;
end soma;
  