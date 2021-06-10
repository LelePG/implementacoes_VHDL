library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity topUlaTestbench is 
end topUlaTestbench;

architecture topUlaTestbenchArch of topUlaTestbench is
component bancoRegistrador is
	generic (TOTALREGS: integer :=32; TAMANHO: integer := 32);
	port(
		cargaExterna: in std_logic_vector(TAMANHO -1 downto 0);
		ULAresultado: out std_logic_vector(TAMANHO-1 downto 0);
		opcode: in std_logic_vector(5 downto 0);
		rs: in std_logic_vector(4 downto 0);
		rt: in std_logic_vector(4 downto 0);
		rd: in std_logic_vector(4 downto 0);
		shamt: in std_logic_vector(4 downto 0);
		funct: in std_logic_vector(5 downto 0);
		overflow, carryOut, zero, negativo: out std_logic;
		clock, reset, cargaControl : in std_logic		
	);	
end component;

--inputs
signal sinalOpcode, sinalFunct: std_logic_vector(5 downto 0) :=(others =>'0');
signal sinalRs,sinalRt,sinalRd,sinalShamt: std_logic_vector(4 downto 0) :=(others =>'0');
signal sinalOverflow, sinalCarryOut, sinalZero, sinalNegativo, sinalClock, sinalReset, sinalCargaControl: std_logic := '0';
signal cargaExterna, resultadoULA : std_logic_vector(31 downto 0);

begin

	instancia: bancoRegistrador port map(
			cargaExterna => cargaExterna,
			ULAresultado=> resultadoULA,
			opcode => sinalOpcode,
			rs => sinalRs,
			rt => sinalRt,
			rd => sinalRd,
			shamt => sinalShamt,
			funct => sinalFunct,
			overflow => sinalOverflow,
			carryOut => sinalCarryOut,
			zero => sinalZero,
			negativo => sinalNegativo,
			clock => sinalclock,
			reset => sinalReset,
			cargaControl => sinalCargaControl
		);
		
	sinalReset <= '0', '1' AFTER 50 ps;
	
	clock: process
	begin
	  sinalclock <= '1', '0' AFTER 5 ps;
  wait for 10 ps;
  end process;
  
  testBench: process
  begin
    cargaExterna <= x"0000000F";
    sinalRs <= "00011";
		sinalRt <= "00011";
   	sinalRd <= "00011";
   	
   	--Soma de A+B com carga externa
   	sinalfunct <= "000001";
   	sinalCargaControl <= '1';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000"; 
   	wait for 100ps;
   	
   	sinalRd <= "00010";
   	cargaExterna <= x"00000003";
   	wait for 50ps;

    --Soma de A+B sem carga externa
    sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00011";
   	sinalfunct <= "000001";
   	sinalCargaControl <= '0';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000";
   	wait for 50ps;
   	
   	--Subtração de A-B sem carga externa
 	  sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00011";
   	sinalfunct <= "000010";
   	sinalCargaControl <= '0';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000";
   	wait for 50ps;
   	
   	--(a and b) or (not b) sem carga externa
 	  sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00100";
   	sinalfunct <= "000100";
   	sinalCargaControl <= '0';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000";
   	wait for 50ps;
   	
   	--(a and b) com carga externa
 	  sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00101";
   	sinalfunct <= "001000";
   	sinalCargaControl <= '1';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000"; 
   	wait for 50ps;
   	
   	--(a xor b) sem carga externa
 	  sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00101";
   	sinalfunct <= "010000";
   	sinalCargaControl <= '0';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000"; 
   	wait for 50ps; 	
   	
   	--not a sem carga externa
 	  sinalRs <= "00010";
		sinalRt <= "00001";
   	sinalRd <= "00101";
   	sinalfunct <= "010000";
   	sinalCargaControl <= '0';
   	sinalShamt <= "00000";
   	sinalOpcode <= "000000"; 
   	wait for 50ps; 	
   	wait; 	
  end process;

end topUlaTestbenchArch;