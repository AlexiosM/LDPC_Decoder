--- Parity Node ---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;
entity ParityNode is
    Port ( input : in STD_LOGIC_VECTOR (3 downto 1);
           clk : in STD_LOGIC;
           parity_check_satisfied : out STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 1));
end ParityNode;

architecture Behavioral of ParityNode is
    signal xor_outputs : std_logic_vector(3 downto 1);
    signal xor_summary_output : std_logic;
begin
    xor_summary_output <= input(1) xor input(2) xor input(3);
    process(clk) is
    begin
    if rising_edge(clk) then
        internal_xor:for i in 1 to 3 loop
            xor_outputs(i) <= xor_summary_output xor input(i);
        end loop internal_xor;
        -- parity check outputs   
        parity_check_satisfied <= xor_summary_output;
        for i in 1 to 3 loop
            output(i) <= xor_outputs(i);
        end loop;
    end if;
    end process;
end Behavioral;
