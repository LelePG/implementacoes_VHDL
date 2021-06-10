library verilog;
use verilog.vl_types.all;
entity multiplicadorMatricial_vlg_check_tst is
    port(
        resultado       : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end multiplicadorMatricial_vlg_check_tst;
