LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY t_filpflop IS
	PORT(d,d_ld,load,enable,reset,clk : IN STD_LOGIC;q : OUT STD_LOGIC);
END t_filpflop;
---------------------
ARCHITECTURE behavioral OF t_filpflop IS
	SIGNAL state : STD_LOGIC;
BEGIN
state <= '0' WHEN reset = '1' ELSE
     d_ld WHEN load = '1' AND clk = '1' AND clk'EVENT ELSE
     NOT state WHEN enable = '1' AND clk = '1' AND clk'EVENT AND d = '1' ELSE UNAFFECTED;
q <= state;	
END behavioral;