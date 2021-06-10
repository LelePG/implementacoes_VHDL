library verilog;
use verilog.vl_types.all;
entity multiplicadorPor9 is
    port(
        op1             : in     vl_logic_vector(7 downto 0);
        resultado       : out    vl_logic_vector(10 downto 0)
    );
end multiplicadorPor9;
