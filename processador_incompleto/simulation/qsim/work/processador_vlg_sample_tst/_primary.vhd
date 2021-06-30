library verilog;
use verilog.vl_types.all;
entity processador_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        comandoEntrada  : in     vl_logic_vector(15 downto 0);
        sampler_tx      : out    vl_logic
    );
end processador_vlg_sample_tst;
