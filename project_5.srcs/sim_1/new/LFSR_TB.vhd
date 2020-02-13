library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity LFSR_tb is
end;

architecture bench of LFSR_tb is

  component LFSR
    Port (
              clk : in std_logic;
              enabled : in std_logic;
              reset : in std_logic;
              seed_values : in std_logic_vector(10 downto 1);
              random_num : out std_logic_vector(10 downto 1)
              );
  end component;

  signal clk: std_logic;
  signal enabled: std_logic;
  signal reset: std_logic;
  signal seed_values: std_logic_vector(10 downto 1);
  signal random_num: std_logic_vector(10 downto 1) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: LFSR port map ( clk         => clk,
                       enabled     => enabled,
                       reset       => reset,
                       seed_values => seed_values,
                       random_num  => random_num );

  stimulus: process
  begin
    -- Put initialisation code here
    stop_the_clock <= false;
    enabled <= '0';
    wait for 10 ns;
    seed_values <= "0101010101";
    enabled <= '1';
    reset <= '1'; -- insert the seed value
    wait for 10 ns;
    reset <= '0'; -- produce from now new random numbers
    wait for 100 ns;
    reset <= '1'; -- insert the seed value
    wait for 10 ns;
    reset <= '0'; -- produce from now new random numbers
    wait for 100 ns;
    -- Put test bench stimulus code here
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