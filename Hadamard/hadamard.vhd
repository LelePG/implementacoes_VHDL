library ieee;
use ieee.std_logic_1164.all;
--Figura no slide 31 da aula de exemplos do hadamard
entity hadamard is
	generic (TAMANHO: integer :=4);
	port(
	W0,W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14,W15: in std_logic_vector(TAMANHO-1 downto 0);
	clock, reset, enable: in std_logic;
	S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15: out std_logic_vector(TAMANHO-1 downto 0)
	);
		
END hadamard;

architecture hadamardArch of hadamard is
type termosIntermediarios is array (15 downto 0) of std_logic_vector(TAMANHO-1 downto 0);--Cria um tipo matriz para armazenar os elementos
signal saidaW, a,b, saidaB, c: termosIntermediarios; -- cria uma matriz para armazenar os elementos w do hadamard

component barreiraTemporal is
	generic (TAMANHO: integer :=4);
	port (
	entraBarreira0, entraBarreira1,entraBarreira2,entraBarreira3,entraBarreira4,entraBarreira5,entraBarreira6,entraBarreira7,entraBarreira8,
	entraBarreira9,entraBarreira10,entraBarreira11,entraBarreira12,entraBarreira13,entraBarreira14,entraBarreira15: in std_logic_vector(TAMANHO-1 downto 0);
	clock, reset, enable: in std_logic;
	saiBarreira0, saiBarreira1,saiBarreira2,saiBarreira3,saiBarreira4,saiBarreira5,saiBarreira6,saiBarreira7,saiBarreira8,saiBarreira9,
	saiBarreira10,saiBarreira11,saiBarreira12,saiBarreira13,saiBarreira14,saiBarreira15: out std_logic_vector(TAMANHO-1 downto 0)
);
end component;

component somadorNbits is
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;

component subtratorNbits is
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSub: out std_logic_vector(TAMANHO-1 downto 0);
		overflow, negativo: out std_logic
	);
end component;

signal R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15: std_logic_vector(TAMANHO-1 downto 0);

begin
barreiraInicial: barreiraTemporal port map(
	entraBarreira0 => W0,
	entraBarreira1 => W1,
	entraBarreira2 => W2,
	entraBarreira3 => W3,
	entraBarreira4 => W4,
	entraBarreira5 => W5,
	entraBarreira6 => W6,
	entraBarreira7 => W7,
	entraBarreira8 => W8,
	entraBarreira9 => W9,
	entraBarreira10 => W10,
	entraBarreira11 => W11,
	entraBarreira12 => W12,
	entraBarreira13 => W13,
	entraBarreira14 => W14,
	entraBarreira15 => W15,
	clock => clock,
	reset => reset,
	enable => enable, 
	saiBarreira0 => saidaW(0), 
	saiBarreira1 => saidaW(1),
	saiBarreira2 => saidaW(2),
	saiBarreira3 => saidaW(3),
	saiBarreira4 => saidaW(4),
	saiBarreira5 => saidaW(5),
	saiBarreira6 => saidaW(6),
	saiBarreira7 => saidaW(7),
	saiBarreira8 => saidaW(8),
	saiBarreira9 => saidaW(9),
	saiBarreira10 => saidaW(10),
	saiBarreira11 => saidaW(11),
	saiBarreira12 => saidaW(12),
	saiBarreira13 => saidaW(13),
	saiBarreira14 => saidaW(14),
	saiBarreira15 => saidaW(15)
);
--TODO: preencher a com base em saidaW
--TODO: preencher b com base em a
-- Arrumar um jeito de fazer isso de forma otimizada kkk
componenteSomador: somadorNbits port map(
	entrada1 => saidaW(0), 
	entrada2 => saidaW(4),
	resultadoSoma => a(0)
);
componenteSomador1: somadorNbits port map(
	entrada1 => saidaW(8), 
	entrada2 => saidaW(12),
	resultadoSoma => a(1)
);
componenteSomador2: somadorNbits port map(
	entrada1 => saidaW(1), 
	entrada2 => saidaW(5),
	resultadoSoma => a(2)
);
componenteSomador3: somadorNbits port map(
	entrada1 => saidaW(9), 
	entrada2 => saidaW(13),
	resultadoSoma => a(3)
);
componenteSomador4: somadorNbits port map(
	entrada1 => saidaW(2), 
	entrada2 => saidaW(6),
	resultadoSoma => a(4)
);
componenteSomador5: somadorNbits port map(
	entrada1 => saidaW(10), 
	entrada2 => saidaW(14),
	resultadoSoma => a(5)
);
componenteSomador6: somadorNbits port map(
	entrada1 => saidaW(3), 
	entrada2 => saidaW(7),
	resultadoSoma => a(6)
);
componenteSomador7: somadorNbits port map(
	entrada1 => saidaW(11), 
	entrada2 => saidaW(15),
	resultadoSoma => a(7)
);	

componenteSubtrator: subtratorNbits port map(
	entrada1 => saidaW(0), 
	entrada2 => saidaW(4),
	resultadoSub => a(8)
);
componenteSubtrator1: subtratorNbits port map(
	entrada1 => saidaW(8), 
	entrada2 => saidaW(12),
	resultadoSub => a(9)
	);
componenteSubtrator2: subtratorNbits port map(
	entrada1 => saidaW(1), 
	entrada2 => saidaW(5),
	resultadoSub => a(10)
);
componenteSubtrator3: subtratorNbits port map(
	entrada1 => saidaW(9), 
	entrada2 => saidaW(13),
	resultadoSub => a(11)
);
componenteSubtrator4: subtratorNbits port map(
	entrada1 => saidaW(2), 
	entrada2 => saidaW(6),
	resultadoSub => a(12)
);
componenteSubtrator5: subtratorNbits port map(
	entrada1 => saidaW(10), 
	entrada2 => saidaW(14),
	resultadoSub => a(13)
);
componenteSubtrator6: subtratorNbits port map(
	entrada1 => saidaW(3), 
	entrada2 => saidaW(7),
	resultadoSub => a(14)
);
componenteSubtrator7: subtratorNbits port map(
	entrada1 => saidaW(11), 
	entrada2 => saidaW(15),
	resultadoSub => a(15)
);	

componenteSomador8: somadorNbits port map(
	entrada1 => a(0), 
	entrada2 => a(1),
	resultadoSoma => b(0)
);
componenteSomador9: somadorNbits port map(
	entrada1 => a(2), 
	entrada2 => a(3),
	resultadoSoma => b(1)
);
componenteSomador10: somadorNbits port map(
	entrada1 => a(4), 
	entrada2 => a(5),
	resultadoSoma => b(2)
);
componenteSomador11: somadorNbits port map(
	entrada1 => a(6), 
	entrada2 => a(7),
	resultadoSoma => b(3)
);
componenteSomador12: somadorNbits port map(
	entrada1 => a(8), 
	entrada2 => a(9),
	resultadoSoma => b(12)
);
componenteSomador13: somadorNbits port map(
	entrada1 => a(10), 
	entrada2 => a(11),
	resultadoSoma => b(13)
);
componenteSomador14: somadorNbits port map(
	entrada1 => a(12), 
	entrada2 => a(13),
	resultadoSoma => b(14)
);
componenteSomador15: somadorNbits port map(
	entrada1 => a(14), 
	entrada2 => a(15),
	resultadoSoma => b(15)
);	

componenteSubtrator8: subtratorNbits port map(
	entrada1 => a(0), 
	entrada2 => a(1),
	resultadoSub => b(4)
);
componenteSubtrator9: subtratorNbits port map(
	entrada1 => a(2), 
	entrada2 => a(3),
	resultadoSub => b(5)
	);
componenteSubtrator10: subtratorNbits port map(
	entrada1 => a(4), 
	entrada2 => a(5),
	resultadoSub => b(6)
);
componenteSubtrator11: subtratorNbits port map(
	entrada1 => a(6), 
	entrada2 => a(7),
	resultadoSub => b(7)
);
componenteSubtrator12: subtratorNbits port map(
	entrada1 => a(8), 
	entrada2 => a(9),
	resultadoSub => b(8)
);
componenteSubtrator13: subtratorNbits port map(
	entrada1 => a(10), 
	entrada2 => a(11),
	resultadoSub => b(9)
);
componenteSubtrator14: subtratorNbits port map(
	entrada1 => a(12), 
	entrada2 => a(13),
	resultadoSub => b(10)
);
componenteSubtrator15: subtratorNbits port map(
	entrada1 => a(14), 
	entrada2 => a(15),
	resultadoSub => b(11)
);	
		
--Colocar b em uma barreira temporal
barreiraemB: barreiraTemporal port map(
	entraBarreira0 => b(0),
	entraBarreira1 => b(1),
	entraBarreira2 => b(2),
	entraBarreira3 => b(3),
	entraBarreira4 => b(4),
	entraBarreira5 => b(5),
	entraBarreira6 => b(6),
	entraBarreira7 => b(7),
	entraBarreira8 => b(8),
	entraBarreira9 => b(9),
	entraBarreira10 => b(10),
	entraBarreira11=> b(11),
	entraBarreira12 => b(12),
	entraBarreira13 => b(13),
	entraBarreira14 => b(14),
	entraBarreira15 => b(15),
	clock => clock,
	reset => reset,
	enable => enable, 
	saiBarreira0 => saidaB(0), 
	saiBarreira1 => saidaB(1),
	saiBarreira2 => saidaB(2),
	saiBarreira3 => saidaB(3),
	saiBarreira4 => saidaB(4),
	saiBarreira5 => saidaB(5),
	saiBarreira6 => saidaB(6),
	saiBarreira7 => saidaB(7),
	saiBarreira8 => saidaB(8),
	saiBarreira9 => saidaB(9),
	saiBarreira10 => saidaB(10),
	saiBarreira11 => saidaB(11),
	saiBarreira12 => saidaB(12),
	saiBarreira13 => saidaB(13),
	saiBarreira14 => saidaB(14),
	saiBarreira15 => saidaB(15)
);
--calcular c com base em saidaB

componenteSomador16: somadorNbits port map(
	entrada1 => saidaB(0), 
	entrada2 => saidaB(1),
	resultadoSoma => c(0)
);
componenteSomador17: somadorNbits port map(
	entrada1 => saidaB(2), 
	entrada2 => saidaB(3),
	resultadoSoma => c(1)
);
componenteSomador18: somadorNbits port map(
	entrada1 => saidaB(4), 
	entrada2 => saidaB(5),
	resultadoSoma => c(4)
);
componenteSomador19: somadorNbits port map(
	entrada1 => saidaB(6), 
	entrada2 => saidaB(7),
	resultadoSoma => c(5)
);
componenteSomador20: somadorNbits port map(
	entrada1 => saidaB(8), 
	entrada2 => saidaB(9),
	resultadoSoma => c(8)
);
componenteSomador21: somadorNbits port map(
	entrada1 => saidaB(10), 
	entrada2 => saidaB(11),
	resultadoSoma => c(9)
);
componenteSomador22: somadorNbits port map(
	entrada1 => saidaB(12), 
	entrada2 => saidaB(13),
	resultadoSoma => c(12)
);
componenteSomador23: somadorNbits port map(
	entrada1 => saidaB(14), 
	entrada2 => saidaB(15),
	resultadoSoma => c(13)
);	

componenteSubtrator16: subtratorNbits port map(
	entrada1 => saidaB(0), 
	entrada2 => saidaB(1),
	resultadoSub => c(2)
);
componenteSubtrator17: subtratorNbits port map(
	entrada1 => saidaB(2), 
	entrada2 => saidaB(3),
	resultadoSub => c(3)
);
componenteSubtrator18: subtratorNbits port map(
	entrada1 => saidaB(4), 
	entrada2 => saidaB(5),
	resultadoSub => c(6)
);
componenteSubtrator19: subtratorNbits port map(
	entrada1 => saidaB(6), 
	entrada2 => saidaB(7),
	resultadoSub => c(7)
);
componenteSubtrator20: subtratorNbits port map(
	entrada1 => saidaB(8), 
	entrada2 => saidaB(9),
	resultadoSub => c(10)
);
componenteSubtrator21: subtratorNbits port map(
	entrada1 => saidaB(10), 
	entrada2 => saidaB(11),
	resultadoSub => c(11)
);
componenteSubtrator22: subtratorNbits port map(
	entrada1 => saidaB(12), 
	entrada2 => saidaB(13),
	resultadoSub => c(14)
);
componenteSubtrator23: subtratorNbits port map(
	entrada1 => saidaB(14), 
	entrada2 => saidaB(15),
	resultadoSub => c(15)
);	

--calcular s com base em c e colocar S na saída

componenteSomador24: somadorNbits port map(
	entrada1 => c(0), 
	entrada2 => c(1),
	resultadoSoma => R0
);
componenteSomador25: somadorNbits port map(
	entrada1 => c(2), 
	entrada2 => c(3),
	resultadoSoma => R3
);
componenteSomador26: somadorNbits port map(
	entrada1 => c(4), 
	entrada2 => c(5),
	resultadoSoma => R4
);
componenteSomador27: somadorNbits port map(
	entrada1 => c(6), 
	entrada2 => c(7),
	resultadoSoma => R7
);
componenteSomador28: somadorNbits port map(
	entrada1 => c(8), 
	entrada2 => c(9),
	resultadoSoma => R8
);
componenteSomador29: somadorNbits port map(
	entrada1 => c(10), 
	entrada2 => c(11),
	resultadoSoma => R11
);
componenteSomador30: somadorNbits port map(
	entrada1 => c(12), 
	entrada2 => c(13),
	resultadoSoma => R12
);
componenteSomador31: somadorNbits port map(
	entrada1 => c(14), 
	entrada2 => c(15),
	resultadoSoma => R15
);	

componenteSubtrator24: subtratorNbits port map(
	entrada1 => c(0), 
	entrada2 => c(1),
	resultadoSub => R1
);
componenteSubtrator25: subtratorNbits port map(
	entrada1 => c(2), 
	entrada2 => c(3),
	resultadoSub => R2
);
componenteSubtrator26: subtratorNbits port map(
	entrada1 => c(4), 
	entrada2 => c(5),
	resultadoSub => R5
);
componenteSubtrator27: subtratorNbits port map(
	entrada1 => c(6), 
	entrada2 => c(7),
	resultadoSub => R6
);
componenteSubtrator28: subtratorNbits port map(
	entrada1 => c(8), 
	entrada2 => c(9),
	resultadoSub => R9
);
componenteSubtrator29: subtratorNbits port map(
	entrada1 => c(10), 
	entrada2 => c(11),
	resultadoSub => R10
);
componenteSubtrator30: subtratorNbits port map(
	entrada1 => c(12), 
	entrada2 => c(13),
	resultadoSub => R13
);
componenteSubtrator31: subtratorNbits port map(
	entrada1 => c(14), 
	entrada2 => c(15),
	resultadoSub => R14
);

S0 <= R0(3) & R0(3 downto 1);
S1 <= R1(3) & R1(3 downto 1);
S2 <= R2(3) & R2(3 downto 1);
S3 <= R3(3) & R3(3 downto 1);
S4 <= R4(3) & R4(3 downto 1);
S5 <= R5(3) & R5(3 downto 1);
S6 <= R6(3) & R6(3 downto 1);
S7 <= R7(3) & R7(3 downto 1);
S8 <= R8(3) & R8(3 downto 1);
S9 <= R9(3) & R9(3 downto 1);
S10 <= R10(3) & R10(3 downto 1);
S11 <= R11(3) & R11(3 downto 1);
S12 <= R12(3) & R12(3 downto 1);
S13 <= R13(3) & R13(3 downto 1);
S14 <= R14(3) & R14(3 downto 1);
S15 <= R15(3) & R15(3 downto 1);

end hadamardArch;