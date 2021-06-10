LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity op2 is
port(
a: in std_logic_vector(3 downto 0);
b: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
v,z,n: out std_logic
);
end op2;

architecture arq_op2 of op2 is

signal tempC0,tempC1,tempC2,aC0,aC1,aC2,over1,over2: std_logic;
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
port map(a=> a(0), b => a(0), saida => aux(0), carry => aC0);
AD1: FA
port map(a=>a(1), b=>a(1), saida=>aux(1), c=>aC0, carry =>aC1);
AD2: FA
port map(a=>a(2), b=>a(2),saida=>aux(2), c=>aC1, carry =>aC2);
AD3: FA
port map(a=>a(3), b=>a(3),saida=>aux(3), c=>aC2, carry =>over1);


AD4: HA
port map(a=> aux(0), b => b(0), saida => sai(0), carry => tempC0);
AD5: FA
port map(a=>aux(1), b=>b(1), saida=>sai(1), c=>tempC0, carry =>tempC1);
AD6: FA
port map(a=>aux(2), b=>b(2),saida=>sai(2), c=>tempC1, carry =>tempC2);
AD7: FA
port map(a=>aux(3), b=>b(3),saida=>sai(3), c=>tempC2, carry =>over2);

v<= over1 or over2;
z<= not ((sai(0) or sai(1)) or ( sai (2) or sai(3)));
n<='0';

end arq_op2;

