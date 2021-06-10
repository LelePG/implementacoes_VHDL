LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity op3 is
port(
a: in std_logic_vector(3 downto 0);
b: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
v,z,n: out std_logic
);
end op3;

architecture arq_op3 of op3 is

signal tempC0,tempC1,tempC2: std_logic;
signal aux: std_logic_vector(3 downto 0);
component HA
	port (
	a,b : in std_logic;
	saida: out std_logic;
	carry: out std_logic
	);
	end component;
component FA
port(
	a,b : in std_logic;
	c: in std_logic;
	carry: out std_logic;
	saida: out std_logic
);
end component;

begin

AD0: HA
port map(a=>a(0), b =>b(0), saida =>sai(0), carry =>tempC0);
AD1: FA
port map(a=>a(1), b=>b(1), saida=>sai(1), c=>tempC0, carry =>tempC1);
AD2: FA
port map(a=>a(2), b=>b(2),saida=>sai(2), c=>tempC1, carry =>tempC2);
AD3: FA
port map(a=>a(3), b=>b(3),saida=>sai(3), c=>tempC2, carry =>v);

z<= not ((sai(0) or sai(1)) or ( sai (2) or sai(3)));
n<='0';

end arq_op3;

