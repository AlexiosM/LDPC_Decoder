--- Edge Memory ---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.all;
entity EM is
    Port (
        clk : in std_logic;
        random_address : in std_logic_vector(5 downto 1);
        input : in std_logic;
        update : in std_logic;
        reset_EM : in std_logic;
        output : out std_logic
        );
end EM;

architecture em_behavior of EM is
    signal d : std_logic_vector(32 downto 1);
begin
process(clk,reset_EM)
    begin
    if rising_edge(clk) then
        if reset_EM = '1' then
            d <= x"00000000";
        end if;
        if update = '0' then -- hold state (conservative bits)
            output <= d(to_integer(unsigned(random_address))+1);-- 32 to 1 multiplexer (select of 5 signals)
        else -- non hold state (regenerative)
            d <= input&d(32 downto 2); -- Assume  input->|32|31|...|2|1|->outputs
            d(32)<= input;
        end if;
    end if;
end process;
end em_behavior;