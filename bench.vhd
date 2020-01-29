library ieee;
use ieee.std_logic_1164.all;

entity test_bench is
end test_bench;

ARCHITECTURE procedural OF test_bench IS

signal start,reset,finish,clk: std_logic;
signal data_in,data_out: std_logic_vector(7 downto 0);

begin

module_under_test:entity work.image_processor port map(data_in,start,reset,finish,clk,data_out);

clk_gen:process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process clk_gen;


reset <= '1',
	 '0' after 100 ns;


start <= '0',
	 '1' after 100 ns,
	 '0' after 200 ns;

data_in  <= "11111111",-- first row is "11111111"
	    "00000000" after 64200 ns,
	    "00001111" after 65100 ns,-- second row others = "00001111"
	    "10101010" after 128200 ns,-- third row data(0:4)="10101010"
	    "11110000" after 128700 ns;-- third row others="11110000"
-- and others row = "11110000"
-- for test this module  4th row,that's enough.

finish <= '0' ,
	  '1' after 356200 ns,
	  '0' after 356300 ns;

end procedural;