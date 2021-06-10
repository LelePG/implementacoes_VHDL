library verilog;
use verilog.vl_types.all;
entity debug is
    port(
        op1             : in     vl_logic_vector(2 downto 0);
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        entrada2ULA     : out    vl_logic_vector(2 downto 0);
        entrada1ULA     : out    vl_logic_vector(2 downto 0)
    );
end debug;
