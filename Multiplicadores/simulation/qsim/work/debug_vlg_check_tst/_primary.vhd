library verilog;
use verilog.vl_types.all;
entity debug_vlg_check_tst is
    port(
        entrada1ULA     : in     vl_logic_vector(2 downto 0);
        entrada2ULA     : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end debug_vlg_check_tst;
