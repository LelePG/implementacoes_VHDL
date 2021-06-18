library IEEE;
use IEEE.std_logic_1164.all;

entity ram_R is
generic (PALAVRAS: integer :=1024; TAMANHO: integer :=32);
port(
	clock, writeEnable, reset: in std_logic;
	endereco: in integer;
	entrada: in std_logic_vector(TAMANHO-1 downto 0);
	saida: out std_logic_vector(TAMANHO-1 downto 0)
);
end ram_R;

architecture ram_RArch of ram_R is

component registrador is
	port (
		d: in std_logic_vector (TAMANHO - 1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO - 1 downto 0)
	);
	
end component;

type ram_T is array (PALAVRAS-1 downto 0) of std_logic_vector(TAMANHO-1 downto 0);
signal ram: ram_t := (others => (others => '0'));
signal saidaReg : std_logic_vector(TAMANHO-1 downto 0);

begin
registradorIn: registrador port map (
	d => entrada,
	reset => reset,
	clock => clock,
	enable => writeEnable,
	q => saidaReg
	);

	process (clock, writeEnable, endereco)
	begin
	if (rising_edge (clock)) then
		if (writeEnable = '1') then 
			ram(endereco) <= saidaReg;
		end if;
		saida <= ram(endereco);
	end if;
	end process;
end ram_RArch;
