--  LDPC  Decoder  #VN=6  #PN=4 du=2 dc=3
---     | 1 0 1 0 1 0 |
---     | 1 0 1 0 1 0 |
--- H = | 0 1 0 1 0 1 | 
---     | 0 1 0 1 0 1 |

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work; 
use work.all;                                                                                         ---

entity LDPC_decoder_6_4 is
    Port ( clk : in STD_LOGIC;
           LFSR_overall_rst : in std_logic;
           LFSR_seed_0,LFSR_seed_1,LFSR_seed_2,LFSR_seed_3,LFSR_seed_4,LFSR_seed_5 : in std_logic_vector(10 downto 1);
           new_Pi_value_0,new_Pi_value_1,new_Pi_value_2,new_Pi_value_3,new_Pi_value_4,new_Pi_value_5: in std_logic_vector(7 downto 1);
           initialization : in std_logic;
           reset_ff : in std_logic;
	       reset_EM : in std_logic;
           satisfied_parities : out std_logic; -- Termination Creteria 
           sign_bits: out std_logic_vector(6 downto 1)
           );
end LDPC_decoder_6_4;

architecture LDPC_decoder_6_4_behav of LDPC_decoder_6_4 is
component StochasticStreamCreator is
    Port (  clk : in std_logic;
            LFSR_enable : in std_logic;
            LFSR_rst : in std_logic;
            LFSR_seed : in std_logic_vector(10 downto 1);
            new_Pi_value : in std_logic_vector(7 downto 1);
            output_of_lfsr_7bits : out std_logic_vector(7 downto 1);
            StochasticStream : out std_logic); 
end component;
component VariableNode is
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
component ParityNode is
    Port ( input : in STD_LOGIC_VECTOR (3 downto 1);
           clk : in STD_LOGIC;
           parity_check_satisfied : out STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 1));
end component;
component UpDownSatCounter
      Port ( clk : in STD_LOGIC;
             clear : in STD_LOGIC;
             VN_output_bit_1st : in STD_LOGIC;
             VN_output_bit_2nd : in STD_LOGIC;
             sign_bit : out STD_LOGIC);
  end component;
-- signals
signal lfsr_1,lfsr_2,lfsr_3,lfsr_4,lfsr_5,lfsr_6 : std_logic_vector(7 downto 1); -- values of StochsaticStreamCreators
signal StochasticStreamOutput_1,StochasticStreamOutput_2,StochasticStreamOutput_3,StochasticStreamOutput_4,StochasticStreamOutput_5,StochasticStreamOutput_6:std_logic;

signal VN1toPN1,VN1toPN2,VN2toPN3,VN2toPN4,VN3toPN1,VN3toPN2,VN4toPN3,VN4toPN4,VN5toPN1,VN5toPN2,VN6toPN3,VN6toPN4: std_logic;
signal PN1toVN1,PN1toVN3,PN1toVN5,PN2toVN1,PN2toVN3,PN2toVN5,PN3toVN2,PN3toVN4,PN3toVN6,PN4toVN2,PN4toVN4,PN4toVN6: std_logic;

signal parity_satisfied_1,parity_satisfied_2,parity_satisfied_3,parity_satisfied_4: std_logic;
signal parity_satisfied_termination : std_logic;
signal clear_counters : std_logic; -- probably this will happen together with term criteria

signal sign_bit1,sign_bit2,sign_bit3,sign_bit4,sign_bit5,sign_bit6 : std_logic; -- 0 determines decoded "+1", 1 determines decoded "-1"

begin

parity_satisfied_termination <= (not parity_satisfied_1) and (not parity_satisfied_2) and
                                (not parity_satisfied_3) and (not parity_satisfied_4);
satisfied_parities <= parity_satisfied_termination;

SSC1: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_1,
            new_Pi_value => new_Pi_value_1,
            output_of_lfsr_7bits => lfsr_1,
            StochasticStream => StochasticStreamOutput_1
            );
SSC2: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_2,
            new_Pi_value => new_Pi_value_2,
            output_of_lfsr_7bits => lfsr_2,
            StochasticStream => StochasticStreamOutput_2
            );
SSC3: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_3,
            new_Pi_value => new_Pi_value_3,
            output_of_lfsr_7bits => lfsr_3,
            StochasticStream => StochasticStreamOutput_3
            );
SSC4: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_4,
            new_Pi_value => new_Pi_value_4,
            output_of_lfsr_7bits => lfsr_4,
            StochasticStream => StochasticStreamOutput_4
            );
SSC5: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_5,
            new_Pi_value => new_Pi_value_5,
            output_of_lfsr_7bits => lfsr_5,
            StochasticStream => StochasticStreamOutput_5
            );
SSC6: StochasticStreamCreator port map(clk => clk,
            LFSR_enable => '1',
            LFSR_rst => LFSR_overall_rst,
            LFSR_seed => LFSR_seed_0,
            new_Pi_value => new_Pi_value_0,
            output_of_lfsr_7bits => lfsr_6,
            StochasticStream => StochasticStreamOutput_6
            );

VN1_PN1: VariableNode port map(clk=>clk,
		inputFromPN=>PN1toVN1,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_1,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_1,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN1toPN1
);
VN1_PN2: VariableNode port map(clk=>clk,
		inputFromPN=>PN2toVN1,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_1,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_1,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN1toPN2
);
VN2_PN3: VariableNode port map(clk=>clk,
		inputFromPN=>PN3toVN2,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_2,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_2,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN2toPN3
);
VN2_PN4: VariableNode port map(clk=>clk,
		inputFromPN=>PN4toVN2,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_2,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_2,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN2toPN4
);
VN3_PN1: VariableNode port map(clk=>clk,
		inputFromPN=>PN1toVN3,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_3,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_3,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN3toPN1
);
VN3_PN2: VariableNode port map(clk=>clk,
		inputFromPN=>PN2toVN3,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_3,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_3,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN3toPN2
);
VN4_PN3: VariableNode port map(clk=>clk,
		inputFromPN=>PN3toVN4,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_4,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_4,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN4toPN3
);
VN4_PN4: VariableNode port map(clk=>clk,
		inputFromPN=>PN4toVN4,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_4,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_4,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN4toPN4
);
VN5_PN1: VariableNode port map(clk=>clk,
		inputFromPN=>PN1toVN5,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_5,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_5,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN5toPN1
);
VN5_PN2: VariableNode port map(clk=>clk,
		inputFromPN=>PN2toVN5,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_5,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_5,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN5toPN2
);
VN6_PN3: VariableNode port map(clk=>clk,
		inputFromPN=>PN3toVN6,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_6,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_3,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN6toPN3
);
VN6_PN4: VariableNode port map(clk=>clk,
		inputFromPN=>PN4toVN6,
		initialization=>initialization,
		inputFromComparator=>StochasticStreamOutput_6,
	    dre_reset=>LFSR_overall_rst,
		dre_seed=>LFSR_seed_3,
		reset_ff=>reset_ff,
		reset_EM=>reset_EM,
		outputToPN=>VN6toPN4
);

PN1: ParityNode port map( input(3)=>VN1toPN1,input(2)=>VN3toPN1,input(1)=>VN5toPN1,
           clk => clk,
           parity_check_satisfied => parity_satisfied_1,
           output(3)=>PN1toVN1,output(2)=>PN1toVN3,output(1)=>PN1toVN5
);
PN2: ParityNode port map( input(3)=>VN1toPN1,input(2)=>VN3toPN1,input(1)=>VN5toPN1,
           clk => clk,
           parity_check_satisfied => parity_satisfied_2,
           output(3)=>PN2toVN1,output(2)=>PN2toVN3,output(1)=>PN2toVN5
);
PN3: ParityNode port map( input(3)=>VN2toPN3,input(2)=>VN4toPN3,input(1)=>VN6toPN3,
           clk => clk,
           parity_check_satisfied => parity_satisfied_3,
           output(3)=>PN3toVN2,output(2)=>PN3toVN4,output(1)=>PN3toVN6
);
PN4: ParityNode port map( input(3)=>VN2toPN4,input(2)=>VN4toPN4,input(1)=>VN6toPN4,
           clk => clk,
           parity_check_satisfied => parity_satisfied_4,
           output(3)=>PN4toVN2,output(2)=>PN4toVN4,output(1)=>PN4toVN6
);

UDSCnt1: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN1toPN1, 
             VN_output_bit_2nd => VN1toPN2,
             sign_bit => sign_bit1
);
UDSCnt2: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN2toPN3, 
             VN_output_bit_2nd => VN2toPN4,
             sign_bit => sign_bit2
);
UDSCnt3: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN3toPN1,
             VN_output_bit_2nd => VN3toPN2,
             sign_bit => sign_bit3
);
UDSCnt4: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN4toPN3, 
             VN_output_bit_2nd => VN4toPN4,
             sign_bit => sign_bit4
);
UDSCnt5: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN5toPN1, 
             VN_output_bit_2nd => VN5toPN2,
             sign_bit => sign_bit5
);
UDSCnt6: UpDownSatCounter port map( clk => clk,
             clear => clear_counters,
             VN_output_bit_1st => VN6toPN3, 
             VN_output_bit_2nd => VN6toPN4,
             sign_bit => sign_bit6
);

process(clk) is
variable max_decoding_cycles : integer := 3000;
begin
    if rising_edge(clk) then
        if max_decoding_cycles = 5000 then
            clear_counters <= '0';
        end if;
        clear_counters <= parity_satisfied_termination;
        sign_bits(1) <= sign_bit1;
        sign_bits(2) <= sign_bit2;
        sign_bits(3) <= sign_bit3;
        sign_bits(4) <= sign_bit4;
        sign_bits(5) <= sign_bit5;
        sign_bits(6) <= sign_bit6;
    end if;
end process;
end LDPC_decoder_6_4_behav;