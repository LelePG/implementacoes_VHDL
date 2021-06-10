library verilog;
use verilog.vl_types.all;
entity ula_vlg_check_tst is
    port(
        carryOut        : in     vl_logic;
        negativo        : in     vl_logic;
        overflow        : in     vl_logic;
        rd              : in     vl_logic_vector(31 downto 0);
        zero            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ula_vlg_check_tst;
