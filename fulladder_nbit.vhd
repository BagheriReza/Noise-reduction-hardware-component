LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY fulladder_nbit IS
	GENERIC(CONSTANT n : INTEGER := 4);--n in this module equal with 2*n 
	PORT(a,b:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);c_in:IN STD_LOGIC;s : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);c_out : OUT STD_LOGIC);
END fulladder_nbit;
------------
ARCHITECTURE gate_level OF fulladder_nbit  IS
SIGNAl m : STD_LOGIC_VECTOR (n DOWNTO 0);
BEGIN
reza:for i in 0 to n-1 GENERATE
	 gi : ENTITY WORK.fulladder_1bit PORT MAP (a(i),b(i),m(i),s(i),m(i+1));
	END GENERATE;

	m(0)<= c_in;
	c_out <= m(n);
	 
END gate_level;