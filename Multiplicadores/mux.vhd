library IEEE;
use ieee.std_logic_1164.all;

entity mux is 
	generic(TAMANHO: integer:= 3); 
-- generic(TAMANHO: integer:=8);
	port (
		entrada1, entrada0 : in std_logic_vector(TAMANHO-1 downto 0);
		control: in std_logic;
		saida: out std_logic_vector(TAMANHO -1 downto 0)  
	);
end mux;


architecture muxArch of mux is
begin 
	process(control)
	begin
	case control is
		when '0' => saida <= entrada0;
		when '1' => saida <= entrada1;
		end case;
	end process;
end muxArch;