library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity VariableNode_tb is
end;

architecture bench of VariableNode_tb is

  component VariableNode
      Port(clk : in std_logic;
  		inputFromPN : in std_logic;
  		initialization : in std_logic;
  		inputFromComparator : in std_logic;
  	    dre_reset: in std_logic;
	    dre_seed: in std_logic_vector(10 downto 1);
	    reset_ff : in std_logic;
	    reset_EM : in std_logic;
  		outputToPN : out std_logic );
  end component;

  signal clk: std_logic;
  signal inputFromPN: std_logic;
  signal initialization: std_logic;
  signal inputFromComparator: std_logic;
  signal dre_reset: std_logic;
  signal dre_seed: std_logic_vector(10 downto 1);
  signal reset_ff : std_logic;
  signal reset_EM : std_logic;
  signal outputToPN: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: VariableNode port map ( clk                 => clk,
                               inputFromPN         => inputFromPN,
                               initialization      => initialization,
                               inputFromComparator => inputFromComparator,
                               dre_reset           => dre_reset,
                               dre_seed            => dre_seed,
                               reset_ff            => reset_ff,
                               reset_EM            => reset_EM,
                               outputToPN          => outputToPN );

  stimulus: process
  begin

    dre_seed <= "0001010001";
    dre_reset <= '1';
    reset_ff <= '1';
	reset_EM <= '1';
    initialization <= '1';  -- inputFromComparator leads outputToPN
    wait for 10 ns;
    dre_reset <= '0';
    inputFromPN <= '0';
    inputFromComparator <= '0';
    for i in 1 to 35 loop
        wait for 10 ns;
        inputFromPN <= '0';
        inputFromComparator <= not inputFromComparator;
    end loop;
        initialization <= '0';  -- inputFromComparator leads outputToPN
    wait for 10 ns;
    dre_reset <= '0';
    inputFromPN <= '0';
    inputFromComparator <= '0';
    for i in 1 to 33 loop
        wait for 10 ns;
        inputFromPN <= '0';
        inputFromComparator <= not inputFromComparator;
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