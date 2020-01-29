LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL ;
	

ENTITY adder IS
	GENERIC (CONSTANT m : INTEGER := 8;
		 CONSTANT n : INTEGER := 9);
	PORT (d1,d2,d3,d4,d5,d6,d7,d8,d9 :IN STD_LOGIC_VECTOR (m-1 DOWNTO 0);c : OUT STD_LOGIC_VECTOR (m+3 DOWNTO 0));
END adder;
--------------------
ARCHITECTURE structural OF adder IS

SIGNAL z : STD_LOGIC_VECTOR ((n*m)-1 DOWNTO 0) ;


--SIGNAL f : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
SIGNAL d : STD_LOGIC_VECTOR ( ((m+1)*(n-3))-1  DOWNTO 0);
SIGNAL g0,g1 : STD_LOGIC_VECTOR (m+2 DOWNTO 0);
SIGNAL q,c1,c2,c3,w1,w2,w3,w4,w5 : STD_LOGIC;

BEGIN

c_01: FOR i1 IN m-1 DOWNTO 0 GENERATE
	c_11:z(n*i1) <=d1(i1) ;
	END GENERATE;

c_02: FOR i2 IN m-1 DOWNTO 0 GENERATE
	c_12:z(n*i2+1) <= d2(i2) ;
	END GENERATE;
	
c_03: FOR i3 IN m-1 DOWNTO 0 GENERATE
	c_13:z(n*i3+2) <= d3(i3) ;
	END GENERATE;
	
c_04: FOR i4 IN m-1 DOWNTO 0 GENERATE
	c_14:z(n*i4+3) <= d4(i4) ;
	END GENERATE;
	
c_05: FOR i5 IN m-1 DOWNTO 0 GENERATE
	c_1:z(n*i5+4) <= d5(i5) ;
	END GENERATE;
	
c_06: FOR i6 IN m-1 DOWNTO 0 GENERATE
	c_1:z(n*i6+5) <= d6(i6) ;
	END GENERATE;
	
c_07: FOR i7 IN m-1 DOWNTO 0 GENERATE
	c_1:z(n*i7+6) <= d7(i7) ;
	END GENERATE;
	
c_08: FOR i8 IN m-1 DOWNTO 0 GENERATE
	c_1:z(n*i8+7) <= d8(i8) ;
	END GENERATE;
	
c_09: FOR i9 IN m-1 DOWNTO 0 GENERATE
	c_1:z(n*i9+8) <= d9(i9) ;
	END GENERATE;

d(5 DOWNTO 0) <= "000000";
g1(0) <= '0';
g1(m+1) <= '0';
g1(m+2) <= '0';



c_4:FOR x IN m-1 DOWNTO 0 GENERATE
	c_7: ENTITY WORK.csa GENERIC MAP(n => n) PORT MAP( z((x*n)+n-1 downto (x*n)) , d(((x+1)*(n-3))-1 DOWNTO (x)*(n-3)) , d(((x+2)*(n-3))-1 DOWNTO (x+1)*(n-3)) ,g0(x),g1(x+1));
	END GENERATE;

f_adder_1: ENTITY WORK.fulladder_1bit PORT MAP( d((m+1)*(n-3)-1) , d((m+1)*(n-3)-2) , d((m+1)*(n-3)-3) ,w1,w2);
f_adder_2: ENTITY WORK.fulladder_1bit PORT MAP( d((m+1)*(n-3)-4) , d((m+1)*(n-3)-5) , d((m+1)*(n-3)-6) ,w3,w4);
f_adder_3: ENTITY WORK.fulladder_1bit PORT MAP(w1,w3,'0',c1,w5);
f_adder_4: ENTITY WORK.fulladder_1bit PORT MAP(w2,w4,w5,c2,c3);
g0(m)<= c1;
g0(m+1)<= c2;
g0(m+2)<= c3;



se:ENTITY WORK.fulladder_nbit GENERIC MAP (n => m+3) PORT MAp(g0,g1,'0',c(m+2 DOWNTO 0),c(m+3));

END structural;	