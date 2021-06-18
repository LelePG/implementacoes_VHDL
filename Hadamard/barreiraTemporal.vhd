library ieee;
use ieee.std_logic_1164.all;
entity barreiraTemporal is

	generic (TAMANHO: integer :=4);
	port (
	entraBarreira0, entraBarreira1,entraBarreira2,entraBarreira3,entraBarreira4,entraBarreira5,entraBarreira6,entraBarreira7,entraBarreira8,
	entraBarreira9,entraBarreira10,entraBarreira11,entraBarreira12,entraBarreira13,entraBarreira14,entraBarreira15: in std_logic_vector(TAMANHO-1 downto 0);
	clock, reset, enable: in std_logic;
	saiBarreira0, saiBarreira1,saiBarreira2,saiBarreira3,saiBarreira4,saiBarreira5,saiBarreira6,saiBarreira7,saiBarreira8,saiBarreira9,
	saiBarreira10,saiBarreira11,saiBarreira12,saiBarreira13,saiBarreira14,saiBarreira15: out std_logic_vector(TAMANHO-1 downto 0)
	);
		
END barreiraTemporal;

architecture barreiraTemporalArch of barreiraTemporal is
component registrador is
	port (
		d: in std_logic_vector (TAMANHO - 1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO - 1 downto 0)
	);
	end component;
	
	begin
	
	reg0: registrador port map(
		d=> entraBarreira0,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira0
		);
		
	reg1: registrador port map(
		d=> entraBarreira1,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira1
		);
		
	reg2: registrador port map(
		d=> entraBarreira2,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira2
		);
		
	reg3: registrador port map(
		d=> entraBarreira3,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira3
		);
	
	reg4: registrador port map(
		d=> entraBarreira4,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira4
		);
	
	reg5: registrador port map(
		d=> entraBarreira5,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira5
		);
	
	reg6: registrador port map(
		d=> entraBarreira6,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira6
		);
	
	reg7: registrador port map(
		d=> entraBarreira7,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira7
		);
	
	reg8: registrador port map(
		d=> entraBarreira8,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira8
		);
	
	reg9: registrador port map(
		d=> entraBarreira9,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira9
		);
	
	reg10: registrador port map(
		d=> entraBarreira10,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira10
		);
	
	reg11: registrador port map(
		d=> entraBarreira11,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira11
		);
	
	reg12: registrador port map(
		d=> entraBarreira12,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira12
		);
		
	reg13: registrador port map(
		d=> entraBarreira13,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira13
		);
		
	reg14: registrador port map(
		d=> entraBarreira14,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira14
		);
		
	reg15: registrador port map(
		d=> entraBarreira15,
		reset => reset, 
		clock => clock, 
		enable => enable,
		q=>saiBarreira15
		);
	
	--Saudades for generate...
end barreiraTemporalArch;