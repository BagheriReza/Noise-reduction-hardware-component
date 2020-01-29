LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL ;


ENTITY maj3 IS
	PORT(a,b,c_in:IN STD_LOGIC;c_out : OUT STD_LOGIC);
END maj3;
------------
ARCHITECTURE gate_level OF maj3 IS
SIGNAl m1,m2,m3 : STD_LOGIC;
BEGIN
m1 <= a and b;
m2 <= a and c_in;
m3 <= b and c_in;
c_out <= ( m1 or m2 or m3);
END gate_level;