-- Each Variable Node is connected to 2 Parity Nodes, takes signals from 1 PN and sends response to 1 PN
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.all;
entity VariableNode is
    Port(clk : in std_logic;
		inputFromPN : in std_logic;
		initialization : in std_logic;
		inputFromComparator : in std_logic;
	    dre_reset: in std_logic;
		dre_seed: in std_logic_vector(10 downto 1);
		outputToPN : out std_logic );
end VariableNode;

architecture VariableNodeBehavior of VariableNode is
component LFSR is Port(
    clk : in std_logic;
    enabled : in std_logic;
    reset : in std_logic;
    seed_values : in std_logic_vector(10 downto 1);
    random_num : out std_logic_vector(10 downto 1)
);
end component;
component EM is
    Port (
        clk : in std_logic;
        random_address : in std_logic_vector(5 downto 1);
        input : in std_logic;
        update : in std_logic;
        output : out std_logic
        );
end component;

signal random_address_EM: std_logic_vector(5 downto 1);
signal concatenated_address : std_logic_vector(10 downto 1);
signal EM_input : std_logic; -- MUX2 input when select=1
signal EM_update : std_logic; -- equals to MUX2 select
signal EM_output : std_logic; -- MUX2 input when select=0
signal Mux2output : std_logic;

begin
	random_address_EM <= concatenated_address(5 downto 1);-- xor concatenated_address(10 downto 6);
	EM_input <= inputFromComparator  when initialization = '1' else	(inputFromComparator and inputFromPN);
	EM_update <= initialization or ((inputFromPN and inputFromComparator)or((not inputFromPN) and (not inputFromComparator)));
	Mux2output <= EM_input when EM_update = '1' else EM_output;

DRE:LFSR port map ( clk=>clk,
        enabled=>'1',
        reset => dre_reset,
        seed_values => dre_seed,
        random_num => concatenated_address
);

EdgeMemory:EM port map ( clk=>clk,
		random_address => random_address_EM,
        input => EM_input,
        update => EM_update,
        output  => EM_output
);

process(clk)
    begin
    if rising_edge(clk) then
		outputToPN <= Mux2output;
	end if;
end process;

end VariableNodeBehavior;