# Trabalho proposto: 
Processador arquitetura RISC (Von Neumann) com palavra de 8 bits, instruções 8 bits, instruções: load, store, add, sub, Jump, Beq, XOR,AND,OR.

A memória do processador é composta por 256 posições de 8 bits na estrutura de uma memória RAM, tendo os endereços 0-150 reservados para  dados e os endereços 151-254  reservados para instruções.
As instruções definidas, e seus respectivos códigos com o opcode marcado em vermelho, são:

- Carregar algum valor externo pra RA - 00110000 xxxxxxxx (valor que vai ser carregado no registrador)
- Carregar algum valor externo pra RB - 11000000 xxxxxxxx (valor que vai ser carregado no registrador)
- Load - 00000001 RRRRRRRR (endereço do registrador)
- Store - 00000010 RRRRRRRR (endereço do registrador)
- Add - 00000100  XXXXXXAB (onde A e B controlam os muxes que definem os operandos de entrada na ULA)
- Sub - 00001000 XXXXXXAB (onde A e B controlam os muxes que definem os operandos de entrada na ULA)
- Jump - 00010000
- Beq - 00100000
- Xor - 01000000  XXXXXXAB (onde A e B controlam os muxes que definem os operandos de entrada na ULA)
- And - 1000000  XXXXXXAB (onde A e B controlam os muxes que definem os operandos de entrada na ULA)
- Or  - 00000011  XXXXXXAB (onde A e B controlam os muxes que definem os operandos de entrada na ULA)

O bit chamado de A na segunda parte das instruções de Add, Sub, Xor, And e Or seleciona o resultado o Mux a, que define a primeira entrada da ULA, sendo 0 o valor para utilizar o operando guardado no registrador A, e 1 o valor para utilizar a própria saída da ULA. O mesmo vale para o bit B, que seleciona a entrada do Mux do operando B da ULA, entre o valor o registrador B e a própria saída da ULA.

Um programa já foi carregado na memória manualmente para testar as funcionalidades do processador.

**Obs:** A minha dupla não me retornou a versão finalizada do trabalho.

