library verilog;
use verilog.vl_types.all;
entity multiplicadorMatricial is
    port(
        op1             : in     vl_logic_vector(7 downto 0);
        op2             : in     vl_logic_vector(7 downto 0);
        resultado       : out    vl_logic_vector(15 downto 0)
    );
end multiplicadorMatricial;
