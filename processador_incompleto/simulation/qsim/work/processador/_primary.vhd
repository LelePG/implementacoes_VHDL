library verilog;
use verilog.vl_types.all;
entity processador is
    port(
        clock           : in     vl_logic;
        comandoEntrada  : in     vl_logic_vector(15 downto 0);
        saidaTeste      : out    vl_logic_vector(7 downto 0)
    );
end processador;
