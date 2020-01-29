library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is   
	generic(n : integer := 8);

	port(reset : in  std_logic;
           ld :    in  std_logic;
           enable : in  std_logic;
	     clk  :in  std_logic;
 		d_ld : in std_logic_vector(n-1 downto 0);        
		q : out std_logic_vector(n-1 downto 0)); 
end counter;

architecture archi of counter is  
	signal tmp: std_logic_vector(n-1 downto 0);  
begin     
	process (reset , clk )      
		begin        
		if (reset ='1') then          
			tmp <= (others => '0');        
		elsif (clk'event and clk='1') then           
			if(ld = '1') then
				tmp <= d_ld ;
			elsif(enable ='1')then
			tmp <= tmp + 1;
			end if ;
		end if;
		
	end process;    
	q <= tmp;
end archi;
