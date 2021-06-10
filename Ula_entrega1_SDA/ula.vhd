library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Estrutura parcial da ULA sem a implementação do banco de registradores (falta a implementação do banco e dos decodificadores, que serão implementados na próxima entrega
entity ula is 
port (
	opcode: in std_logic_vector(5 downto 0);
	rs: in std_logic_vector(31 downto 0);
	rt: in std_logic_vector(31 downto 0);
	rd: out std_logic_vector(31 downto 0);
	shamt: in std_logic_vector(4 downto 0);
	funct: in std_logic_vector(5 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end ula;

architecture ulaArch of ula is

component ulaOperacoes is 
generic(TAMANHO: integer:= 32);
port (
	funct: in std_logic_vector(5 downto 0);
	registradorA: in std_logic_vector(TAMANHO-1 downto 0);
	registradorB: in std_logic_vector(TAMANHO-1 downto 0);
	registradorDest: out std_logic_vector(TAMANHO-1 downto 0);
	overflow, carryOut, zero, negativo: out std_logic
);
end component;

begin

operacoesDaUla: ulaOperacoes port map (
	funct => funct,
	registradorA => rs,
	registradorB => rt,
	registradorDest => rd,
	overflow => overflow,
	carryOut => carryOut,
	zero => zero,
	negativo => negativo
	);

end ulaArch;
  