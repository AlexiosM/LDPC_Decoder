library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity UpDownSatCounter_tb is
end;

architecture bench of UpDownSatCounter_tb is

  component UpDownSatCounter
      Port ( clk : in STD_LOGIC;
             clear : in STD_LOGIC;
             VN_output_bit_1st : in STD_LOGIC;
             VN_output_bit_2nd : in STD_LOGIC;
             sign_bit : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal clear: STD_LOGIC;
  signal VN_output_bit_1st,VN_output_bit_2nd: STD_LOGIC;
  signal sign_bit: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: UpDownSatCounter port map ( clk => clk,
                                   clear => clear,
                                   VN_output_bit_1st => VN_output_bit_1st,
                                   VN_output_bit_2nd => VN_output_bit_2nd,
                                   sign_bit => sign_bit );

  stimulus: process
  begin
    stop_the_clock <= false;
    clear <= '1';
    wait for 10 ns;
    clear <= '0';
    VN_output_bit_1st <= '1';
    VN_output_bit_2nd <= '1';
    wait for 10 ns;
    VN_output_bit_1st <= '0';
    VN_output_bit_2nd <= '1';
    wait for 10 ns;
    VN_output_bit_1st <= '1';
    VN_output_bit_2nd <= '0';
    wait for 10 ns;
    for i in 1 to 10 loop
        VN_output_bit_1st <= '1';
        VN_output_bit_2nd <= '1';
        wait for 10 ns;
    end loop;
    for i in 1 to 30 loop
        VN_output_bit_1st <= '0';
        VN_output_bit_2nd <= '0';
        wait for 10 ns;
    end loop;

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