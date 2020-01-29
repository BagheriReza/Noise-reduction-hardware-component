LIBRARY IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;   
	
ENTITY ram IS
GENERIC(CONSTANT word_size : INTEGER := 8;
	CONSTANT size_of_ram : INTEGER := 102400;
	CONSTANT adr_size : INTEGER := 17);
PORT(data : IN STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
     adr : IN STD_LOGIC_VECTOR(adr_size-1 DOWNTO 0);
     write,clk : IN STD_LOGIC;
     q : OUT STD_LOGIC_VECTOR(word_size-1 DOWNTO 0));
END ram;

ARCHITECTURE data_flow OF ram IS
TYPE ram_arr_t IS ARRAY(size_of_ram-1 DOWNTO 0) OF STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
SIGNAL ram_arr : ram_arr_t;
BEGIN

	process(clk )
	begin
	     if(clk = '1' and clk'EVENT)then		
		  if(write = '1') then
				ram_arr(CONV_INTEGER(adr)) <= data;
			elsif(write = '0' )then
				q <= ram_arr(CONV_INTEGER(adr));
			end if;
		end if;	
		end process;
--ram_arr(CONV_INTEGER(adr)) <= data WHEN write = '1' AND clk = '1' AND clk'EVENT ELSE UNAFFECTED;

--q <= ram_arr(CONV_INTEGER(adr)) WHEN write = '0' ELSE UNAFFECTED ;

END data_flow;