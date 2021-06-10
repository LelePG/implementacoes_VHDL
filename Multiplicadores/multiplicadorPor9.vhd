library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicadorPor9 is
	generic(TAMANHO: integer:= 11);
	port(
	op1: in std_logic_vector(7 downto 0);
	resultado: out std_logic_vector(TAMANHO-1 downto 0)--8 bits do op1 + 3 bits do 9
	);
end entity;

architecture multiplicadorPor9Arch of multiplicadorPor9 is
component somadorNbits is 
	generic(TAMANHO: integer:= 11);
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;

signal resultadoParcial: std_logic_vector(TAMANHO-1 downto 0); 
signal overflow: std_logic;
begin

resultadoParcial<= op1 & "000";

somador: somadorNbits port map (
		entrada1 => resultadoParcial,
		entrada2 => "000" & op1, 
		resultadoSoma => resultado,
		overflow=> overflow
	);


end multiplicadorPor9Arch;