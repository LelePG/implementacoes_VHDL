library IEEE;
use IEEE.std_logic_1164.all;

entity ram_noR is
generic (PALAVRAS: integer :=1024; TAMANHO: integer :=32);
port(
	clock, writeEnable: in std_logic;
	endereco: in integer;
	entrada: in std_logic_vector(TAMANHO-1 downto 0);
	saida: out std_logic_vector(TAMANHO-1 downto 0)
);
end ram_noR;

architecture ram_noRArch of ram_noR is
type ram_T is array (PALAVRAS-1 downto 0) of std_logic_vector(TAMANHO-1 downto 0);
signal ram: ram_t := (others => (others => '0'));
begin
	process (clock)
	begin
	if (rising_edge (clock)) then
		if (writeEnable = '1') then 
			ram(endereco) <= entrada;
		end if;
		saida <= ram(endereco);
	end if;
	end process;
end ram_noRArch;
