LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
ENTITY divider_part2 IS
	PORT(data_in : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
	     data_out : OUT STD_LOGIC_VECTOR (14 DOWNTO 0));
END divider_part2;

ARCHITECTURE data_flow OF divider_part2 IS
SIGNAL slr6_data_in,s_out : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL cout : STD_LOGIC;
BEGIN


slr6_data_in(8 DOWNTO 0) <= data_in(14 DOWNTO 6);
slr6_data_in(14 DOWNTO 9) <= "000000";
add : ENTITY WORK.fulladder_nbit GENERIC MAP(n => 15) PORT MAP (data_in,slr6_data_in,'1',data_out,cout);

END data_flow;
