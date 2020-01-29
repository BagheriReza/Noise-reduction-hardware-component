LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.all;

ENTITY offset IS
GENERIC(CONSTANT n : INTEGER := 17);
PORT (reset,clk : IN STD_LOGIC;
a,b,c : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0));
END offset;
--



ARCHITECTURE dataflow OF offset IS
SIGNAL cout,ctrl: STD_LOGIC;
SIGNAL a_temp0,a_temp1,b_temp,c_temp : STD_LOGIC_VECTOR ( n-1 DOWNTO 0);
BEGIN
adder : ENTITY WORK.fulladder_nbit GENERIC MAP(17) PORT MAP (c_temp,"00000001010000000",'0',a_temp0,cout); 
a_temp1 <= "00000000000000000" WHEN reset = '1' ELSE a_temp0 WHEN clk = '1' AND clk'EVENT  ELSE UNAFFECTED;
b_temp <= "00000000000000000" WHEN reset = '1' ELSE a_temp1 WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;
c_temp <= "00000000000000000" WHEN reset = '1' ELSE b_temp WHEN clk = '1' AND clk'EVENT ELSE UNAFFECTED;
a <= a_temp1;
b <= b_temp;
c<= c_temp;
END dataflow;
