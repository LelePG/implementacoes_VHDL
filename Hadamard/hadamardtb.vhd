library ieee;
use ieee.std_logic_1164.all;
--Figura no slide 31 da aula de exemplos do hadamard
entity hadamardtb is	
END hadamardtb;

architecture hadamardArch of hadamardtb is
constant TAMANHO: integer :=4;

component hadamard is
	generic (TAMANHO: integer :=4);
	port(
	W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14,W15: in std_logic_vector(TAMANHO-1 downto 0);
	clock, reset, enable: in std_logic;
	S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15: out std_logic_vector(TAMANHO-1 downto 0)
	);
		
END component;

signal W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14,W15: std_logic_vector(TAMANHO-1 downto 0);
signal clock, reset, enable: std_logic;
signal	S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15: std_logic_vector(TAMANHO-1 downto 0);

begin 
  uut: hadamard port map (
    W0 => W0,
    W1 => W1,
    W2 => W2,
    W3 => W3,
    W4 => W4,
    W5 => W5,
    W6 => W6,
    W7 => W7,
    W8 => W8,
    W9 => W9,
    W10 => W10,
    W11 => W11,
    W12 => W12,
    W13 => W13,
    W14 => W14,
    W15 => W15,
    clock => clock,
    reset => reset,
    enable => enable,
    S0 => S0,
    S1 => S1,
    S2 => S2,
    S3 => S3,
    S4 => S4,
    S5 => S5,
    S6 => S6,
    S7 => S7,
    S8 => S8,
    S9 => S9,
    S10 => S10,
    S11 => S11,
    S12 => S12,
    S13 => S13,
    S14 => S14,
    S15 => S15
);
    
  process 
    begin 
      clock <= '1', '0' after 5ns;
      wait for 10ns; 
  end process; 
  
  reset <= '0', '1' after 15ns;
  
  process
    begin
      W0 <= "0010";
      W1 <= "0010";
      W2 <= "0010";
      W3 <= "0010";
      W4 <= "0010";
      W5 <= "0010";
      W6 <= "0010";
      W7 <= "0010";
      W8 <= "0010";
      W9 <= "0010";
      W10 <= "0010";
      W11 <= "0010";
      W12 <= "0010";
      W13 <= "0010";
      W14 <= "0010";
      W15 <= "0010";
      enable <= '1';
    wait;      
    end process;
   
end hadamardArch;