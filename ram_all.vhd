LIBRARY IEEE;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;   
	
ENTITY ram_all IS
GENERIC(CONSTANT word_input : INTEGER := 8;
	CONSTANT word_output : INTEGER := 24
	);
PORT(write,start,finish,clk,rreset : IN STD_LOGIC;
     data_in : IN STD_LOGIC_VECTOR(word_input -1 DOWNTO 0);
     data_out : OUT STD_LOGIC_VECTOR(word_output -1 DOWNTO 0));
END ram_all;

ARCHITECTURE data_flow OF ram_all IS

-- part of state machine declaration
TYPE  state  IS (s_reset , s_start);
TYPE state_vector IS ARRAY (NATURAL RANGE <> ) OF state;
FUNCTION one_of(sources : state_vector) RETURN state IS
	BEGIN
	RETURN sources(sources'LEFT);
	END one_of;


SIGNAl current : one_of state REGISTER ;


-- counter 0-639 signal declaration
SIGNAL clk_639_640,clk_639,clk_640,comp_640,reset,reset1,reset2 : STD_LOGIC;
SIGNAl q_count_640,a : STD_LOGIC_VECTOR(9 DOWNTO 0);



--shifter_3bit signal declaration
SIGNAL en_count_wr : STD_LOGIC_VECTOR (2 DOWNTO 0);

--offset signal declaration
SIGNAL ld_count_rd_a,ld_count_rd_b,ld_count_rd_c : STD_LOGIC_VECTOR(16 DOWNTO 0); 


--rams signal declaration
SIGNAl adr_a,adr_b,adr_c : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL wr_en_ram_a,wr_en_ram_b,wr_en_ram_c : STD_LOGIC;

--counter's  ram's signal declaration
SIGNAl adr_ram1_wr,adr_ram1_rd : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAl adr_ram2_wr,adr_ram2_rd : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAl adr_ram3_wr,adr_ram3_rd : STD_LOGIC_VECTOR(16 DOWNTO 0);

--mux signal for chose output
SIGNAL data_a,data_b,data_c : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ch_data_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
  reset1 <= rreset ;

	process(clk,rreset)
		begin
		if(rreset='1')then
			current <= s_reset;
		elsif(start='1') then
			current <= s_start;
		elsif(finish='1') then
			current <= s_reset;
		end if;
	end process;
		
		
	process(current)
		begin
		reset2<='0';
		if(current=s_reset) then
			reset2 <= '1';
		elsif(current=s_start) then
			reset2 <= '0';
		end if;
	end process;
	
	reset <= reset1 or reset2;
	







-- counter 0-639
counter_640 : ENTITY WORK.counter GENERIC MAP (n => 10) PORT MAP(clk_640,'0','1',clk,
				"0000000000",q_count_640);
a <= "1010000000";
comp_640 <= '1' WHEN (q_count_640 = a) ELSE '0';
clk_640 <= comp_640 OR reset ;



clk_639 <= '1' WHEN (q_count_640 ="1001111111" ) ELSE '0';
clk_639_640 <= '1' WHEN clk_639='1' OR clk_640= '1' ELSE '0';




-- shifter 3_bit for write enable
shift_3b_wr : ENTITY WORK.shifter_3bit PORT MAP (reset,write,clk_640,en_count_wr);
--

--offset
offset_write : ENTITY WORK.offset GENERIC MAP (17) PORT MAP (reset,clk_639,ld_count_rd_a,ld_count_rd_b,ld_count_rd_c);
--

-- rams
wr_en_ram_a <= write AND en_count_wr(0);
wr_en_ram_b <= write AND en_count_wr(1);
wr_en_ram_c <= write AND en_count_wr(2);

ram_1 : ENTITY WORK.ram PORT MAP (data_in,adr_a,wr_en_ram_a,clk,data_a);

ram_2 : ENTITY WORK.ram PORT MAP (data_in,adr_b,wr_en_ram_b,clk,data_b);

ram_3 : ENTITY WORK.ram PORT MAP (data_in,adr_c,wr_en_ram_c,clk,data_c);


--counter write for first ram
count_ram1_wr : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,'0',en_count_wr(0),clk,
									"00000000000000000",adr_ram1_wr);

--counter read for first ram
count_ram1_rd : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,clk_639_640,'1',clk,ld_count_rd_a,adr_ram1_rd);

-- mux for selecting signal adr for first ram
mux_ram1 : ENTITY WORK.mux_2to1_nbit GENERIC MAP ( n => 17 ) PORT MAP (write,adr_ram1_wr,adr_ram1_rd,adr_a);




--counter write for second ram
count_ram2_wr : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,'0',en_count_wr(1),clk,
										"00000000000000000",adr_ram2_wr);

--counter read for second ram
count_ram2_rd : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,clk_639_640,'1',clk,ld_count_rd_b,adr_ram2_rd);

-- mux for selecting signal adr for second ram
mux_ram2 : ENTITY WORK.mux_2to1_nbit GENERIC MAP ( n => 17 ) PORT MAP (write,adr_ram2_wr,adr_ram2_rd,adr_b);





--counter write for third ram
count_ram3_wr : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,'0',en_count_wr(2),clk,
									"00000000000000000",adr_ram3_wr);

--counter read for third ram
count_ram3_rd : ENTITY WORK.counter GENERIC MAP (n => 17) PORT MAP(reset,clk_639_640,'1',clk,ld_count_rd_c,adr_ram3_rd);

-- mux for selecting signal adr for third ram
mux_ram3 : ENTITY WORK.mux_2to1_nbit GENERIC MAP ( n => 17 ) PORT MAP (write,adr_ram3_wr,adr_ram3_rd,adr_c);

-- shifter 3_bit for output chose
shift_3b_out : ENTITY WORK.shifter_3bit PORT MAP (write,start,clk_640,ch_data_out);
--

data_out <=(data_a&data_b&data_c) WHEN ch_data_out(0) = '1' ELSE
	   (data_b&data_c&data_a) WHEN ch_data_out(1) = '1' ELSE
	   (data_c&data_a&data_b) WHEN ch_data_out(2) = '1' ELSE UNAFFECTED;



END data_flow; 