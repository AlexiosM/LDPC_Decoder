--- 7 bit Comparator ---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;
entity Comparator is
    Port (
           clk : in std_logic;
           Probability: in STD_LOGIC_VECTOR (7 downto 1); -- Pi probabilities
           RandomNumFromDRE : in STD_LOGIC_VECTOR (7 downto 1); -- pseudo random number
           StreamToVN : out STD_LOGIC); -- stochastic stream
end Comparator;

architecture Behavioral of Comparator is

begin
    process(clk) is
    begin
        if rising_edge(clk) then
            if Probability > RandomNumFromDRE  then
                StreamToVN <= '1';
            else
                StreamToVN <= '0';
            end if;
        end if;
    end process;
end Behavioral;