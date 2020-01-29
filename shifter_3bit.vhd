LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.all;

ENTITY shifter_3bit IS

PORT (reset, enable, clk : IN STD_LOGIC;
parout : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END shifter_3bit;
--
ARCHITECTURE dataflow OF shifter_3bit IS
SIGNAL a : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN


	--process(reset,clk)
	--begin
	--	if(reset = '1')then
	--		a <= "001" ;
	---	elsif(clk='1' and clk'event) then
	--	if(enable='1')then
	--	a <= (a(2)&a(0)&a(1));
	--	end if; 
	--	end if;
	
	--end process;
	
	
a <= "001" WHEN reset='1' ELSE
	  (a(1 DOWNTO 0)&a(2)) WHEN clk='1' AND clk'EVENT AND enable='1' ELSE UNAFFECTED;

parout <= a;
END dataflow;
