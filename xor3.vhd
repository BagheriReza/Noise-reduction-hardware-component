LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL ;


ENTITY xor3 IS
	PORT(a,b,c_in:IN STD_LOGIC;s : OUT STD_LOGIC);
END xor3;
------------
ARCHITECTURE gate_level OF xor3 IS
BEGIN
s <= a xor b xor c_in;	
END gate_level;


