
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ParityNode_tb is
end;

architecture bench of ParityNode_tb is

  component ParityNode
      Port ( input : in STD_LOGIC_VECTOR (3 downto 1);
             clk : in STD_LOGIC;
             parity_check_satisfied : out STD_LOGIC;
             output : out STD_LOGIC_VECTOR (3 downto 1));
  end component;

  signal input: STD_LOGIC_VECTOR (3 downto 1);
  signal clk: STD_LOGIC;
  signal parity_check_satisfied: STD_LOGIC;
  signal output: STD_LOGIC_VECTOR (3 downto 1);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: ParityNode port map ( input => input,
                            clk  => clk,
                            parity_check_satisfied => parity_check_satisfied,
                            output => output );

  stimulus: process
  begin
    stop_the_clock <= false;
    input <= "110";
    wait for 10 ns;
    input <= "011";
    wait for 10 ns;
    input <= "010";
    wait for 10 ns;
    input <= "111";
    wait for 10 ns;
    input <= "101";
    wait for 10 ns;
    input <= "010";
    wait for 10 ns;
    input <= "000";
    wait for 10 ns;
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;