LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
ENTITY divider_part1 IS
	PORT(data_in : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
	     data_out : OUT STD_LOGIC_VECTOR (14 DOWNTO 0));
END divider_part1;

ARCHITECTURE data_flow OF divider_part1 IS
SIGNAL not_data_in,sll3_data_in : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL cout : STD_LOGIC;
BEGIN
--not input
not_data_in(14 DOWNTO 12) <= "111";
not_data_in(11 DOWNTO 0) <= NOT data_in(11 DOWNTO 0);

--shift input
sll3_data_in(14 DOWNTO 3) <= data_in(11 DOWNTO 0);
sll3_data_in(2 DOWNTO 0) <= "000";

--sub=> 8*input-input
sub : ENTITY WORK.fulladder_nbit GENERIC MAP(n => 15) PORT MAP (not_data_in,sll3_data_in,'1',data_out,cout);

END data_flow;
