LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY d_filpflop IS
	PORT(d,set,reset,enable,clk : IN STD_LOGIC;q : OUT STD_LOGIC);
END d_filpflop;
---------------------
ARCHITECTURE behavioral OF d_filpflop IS
	SIGNAL state : STD_LOGIC;
	
	BEGIN
	tff:PROCESS(reset,set,enable,clk)
		BEGIN
		IF reset = '1' THEN
			state <= '0';
		ELSIF set = '1' THEN
			
			state <= '1';
			
		ELSIF  enable = '1' THEN
			IF (clk = '1' AND clk'EVENT ) THEN
			state <= d;
			END IF;
		END IF;
	END PROCESS tff;
	q<=  state;
END behavioral;