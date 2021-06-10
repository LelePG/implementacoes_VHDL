library verilog;
use verilog.vl_types.all;
entity multiplicadorMatricial_vlg_sample_tst is
    port(
        op1             : in     vl_logic_vector(7 downto 0);
        op2             : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end multiplicadorMatricial_vlg_sample_tst;
