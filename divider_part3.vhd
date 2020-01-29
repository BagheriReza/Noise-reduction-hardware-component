LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
ENTITY divider_part3 IS
	PORT(data_in : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
	     data_out : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
END divider_part3;

ARCHITECTURE data_flow OF divider_part3 IS
SIGNAL slr12_data_in,s_out : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL cout : STD_LOGIC;
BEGIN


slr12_data_in(2 DOWNTO 0) <= data_in(14 DOWNTO 12);
slr12_data_in(14 DOWNTO 3) <= "000000000000";
add : ENTITY WORK.fulladder_nbit GENERIC MAP(n => 15) PORT MAP (data_in,slr12_data_in,'0',s_out,cout);
data_out(8 DOWNTO 0)<=s_out(14 DOWNTO 6);
END data_flow;
