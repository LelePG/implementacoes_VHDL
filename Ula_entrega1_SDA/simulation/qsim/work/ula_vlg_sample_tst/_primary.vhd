library verilog;
use verilog.vl_types.all;
entity ula_vlg_sample_tst is
    port(
        funct           : in     vl_logic_vector(5 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0);
        rs              : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end ula_vlg_sample_tst;
