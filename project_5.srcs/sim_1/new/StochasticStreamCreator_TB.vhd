library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity StochasticStreamCreator_tb is
end;

architecture bench of StochasticStreamCreator_tb is
  component StochasticStreamCreator
      Port (  clk : in std_logic;
              LFSR_enable : in std_logic;
              LFSR_rst : in std_logic;
              LFSR_seed : in std_logic_vector(10 downto 1);
              new_Pi_value : in std_logic_vector(7 downto 1);
              output_of_lfsr_7bits : out std_logic_vector(7 downto 1);
              StochasticStream : out std_logic); 
  end component;

  signal clk: std_logic;
  signal LFSR_enable: std_logic;
  signal LFSR_rst: std_logic;
  signal LFSR_seed: std_logic_vector(10 downto 1);
  signal new_Pi_value_signal : std_logic_vector(7 downto 1);
  signal output_of_lfsr_7bits : std_logic_vector(7 downto 1); -- only for the waves
  signal StochasticStream: std_logic;
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: StochasticStreamCreator port map ( clk              => clk,
                                          LFSR_enable      => LFSR_enable,
                                          LFSR_rst         => LFSR_rst,
                                          LFSR_seed        => LFSR_seed,
                                          new_Pi_value    => new_Pi_value_signal,
                                          output_of_lfsr_7bits => output_of_lfsr_7bits,
                                          StochasticStream => StochasticStream);

stimulus: process
  begin
    -- initial values
    stop_the_clock <= false;
    LFSR_enable <= '1';
    LFSR_rst <= '1';
    LFSR_seed <= "0000000001";
    -- begin
    wait for 15 ns;
    LFSR_rst <= '0';                               
    wait for 262144 ns;
    stop_the_clock <= true;
end process;


read_from_file: process
 
    file Pi_values_file : TEXT open READ_MODE is "LP0_file.txt";

    variable Pi_value_line : line;
    variable  new_Pi_value_variable : std_logic_vector(7 downto 1);   
    begin
    while not endfile(Pi_values_file) loop
        readline(Pi_values_file, Pi_value_line);
        read(Pi_value_line,new_Pi_value_variable);
        new_Pi_value_signal <= new_Pi_value_variable;
        wait for 1280 ns;
      end loop;
    file_close(Pi_values_file);
    wait;
  end process;
  
clocking: process
  begin
    clk <= '0';
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;