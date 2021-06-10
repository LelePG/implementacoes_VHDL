library verilog;
use verilog.vl_types.all;
entity multiplicadorSequencial_vlg_check_tst is
    port(
        estado          : in     vl_logic_vector(3 downto 0);
        resultado       : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end multiplicadorSequencial_vlg_check_tst;
