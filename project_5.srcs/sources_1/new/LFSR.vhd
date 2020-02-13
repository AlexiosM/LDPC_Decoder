--- Distributed Random Engine ---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;
entity LFSR is
  Port (
            clk : in std_logic;
            enabled : in std_logic;
            reset : in std_logic;
            seed_values : in std_logic_vector(10 downto 1);
            random_num : out std_logic_vector(10 downto 1)
            );
end LFSR;

architecture Behavioral of LFSR is
    signal lfsr_values : std_logic_vector(10 downto 1);
-- 10 -bit LFSR, for maximal length random values we use the polynomial x^10+x^7+1
begin    
    compute_LFSR: process(clk) is
    begin
    if enabled = '1' then
        if rising_edge(clk) then
            if reset = '1' then
                for i in 1 to 10 loop
                    lfsr_values(i) <= seed_values(i);
                end loop;
            else
            lfsr_values(1) <= lfsr_values(7) xor lfsr_values(10);
            for i in 1 to 9 loop
                lfsr_values(i+1) <= lfsr_values(i);
            end loop;
            
            for i in 1 to 10 loop
                random_num(i) <= lfsr_values(i);
            end loop;
            end if;
        end if;
    end if;
    end process compute_LFSR;
end architecture Behavioral;