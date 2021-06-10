LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity op1 is
port(
a: in std_logic;
b: in std_logic;
saida: out std_logic
);
end op1;

architecture arq_op1 of op1 is
begin
saida <= a OR b;
end arq_op1;