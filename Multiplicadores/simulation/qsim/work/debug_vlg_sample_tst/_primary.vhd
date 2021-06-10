library verilog;
use verilog.vl_types.all;
entity debug_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        op1             : in     vl_logic_vector(2 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end debug_vlg_sample_tst;
