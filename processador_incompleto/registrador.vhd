library ieee;
use ieee.std_logic_1164.all;
entity registrador is
	generic (TAMANHO: integer :=8);
	port (
		d: in std_logic_vector (TAMANHO - 1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO - 1 downto 0)
	);
	
END registrador;

architecture registradorArch of registrador is
begin
	process(reset, clock)
	begin
		if reset = '1' then
			q <=  (OTHERS => '0');
		elsif clock'event and clock = '1' then
		   if enable = '1' then
		      q <= d;
		   end if;
		end if;
	end process;
end registradorArch;