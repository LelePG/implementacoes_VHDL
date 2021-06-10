library verilog;
use verilog.vl_types.all;
entity multiplicadorSequencial is
    port(
        op1             : in     vl_logic_vector(7 downto 0);
        op2             : in     vl_logic_vector(7 downto 0);
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        estado          : out    vl_logic_vector(3 downto 0);
        resultado       : out    vl_logic_vector(15 downto 0)
    );
end multiplicadorSequencial;
