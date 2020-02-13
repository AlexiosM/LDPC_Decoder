library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity LDPC_decoder_6_4_tb is
end;

architecture bench of LDPC_decoder_6_4_tb is

  component LDPC_decoder_6_4
      Port ( clk : in STD_LOGIC;
             LFSR_overall_rst : in std_logic;
             LFSR_seed_0,LFSR_seed_1,LFSR_seed_2,LFSR_seed_3,LFSR_seed_4,LFSR_seed_5 : in std_logic_vector(10 downto 1);
             new_Pi_value_0,new_Pi_value_1,new_Pi_value_2,new_Pi_value_3,new_Pi_value_4,new_Pi_value_5: in std_logic_vector(7 downto 1);
             initialization : in std_logic;
             satisfied_parities : out std_logic;
             sign_bits: out std_logic_vector(6 downto 1)
             );
  end component;

  signal clk: STD_LOGIC;
  signal LFSR_overall_rst: std_logic;
  signal LFSR_seed_0,LFSR_seed_1,LFSR_seed_2,LFSR_seed_3,LFSR_seed_4,LFSR_seed_5: std_logic_vector(10 downto 1);
  signal new_Pi_value_0,new_Pi_value_1,new_Pi_value_2,new_Pi_value_3,new_Pi_value_4,new_Pi_value_5: std_logic_vector(7 downto 1);
  signal initialization: std_logic;
  signal satisfied_parities: std_logic;
  signal sign_bits: std_logic_vector(6 downto 1) ;

signal new_Pi_value_1_signal,new_Pi_value_2_signal,new_Pi_value_3_signal,
    new_Pi_value_4_signal,new_Pi_value_5_signal,new_Pi_value_6_signal : std_logic_vector(7 downto 1);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: LDPC_decoder_6_4 port map ( clk                => clk,
                                   LFSR_overall_rst   => LFSR_overall_rst,
                                   LFSR_seed_0        => LFSR_seed_0,
                                   LFSR_seed_1        => LFSR_seed_1,
                                   LFSR_seed_2        => LFSR_seed_2,
                                   LFSR_seed_3        => LFSR_seed_3,
                                   LFSR_seed_4        => LFSR_seed_4,
                                   LFSR_seed_5        => LFSR_seed_5,
                                   new_Pi_value_0     => new_Pi_value_1_signal,
                                   new_Pi_value_1     => new_Pi_value_2_signal,
                                   new_Pi_value_2     => new_Pi_value_3_signal,
                                   new_Pi_value_3     => new_Pi_value_4_signal,
                                   new_Pi_value_4     => new_Pi_value_5_signal,
                                   new_Pi_value_5     => new_Pi_value_6_signal,
                                   initialization     => initialization,
                                   satisfied_parities => satisfied_parities,
                                   sign_bits          => sign_bits );

  stimulus: process
  begin
  
    stop_the_clock <= false;
    initialization <='1';
    LFSR_overall_rst<='1';
    LFSR_seed_0 <= "0101010101";
    LFSR_seed_1 <= "0101110101";
    LFSR_seed_2 <= "0111011101";
    LFSR_seed_3 <= "0100010001";
    LFSR_seed_4 <= "0101000101";
    LFSR_seed_5 <= "1101010111";
    wait for 15 ns;
    LFSR_overall_rst<='0';
    wait for 400 ns;
    initialization <='0';
    wait for 262144 ns;

    stop_the_clock <= true;
    wait;
  end process;

read_from_files: process
 
    file P1_values_file : TEXT open READ_MODE is "LP1_file.txt";
    file P2_values_file : TEXT open READ_MODE is "LP2_file.txt";
    file P3_values_file : TEXT open READ_MODE is "LP3_file.txt";
    file P4_values_file : TEXT open READ_MODE is "LP4_file.txt";
    file P5_values_file : TEXT open READ_MODE is "LP5_file.txt";
    file P6_values_file : TEXT open READ_MODE is "LP6_file.txt";


    variable Pi_value_line1 : line;
    variable Pi_value_line2 : line;
    variable Pi_value_line3 : line;
    variable Pi_value_line4 : line;
    variable Pi_value_line5 : line;
    variable Pi_value_line6 : line;

    variable  new_Pi_value_variable1 : std_logic_vector(7 downto 1);   
    variable  new_Pi_value_variable2 : std_logic_vector(7 downto 1);   
    variable  new_Pi_value_variable3 : std_logic_vector(7 downto 1);   
    variable  new_Pi_value_variable4 : std_logic_vector(7 downto 1);   
    variable  new_Pi_value_variable5 : std_logic_vector(7 downto 1);   
    variable  new_Pi_value_variable6 : std_logic_vector(7 downto 1);   
    begin
    while not endfile(P1_values_file) loop
        readline(P1_values_file, Pi_value_line1);
        read(Pi_value_line1,new_Pi_value_variable1);
        new_Pi_value_1_signal <= new_Pi_value_variable1;

        readline(P2_values_file, Pi_value_line2);
        read(Pi_value_line2,new_Pi_value_variable2);
        new_Pi_value_2_signal <= new_Pi_value_variable2;
        
        readline(P3_values_file, Pi_value_line3);
        read(Pi_value_line3,new_Pi_value_variable3);
        new_Pi_value_3_signal <= new_Pi_value_variable3;
        
        readline(P4_values_file, Pi_value_line4);
        read(Pi_value_line4,new_Pi_value_variable4);
        new_Pi_value_4_signal <= new_Pi_value_variable4;
        
        readline(P5_values_file, Pi_value_line5);
        read(Pi_value_line5,new_Pi_value_variable5);
        new_Pi_value_5_signal <= new_Pi_value_variable5;
        
        readline(P6_values_file, Pi_value_line6);
        read(Pi_value_line6,new_Pi_value_variable6);
        new_Pi_value_6_signal <= new_Pi_value_variable6;

        wait for 1280 ns;
    end loop;
    file_close(P1_values_file);
    file_close(P2_values_file);
    file_close(P3_values_file);
    file_close(P4_values_file);
    file_close(P5_values_file);
    file_close(P6_values_file);
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