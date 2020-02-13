library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;
use work.all;
-- after 128 DCs (128 bitstream lenght) iterations for VNs-CNs will take place. 
-- Process (load of new bitstreams) will continue after termination creteria of previous
entity StochasticStreamCreator is
    Port (  clk : in std_logic;
            LFSR_enable : in std_logic;
            LFSR_rst : in std_logic;
            LFSR_seed : in std_logic_vector(10 downto 1);
            new_Pi_value : in std_logic_vector(7 downto 1);
            output_of_lfsr_7bits : out std_logic_vector(7 downto 1);
            StochasticStream : out std_logic); 
end StochasticStreamCreator;

architecture Behavioral of StochasticStreamCreator is
component Comparator is
    Port ( clk : in std_logic;
           Probability: in STD_LOGIC_VECTOR (7 downto 1); -- Pi probabilities
           RandomNumFromDRE : in STD_LOGIC_VECTOR (7 downto 1); -- pseudo random number
           StreamToVN : out STD_LOGIC); -- stochastic stream
end component;
component LFSR is Port(
    clk : in std_logic;
    enabled : in std_logic;
    reset : in std_logic;
    seed_values : in std_logic_vector(10 downto 1);
    random_num : out std_logic_vector(10 downto 1)
);
end component;
signal random_number_for_comparison: std_logic_vector(7 downto 1); -- changes at each clock
signal output_of_lfsr : std_logic_vector(10 downto 1);
signal output_of_lfsr_tmp : std_logic_vector(7 downto 1);
signal Pi_value : std_logic_vector(7 downto 1);

begin
RandomGenerator: LFSR port map(clk=>clk,
                                enabled=>LFSR_enable,
                                reset=>LFSR_rst,
                                seed_values=>LFSR_seed,
                                random_num=>output_of_lfsr);
                                
Pi_RandomNumComparator: Comparator port map( clk=>clk,
                                    Probability=>Pi_value,
                                    RandomNumFromDRE=>random_number_for_comparison,
                                    StreamToVN=>StochasticStream);

inputs_to_comparator: process(clk)
    variable clk_counter : integer := 128;
    begin
        output_of_lfsr_tmp <= output_of_lfsr(7 downto 1);
        output_of_lfsr_7bits <= output_of_lfsr(7 downto 1); -- extra output for wave
        if rising_edge(clk) then
            random_number_for_comparison <= output_of_lfsr_tmp; -- use only 7 bits for the comparison for each DC
            if clk_counter = 128 then
                Pi_value <= new_Pi_value;-- ???????????????
                clk_counter := 0;
            else
                clk_counter := clk_counter + 1;

            end if;
        end if;
    end process;
end Behavioral;
