library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoRegistrador is
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
end bancoRegistrador;

architecture bancoRegistradorArch of bancoRegistrador is

component registrador is
	port (
		d: in std_logic_vector (TAMANHO - 1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO - 1 downto 0)
	);
	
end component;

component ulaOperacoes is 
generic(TAMANHO: integer:= 32);
port (
	funct: in std_logic_vector(5 downto 0);
	registradorA: in std_logic_vector(TAMANHO-1 downto 0);
	registradorB: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(TAMANHO-1 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end component;

signal saida_dec: std_logic_vector(TOTALREGS -1 downto 0);	
--signal vetorEnable: std_logic_vector(TOTALREGS -1 downto 0);
type matrizDoMux is array (TOTALREGS -1 downto 0) of std_logic_vector(TAMANHO-1 downto 0);--Cria um tipo matriz para armazenar todos os ourputs dos registradores
signal entradaDoMux : matrizDoMux;	--cria uma coisa entradaDoMux do tipo matrizDoMux
signal valorRs, valorRt, resultadoULA, aux_carga: std_logic_vector(TAMANHO - 1 downto 0);


begin
	
	banco: for i in 0 to TOTALREGS-1 generate--ImplementaÃ§Ã£o do banco em si
		registradorX: registrador port map(
		d=> aux_carga,
		clock => clock,
		reset => reset,
		enable => saida_dec(i),
		q=>entradaDoMux(i));
	end generate banco;

	
	with cargaControl select
	     aux_carga <= resultadoULA when '0',
	                  cargaExterna when others;

	process(rt,rs)
	begin
		valorRs <= entradaDoMux(to_integer(unsigned(rt)));
		valorRt <= entradaDoMux(to_integer(unsigned(rs)));
	end process;
	
	
	
	process(rd )
	begin
		case rd is
		   when "00000" => saida_dec <= "00000000000000000000000000000001";
		   when "00001" => saida_dec <= "00000000000000000000000000000010";
		   when "00010" => saida_dec <= "00000000000000000000000000000100";
		   when "00011" => saida_dec <= "00000000000000000000000000001000";  
		   when "00100" => saida_dec <= "00000000000000000000000000010000";
		   when "00101" => saida_dec <= "00000000000000000000000000100000";
		   when "00110" => saida_dec <= "00000000000000000000000001000000";
		   when "00111" => saida_dec <= "00000000000000000000000010000000";  
		   when "01000" => saida_dec <= "00000000000000000000000100000000";
		   when "01001" => saida_dec <= "00000000000000000000001000000000";
		   when "01010" => saida_dec <= "00000000000000000000010000000000";
		   when "01011" => saida_dec <= "00000000000000000000100000000000";  
		   when "01100" => saida_dec <= "00000000000000000001000000000000";
		   when "01101" => saida_dec <= "00000000000000000010000000000000";
		   when "01110" => saida_dec <= "00000000000000000100000000000000";
		   when "01111" => saida_dec <= "00000000000000001000000000000000";  
		   when "10000" => saida_dec <= "0000000000000001000000000000000";
		   when "10001" => saida_dec <= "00000000000000100000000000000000";
		   when "10010" => saida_dec <= "00000000000001000000000000000000";
		   when "10011" => saida_dec <= "00000000000010000000000000000000";  
		   when "10100" => saida_dec <= "00000000000100000000000000000000";
		   when "10101" => saida_dec <= "00000000001000000000000000000000";
		   when "10110" => saida_dec <= "00000000010000000000000000000000";
		   when "10111" => saida_dec <= "00000000100000000000000000000000";  
		   when "11000" => saida_dec <= "00000001000000000000000000000000";
		   when "11001" => saida_dec <= "00000010000000000000000000000000";
		   when "11010" => saida_dec <= "00000100000000000000000000000000";
		   when "11011" => saida_dec <= "00001000000000000000000000000000";  
		   when "11100" => saida_dec <= "00010000000000000000000000000000";
		   when "11101" => saida_dec <= "00100000000000000000000000000000";
		   when "11110" => saida_dec <= "01000000000000000000000000000000";
		   when "11111" => saida_dec <= "10000000000000000000000000000000";  
		   when others  => saida_dec <= "00000000000000000000000000000000";
		  end case;
		end process;
				     

	
	
	--ExecuÃ§Ã£o da operaÃ§Ã£o
	operacoesDaUla: ulaOperacoes port map (
	funct => funct,
	registradorA => valorRs,--Resultado saÃ­da do mux rs
	registradorB => valorRt,--Resultado saida do mux rt
	resultado => resultadoULA,
	overflow => overflow,
	carryOut => carryOut,
	zero => zero,
	negativo => negativo
	);
	ULAresultado<=resultadoULA;
end bancoRegistradorArch;