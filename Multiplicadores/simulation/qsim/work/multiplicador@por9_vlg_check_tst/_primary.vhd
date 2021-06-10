library verilog;
use verilog.vl_types.all;
entity multiplicadorPor9_vlg_check_tst is
    port(
        resultado       : in     vl_logic_vector(10 downto 0);
        sampler_rx      : in     vl_logic
    );
end multiplicadorPor9_vlg_check_tst;
