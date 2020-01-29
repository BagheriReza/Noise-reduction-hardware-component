LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL ;

 ENTITY csa IS
 	GENERIC (CONSTANT n : INTEGER := 10);
 	PORT(a:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);b:IN STD_LOGIC_VECTOR (n-4 DOWNTO 0);c : OUT STD_LOGIC_VECTOR (n-4 DOWNTO 0);s,c_out : OUT STD_LOGIC);
 END csa;
 ------------
 
 
 ARCHITECTURE gate_level OF csa  IS
 
 SIGNAl r : STD_LOGIC_VECTOR (3*n-6 DOWNTO 0);
 BEGIN
 r (n-1 DOWNTO 0) <= a(n-1 DOWNTO 0);
 r (2*n-4 DOWNTO n) <= b(n-4 DOWNTO 0);
 
 reza:for i in 0 to n-4 GENERATE
 	 gi : ENTITY WORK.fulladder_1bit PORT MAP (r(3*i),r(3*i+1),r(3*i+2),r(2*n-3+i),c(i));
 	END GENERATE;
 gend : ENTITY WORK.fulladder_1bit PORT MAP (r(3*n-9),r(3*n-8),r(3*n-7),s,c_out);
END gate_level;