LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY fulladder_1bit IS
	PORT(a,b,c_in:IN STD_LOGIC;s,c_out : OUT STD_LOGIC);
END fulladder_1bit;
------------
ARCHITECTURE gate_level OF fulladder_1bit  IS
SIGNAl m1,m2,m3 : STD_LOGIC;
BEGIN
g0 : ENTITY WORK.xor3 PORT MAP (a,b,c_in,s);
g1 : ENTITY WORK.maj3 PORT MAP (a,b,c_in,c_out);
END gate_level;