LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity ula is
port (
a: in std_logic_vector(3 downto 0);
b: in std_logic_vector(3 downto 0);
f: in std_logic_vector(1 downto 0);

a_sai: out std_logic_vector(3 downto 0);
b_sai: out std_logic_vector(3 downto 0);
f_sai: out std_logic_vector(1 downto 0);

sai_op1: buffer std_logic_vector(3 downto 0);
sai_op2: buffer std_logic_vector(3 downto 0);
sai_op3: buffer std_logic_vector(3 downto 0);
sai_op4: buffer std_logic_vector(3 downto 0);
agora_vai: out std_logic_vector(6 downto 0);
agora_vai2: out std_logic_vector(6 downto 0);

v_op1,z_op1,n_op1: buffer std_logic;
v_op2,z_op2,n_op2: buffer std_logic;
v_op3,z_op3,n_op3: buffer std_logic;
v_op4,z_op4,n_op4: buffer std_logic;
v_sai,z_sai,n_sai : out std_logic
);
end ula;

architecture arq_ula of ula is
component op1 --A AND B
port (
A: in std_logic;
B: in std_logic;
saida: out std_logic
);
end component;

component op2 --A+B+B
port(
A: in std_logic_vector(3 downto 0);
B: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
V,Z,N: out std_logic
);
end component;

component op3 --a+b
port(
A: in std_logic_vector(3 downto 0);
B: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
V,Z,N: out std_logic
);
end component;

component op4 --a-b-b
port(

B: in std_logic_vector(3 downto 0);
sai: buffer std_logic_vector (3 downto 0);
aux: buffer std_logic_vector(3 downto 0);
V,Z,N: out std_logic
);
end component;
signal sinal_agora_vai: std_logic_vector(3 downto 0);


begin

A0: op1
port map (A=>a(0),B=>b(0),saida=>sai_op1(0));
A1: op1
port map (A=>a(1),B=>b(1),saida=>sai_op1(1));
A2: op1
port map (A=>a(2),B=>b(2),saida=>sai_op1(2));
A3: op1
port map (A=>a(3),B=>b(3),saida=>sai_op1(3));
v_op1<='0';
z_op1<=not((sai_op1(0) or sai_op1(1)) or (sai_op1(2) or sai_op1(3)));
n_op1<='0';



T2: op2
port map(A=>a,B=>b,sai=>sai_op2,V=>v_op2,Z=>z_op2,N=>n_op2);

T3: op3
port map(A=>a,B=>b,sai=>sai_op3,V=>v_op3,Z=>z_op3,N=>n_op3);

T4: op4--ERROAQUI
port map(B=>b,sai=>sai_op4,V=>v_op4,Z=>z_op4,N=>n_op4);


a_sai<=a;
b_sai<=b;
f_sai<=f;

--agora_vai <= sinal_agora_vai;

with f(1 downto 0) select sinal_agora_vai <=
sai_op1 when "00", -- a and b
sai_op2 when "01", -- a + b 
sai_op3 when "10", -- a + b+b
sai_op4 when "11"; -- a - b - b

with f(1 downto 0) select v_sai <=
v_op1 when "00", -- a and b
v_op2 when "01", -- a + b 
v_op3 when "10", -- a + b+b
v_op4 when "11"; -- a - b - b

with f(1 downto 0) select z_sai <=
z_op1 when "00", -- a and b
z_op2 when "01", -- a + b 
z_op3 when "10", -- a + b +b
z_op4 when "11"; -- a - b - b

with f(1 downto 0) select n_sai <=
n_op1 when "00", -- a and b
n_op2 when "01", -- a + b 
n_op3 when "10", -- a + b +b
n_op4 when "11"; -- a - b - b


agora_vai<=
"1111001" when (sinal_agora_vai="0000") else
"1001111" when (sinal_agora_vai="0001") else
"0100100" when (sinal_agora_vai="0010") else
"0110000" when (sinal_agora_vai="0011") else
"0011001" when (sinal_agora_vai="0100") else
"0010010" when (sinal_agora_vai="0101") else
"0000010" when (sinal_agora_vai="0110") else
"1111000" when (sinal_agora_vai="0111") else
"0000000" when (sinal_agora_vai="1000") else
"0010000" when (sinal_agora_vai="1001") else--9
"1111001" when (sinal_agora_vai="1010") else--10
"1001111" when (sinal_agora_vai="1011") else--11
"0100100" when (sinal_agora_vai="1100") else--12
"0110000" when (sinal_agora_vai="1101") else--13
"0011001" when (sinal_agora_vai="1110") else--14
"0010010" when (sinal_agora_vai="1111") else--15

"1111111";

agora_vai2<=
"1001111" when (sinal_agora_vai="1001") else--9
"1001111" when (sinal_agora_vai="1010") else--10
"1001111" when (sinal_agora_vai="1011") else--11
"1001111" when (sinal_agora_vai="1100") else--12
"1001111" when (sinal_agora_vai="1101") else--13
"1001111" when (sinal_agora_vai="1110") else--14
"1001111" when (sinal_agora_vai="1111") else--15
"1111111";



end arq_ula;