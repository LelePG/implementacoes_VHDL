library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is 
generic(TAMANHO: integer:= 8);
port (
clock: in std_logic;
comandoEntrada: in std_logic_vector(15 downto 0);
saidaTeste: out std_logic_vector(7 downto 0)
);
end processador;

architecture processadorArch of processador is
type ram_t is array (255 downto 0) of std_logic_vector(7 downto 0);
signal memoria : ram_t:= (others => (others => '0'));
signal entradaRegA, entradaRegB, saidaRegA, saidaRegB, entradaRegULA, saidaRegULA: std_logic_vector(TAMANHO-1 downto 0); --sinaisdos registradores
signal PC, sinalsaidaTeste, operandoA, operandoB, regAux: std_logic_vector(7 downto 0);
signal opCarregaA, opCarregaB, opLoad, opStore, opSub, opJump, opBeq, opXor, opAnd, opOr, opAdd, opPadrao: std_logic_vector(7 downto 0);  
signal sinalOverflow, sinalcarryOut, sinalZero, sinalNegativo: std_logic; --outputs da ULA
signal sinalControlMuxA, sinalControlMuxB: std_logic;--sinais do mux
signal sinalEscrita: std_logic;--sinal de escrita
signal sinalOperacao: std_logic_vector(4 downto 0);

component ulaOperacoes is 
port (
	funct: in std_logic_vector(4 downto 0);
	registradorA: in std_logic_vector(TAMANHO-1 downto 0);
	registradorB: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(TAMANHO-1 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end component;

component mux21 is 
	port (
		entrada0, entrada1 : in std_logic_vector(TAMANHO-1 downto 0);
		control: in std_logic;
		saida: out std_logic_vector(TAMANHO -1 downto 0)  
	);
end component;

component registrador is
	port (
		d: in std_logic_vector (TAMANHO - 1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO - 1 downto 0)
	);
	
END component;

begin

 --definições das constantes 
opCarregaA <= "00110000";
opCarregaB <= "11000000";
opLoad <= "00000001";
opStore <= "00000010";
opAdd <= "00000100";
opSub <= "00001000";
opJump <= "00010000";
opBeq <= "00100000";
opXor <= "01000000";
opAnd <= "10000000";
opOr <= "00000011";
opPadrao <= "00000000";
--inicializando a memória com um programa disponível na pasta do projeto
--a = 5
memoria(151) <= opCarregaA;
memoria(152) <= "00000101";
--b =5
memoria(153) <= opCarregaB;
memoria(154) <= "00000101";

--c = a+b e salva na memória 
memoria(155) <= opAdd;
memoria(156) <= opPadrao;
memoria(157) <= opLoad;
memoria(158) <= "00000001";

--d = a and b e salva na memória 
memoria(159) <= opAnd;
memoria(160) <= opPadrao;
memoria(161) <= opLoad;
memoria(162) <= "00000010";

--e = a - b e salva na memória 
memoria(163) <= opsub;
memoria(164) <= opPadrao;
memoria(165) <= opLoad;
memoria(166) <= "00000011";

--f = a xor b e salva na memória 
memoria(167) <= opXor;
memoria(168) <= opPadrao;
memoria(169) <= opLoad;
memoria(170) <= "00000100";

--g = a or b e salva na memória 
memoria(171) <= opOr;
memoria(172) <= opPadrao;
memoria(173) <= opLoad;
memoria(174) <= "00000101";

--carregar c pro registrador
memoria(175) <= opLoad;
memoria(176) <= "00000001";

--soma os registradores
memoria(177) <= opAdd;
memoria(178) <= opPadrao;

--pega o resultado e soma com C novamente
memoria(179) <= opAdd;
memoria(180) <= "00000001";

--salva o valor na memória
memoria(181) <= opStore;
memoria(182) <= "00001000";


regA: registrador port map(
		d=> entradaRegA,
		reset=> '0',
		clock=> clock,
		enable=> '1',
		q=> saidaRegA
);

regB: registrador port map(
		d=> entradaRegB,
		reset=> '0',
		clock=> clock,
		enable=> '1',
		q=> saidaRegB
);

regUla: registrador port map(
		d=> entradaRegULA,
		reset=> '0',
		clock=> clock,
		enable=> '1',
		q=> saidaRegULA
);
muxA: mux21 port map(
	entrada0 => saidaRegA,
	entrada1 => saidaRegULA,
	control => sinalControlMuxA,
	saida => operandoA
);

muxB: mux21 port map(
	entrada0 => saidaRegB,
	entrada1 => saidaRegULA,
	control => sinalControlMuxB,
	saida => operandoB
);

operacoesDaUla: ulaOperacoes port map (
	funct => sinalOperacao,
	registradorA => operandoA,
	registradorB => operandoB,
	resultado => entradaRegULA,
	overflow => sinalOverflow,
	carryOut => sinalCarryOut,
	zero => sinalZero,
	negativo => sinalNegativo
	);



process(comandoEntrada, clock)--maquina de estados
begin
		if (rising_edge(clock)) then -- alterações na memória RAM só vão acontecer na borda de subida
			case comandoEntrada(15 downto 8) is
				when "11000000" =>
					entradaRegB <= comandoEntrada(7 downto 0); -- preenchimento de Regb com uma carga externa
				when "00110000" =>
					entradaRegA <= comandoEntrada(7 downto 0); -- preenchimento de RegA com uma carga externa
				when "00000001" =>--load OK
				sinalEscrita <= '0'; -- por algum motivo tava acontecendo escrita nessa memória, colocando essas restrições, fica tudo ok
					entradaRegA <= memoria(to_integer(signed(comandoEntrada(7 downto 0)))); 
				sinalEscrita <= '1';
				when "00000010" =>--store OK
				if (sinalEscrita = '1') then 
					memoria(to_integer(signed(comandoEntrada(7 downto 0))))  <= saidaRegULA;
				end if;
				when "00000100" =>--add OK
					sinalOperacao <= "00001"; --operacao de soma
					sinalControlMuxA <= comandoEntrada(1);
					sinalControlMuxB <= comandoEntrada(0);
				when "00001000" =>--sub OK
					sinalOperacao <= "00010";
					sinalControlMuxA <= comandoEntrada(1);
					sinalControlMuxB <= comandoEntrada(0);
				when "00010000" =>--jump
					regAux <= regAux;--FAZER
				when "00100000" =>--beq
					regAux <= regAux; --FAZER
				when "01000000" =>--xor OK
					sinalOperacao <=  "00100";
					sinalControlMuxA <= comandoEntrada(1);
					sinalControlMuxB <= comandoEntrada(0);
				when "10000000" =>--and OK
					sinalOperacao <=  "01000";
					sinalControlMuxA <= comandoEntrada(1);
					sinalControlMuxB <= comandoEntrada(0);
				when "00000011" =>--or OK
					sinalOperacao <=  "10000";
					sinalControlMuxA <= comandoEntrada(1);
					sinalControlMuxB <= ComandoEntrada(0);
				when others =>
				regAux <= regAux;
			end case;
		saidaTeste <= saidaRegULA;
		end if;
end process;
end processadorArch;
