LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity op4 is
port(
b: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
aux: buffer std_logic_vector(3 downto 0);
v,z,n: out std_logic
);
end op4;

architecture arq_op4 of op4 is

signal tempC0,tempC1,aC0,aC1,ov11,ov12,ov21,ov22: std_logic;

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
port map(a=>b(0), b=> b(0), saida=>aux(0), carry =>aC0);
AD1: FA
port map(a=>b(1), b=> b(1), saida=>aux(1), c=>aC0, carry =>aC1);
AD2: FA
port map(a=>b(2), b=> b(2),saida=>aux(2), c=>aC1, carry =>ov11);
AD3: FA
port map(a=>b(3), b=> b(3),saida=>aux(3), c=>ov11, carry =>ov12);

AD4: HA
port map(a=>aux(0), b=> b(0), saida=>sai(0), carry =>tempC0);
AD5: FA
port map(a=>aux(1), b=> b(1), saida=>sai(1), c=>tempC0, carry =>tempC1);
AD6: FA
port map(a=>aux(2), b=> b(2),saida=>sai(2), c=>tempC1, carry =>ov21);
AD7: FA
port map(a=>aux(3), b=> b(3),saida=>sai(3), c=>ov21, carry =>ov22);

v<= ov12 or  ov22;
z<= not ((sai(0) or sai(1)) or ( sai (2) or sai(3)));
n<='0';


end arq_op4;