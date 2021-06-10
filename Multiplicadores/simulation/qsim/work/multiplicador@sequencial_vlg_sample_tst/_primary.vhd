library verilog;
use verilog.vl_types.all;
entity multiplicadorSequencial_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        op1             : in     vl_logic_vector(7 downto 0);
        op2             : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end multiplicadorSequencial_vlg_sample_tst;
