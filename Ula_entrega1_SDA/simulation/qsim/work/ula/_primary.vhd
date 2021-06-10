library verilog;
use verilog.vl_types.all;
entity ula is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        rs              : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(31 downto 0);
        rd              : out    vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        overflow        : out    vl_logic;
        carryOut        : out    vl_logic;
        zero            : out    vl_logic;
        negativo        : out    vl_logic
    );
end ula;
