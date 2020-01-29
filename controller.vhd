LIBRARY IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;  
	
entity controller is
    port(clk,reset,start,finish : in std_logic;
         mem_reset,mem_start,mem_write,mem_finish : out std_logic);
end controller;

architecture behavioral of controller is
    type state is (init,mem_write0,mem_write1,eow,mem_read0,mem_read1,eor);
    signal current,next_state: state;
    signal count_reset,start_count: std_logic;
    signal q: std_logic_vector(18 downto 0);
   
begin

count_pix: entity work.counter generic map(19) 
         port map(start_count,'0','1',clk,(others => '0'),q);
   process(q)
   begin
       count_reset <= '0';
       if q = "1001011000000000000" then
           count_reset <= '1';
       end if;
   end process;
           

   process(clk,reset)
   begin
      if reset='1' then
         current <= init;
      elsif (clk='1' and clk'event) then
         current <= next_state;
      end if;
   end process;
   
   process(current,reset,start,finish,count_reset)
   begin    
       CASE current IS
       WHEN init =>
          IF start = '1' THEN next_state <= mem_write0;
          ELSE next_state <= init;
          END IF;
       WHEN mem_write0 =>
          IF (clk = '1') THEN next_state <= mem_write1;
          ELSE next_state <= mem_write0;
          END IF;
       WHEN mem_write1 =>
          IF finish = '1' THEN next_state <= eow;
          ELSE next_state <= mem_write1;
          END IF;
       WHEN eow =>
          IF (clk = '1') THEN next_state <= mem_read0;
          ELSE next_state <= eow;
          END IF;
       WHEN mem_read0 =>
          IF (clk = '1') THEN next_state <= mem_read1;
          ELSE next_state <= mem_read0;
          END IF;
       WHEN mem_read1 =>
          IF count_reset = '1' THEN next_state <= eor;
          ELSE next_state <= mem_read1;
          END IF;
       WHEN eor =>
          IF (clk = '1') THEN next_state <= init;
          ELSE next_state <= eor;
          END IF;
       END CASE;
   end process;
   
   process (current)
   begin
      start_count <= '0';
      mem_reset <= '0';
      mem_start <= '0';
      mem_write <= '0';
      mem_finish <= '0';
      CASE current IS
       WHEN init =>
          mem_reset <= '1';
       WHEN mem_write0 =>
          mem_start <= '1';
          mem_write <= '1';
       WHEN mem_write1 =>
          mem_write <= '1';
       WHEN eow =>
          mem_finish <= '1';
       WHEN mem_read0 =>
          mem_start <= '1';
          start_count <= '1';
       WHEN mem_read1 => 
          mem_reset <= '0';
       WHEN eor =>
         mem_finish <= '1';
       END CASE;
   end process;

end behavioral;
      
       
          