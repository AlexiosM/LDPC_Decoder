library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.all;
--use ieee.std_logic_arith.all;

entity UpDownSatCounter is
    Port ( clk : in STD_LOGIC;
           clear : in STD_LOGIC;
           VN_output_bit_1st : in STD_LOGIC; --1st instance
           VN_output_bit_2nd : in STD_LOGIC; --2nd instance
           sign_bit : out STD_LOGIC);
end UpDownSatCounter;

architecture Behavioral of UpDownSatCounter is
signal counter : signed(4 downto 1) := "0000";
constant upper : signed(4 downto 1) := "0110"; -- = 6
constant lower : signed(4 downto 1) := "1110"; -- = -6
begin
process(clk) is
begin
if rising_edge(clk) then
    if clear = '1' then
        counter <= "0000";
    else
        if  VN_output_bit_1st = '1' and VN_output_bit_2nd = '1' then
            if counter <= upper then
                counter <= counter + 2;
            end if;
        else if VN_output_bit_1st = '0' and VN_output_bit_2nd = '0' then
            if counter >= lower then
                counter <= counter - 2;
            end if;
        end if;
    end if;
        if counter >= 0 then
            sign_bit <= '0'; -- determines +1 decoded bit
        else
            sign_bit <= '1'; -- determines -1 decoded bit
        end if;
    end if;
end if;
end process;
end Behavioral;