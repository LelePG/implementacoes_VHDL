library verilog;
use verilog.vl_types.all;
entity multiplicadorPor9_vlg_sample_tst is
    port(
        op1             : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end multiplicadorPor9_vlg_sample_tst;
