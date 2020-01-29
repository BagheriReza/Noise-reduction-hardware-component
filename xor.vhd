LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL ;


ENTITY xor1 IS
	PORT(a,b:IN STD_LOGIC;s : OUT STD_LOGIC);
END xor1;
------------
ARCHITECTURE gate_level OF xor1 IS
BEGIN
	s <=(a xor b );
END gate_level;


--------------------------------------------------
