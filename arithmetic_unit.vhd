LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;
ENTITY arithmetic_unit IS
	PORT(data_in : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	     clk : IN STD_LOGIC;
	     data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END arithmetic_unit;

ARCHITECTURE data_flow OF arithmetic_unit IS

--signal for register 9
SIGNAL data_1_1,data_1_2,data_1_3,data_2_1,data_2_2,data_2_3,data_3_1,data_3_2,data_3_3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
       
--output adder
SIGNAl adder_out,adder_out_p : STD_LOGIC_VECTOR (11 DOWNTO 0);


--divider part
SIGNAL intermediate_data_1,intermediate_data_2,intermediate_data_1_p,intermediate_data_2_p : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAl data_out_t : STD_LOGIC_VECTOR(8 DOWNTo 0);  



BEGIN

--register's for hold input data 

data_1_1 <= data_in (7 DOWNTO 0) WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED ;
data_1_2(7 DOWNTO 0) <= data_in (15 DOWNTO 8) WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;
data_1_3(7 DOWNTO 0) <= data_in (23 DOWNTO 16) WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;

data_2_1 <= data_1_1 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;
data_2_2 <= data_1_2 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;
data_2_3 <= data_1_3 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;

data_3_1 <= data_2_1 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;
data_3_2 <= data_2_2 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;
data_3_3 <= data_2_3 WHEN clk ='1' AND clk'EVENT ELSE UNAFFECTED;

---sum 9 data

adder : ENTITY WORK.adder PORT MAP(data_1_1,data_1_2,data_1_3,data_2_1,data_2_2,data_2_3,
					data_3_1,data_3_2,data_3_3,adder_out);
adder_out_p <= adder_out WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;
					
--

--divider_part



first_part : ENTITY WORK.divider_part1 PORT MAP (adder_out_p,intermediate_data_1);
intermediate_data_1_p <= intermediate_data_1 WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;


secend_part : ENTITY WORK.divider_part2 PORT MAP (intermediate_data_1_p,intermediate_data_2);
intermediate_data_2_p <= intermediate_data_2 WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;

third_part : ENTITY WORK.divider_part3 PORT MAP (intermediate_data_2_p,data_out_t);

data_out <= data_out_t(7 DOWNTO 0);

--output
END data_flow;
