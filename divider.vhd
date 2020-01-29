LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
ENTITY divider IS
	PORT ( data_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0) ;
	       data_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)) ;
END divider;

ARCHITECTURE structural OF divider IS
SIGNAL intermediate_data_1,intermediate_data_2 : STD_LOGIC_VECTOR(14 DOWNTO 0);

BEGIN

first_part : ENTITY WORK.divider_part1 PORT MAP (data_in,intermediate_data_1);
secend_part : ENTITY WORK.divider_part2 PORT MAP (intermediate_data_1,intermediate_data_2);
third_part : ENTITY WORK.divider_part3 PORT MAP (intermediate_data_2,data_out);

END structural;