library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EM_tb is
end;

architecture bench of EM_tb is

  component EM
      Port (
          clk : in std_logic;
          random_address : in std_logic_vector(5 downto 1);
          input : in std_logic;
          update : in std_logic;
          reset_EM : in std_logic;
          output : out std_logic
          );
  end component;

  signal clk: std_logic;
  signal random_address: std_logic_vector(5 downto 1);
  signal input: std_logic;
  signal update: std_logic;
  signal reset_EM : std_logic;
  signal output: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: EM port map ( clk            => clk,
                     random_address => random_address,
                     input          => input,
                     update         => update,
                     reset_EM       => reset_EM,
                     output         => output );

  stimulus: process
  begin
    update<='1'; -- non-hold, use memory as shift register
    reset_EM <= '0';
    wait for 10 ns;
    reset_EM <= '0';
    random_address <= "00000";
    for i in 1 to 16 loop
        input <= '1';
        wait for 10 ns;
    end loop;
    for i in 1 to 16 loop
        input <= '0';
        wait for 10 ns;
    end loop;
    update <= '0';
    random_address <= "00001";
    wait for 10 ns;
    random_address <= "10111";
    wait for 10 ns;
    random_address <= "10001";
    wait for 10 ns;
    random_address <= "11111";
    wait for 10 ns;
    random_address <= "00001";
    wait for 10 ns;
    random_address <= "01001";
    wait for 10 ns;
    random_address <= "10111";
    wait for 10 ns;
    random_address <= "10001";
    wait for 10 ns;
    random_address <= "11111";
    wait for 10 ns;
    random_address <= "00001";
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