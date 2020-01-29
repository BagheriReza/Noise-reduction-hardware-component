LIBRARY IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;   
	
ENTITY image_processor IS
	port(data_in: in std_logic_vector(7 downto 0);
	     start,reset,finish,clk: in std_logic;
	     data_out: out std_logic_vector(7 downto 0));
END image_processor;

ARCHITECTURE structural of image_processor is
    
   signal data_im: std_logic_vector(23 downto 0); 
   signal mem_reset,mem_start,mem_write,mem_finish: std_logic; 
BEGIN
    

    Controller: entity work.controller port map(clk,reset,start,finish,mem_reset,mem_start,mem_write,mem_finish);
    Memory_Unit: entity work.ram_all(data_flow) 
                port map(mem_write,mem_start,mem_finish,clk,mem_reset,data_in,data_im);
    Arithmetic_Unit: entity work.arithmetic_unit port map(data_im,clk,data_out);
    
end structural;	       
