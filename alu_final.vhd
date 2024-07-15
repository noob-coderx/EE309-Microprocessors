library ieee;
use ieee.std_logic_1164.all;

entity alu_final is
	port (
			clock: in std_logic;
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	sel,OpCZ: in std_logic_vector(3 downto 0);
	cfi,zfi,cb: in std_logic;					--cb is complement bit
	cz : in std_logic_vector(1 downto 0);
	X: out std_logic_vector(15 downto 0);
	cfo,zfo : out std_logic);
end alu_final;

architecture a1 of alu_final is
function add(A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0))
    return std_logic_vector is
	   variable sumF : std_logic_vector(16 downto 0) := (others => '0');
	   variable sum : std_logic_vector(15 downto 0) := (others => '0');
		variable carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
  	      sum(i) := A(i) xor B(i) xor '0';
		  carry(i) := A(i) and B(i);
	  else 
	    sum(i) := A(i) xor B(i) xor carry(i-1);
		 carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) xor B(i)));
	  end if;
	end loop L1;
	sumf(16) := carry(15);
	sumf(15 downto 0):= sum(15 downto 0);
  return sumf;
end add;

function anding(A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0))
    return std_logic_vector is
	  variable s : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		 s(i) := A(i) and B(i);
		end loop L1;
  return s;
end anding;

function zero_check(A: in std_logic_vector(15 downto 0))
    return std_logic is
	  variable s,t : std_logic := '0';
    begin
		 s := A(0) or A(1) or A(2) or A(3) or A(4) or A(5) or A(6) or A(7) or A(8) or A(9) or A(10) or A(11) or A(12) or A(13) or A(14) or A(15);
		 t := not s;
		
  return t;
end zero_check;


function comp(A: in std_logic_vector(15 downto 0))
    return std_logic_vector is
	  variable s : std_logic_vector(15 downto 0) := (others => '0');
	  variable t : std_logic_vector(16 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		 s(i) := (not A(i));
		 
		end loop L1;
		t := add(s,"0000000000000001");
  return t(15 downto 0);
end comp;



function lli(A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0))
    return std_logic_vector is
	         variable temp_result : std_logic_vector(15 downto 0);
    begin
        temp_result:= "0000000"&A(8 downto 0);       
		   
  return temp_result;
end lli;



begin
alu_proc: process(A, B, sel, cb,cz,cfi,zfi,OpCZ)
variable temp3,temp4: std_logic_vector(16 downto 0);
variable temp,temp1,temp2: std_logic_vector(15 downto 0);
variable cp,cr: std_logic;
begin
    if ((sel = "0001" and (cz = "10" or cz = "01" or cz = "00") and cb = '0') or (sel = "0000"))then 
	   
      temp3 := add(A,B);
	   X<= temp3(15 downto 0);	
	   cfo <= temp3(16);
		zfo <= zero_check(temp3(15 downto 0));
		
    elsif (sel="0001" and cz = "11" and cb = '0' and cfi ='1') then
	   --temp1:= comp(A);
      temp3 := add(A,B);
		cp := temp3(16);
		temp4 := add(temp3(15 downto 0),"0000000000000001");
		cr := temp4(16);
		X<=temp4(15 downto 0);
		cfo<=cp or cr;
		zfo <= zero_check(temp4(15 downto 0));
		
		    elsif (sel="0001" and cz = "11" and cb = '0' and cfi ='0') then
	   --temp1:= comp(A);
      temp3 := add(A,B);
		X<=temp3(15 downto 0);
		cfo <= temp3(16);
		zfo <= zero_check(temp3(15 downto 0));

    elsif (sel = "0001" and (cz = "10" or cz = "01" or cz = "00") and cb = '1') then
      
		temp1:= comp(B);
      temp3 := add(A,temp1);
		X<=temp3(15 downto 0);
		cfo <=  not temp3(16);
		zfo <= zero_check(temp3(15 downto 0));
		
		 elsif (sel="0001" and cz = "11" and cb = '1' and cfi ='1') then
	   temp1:= comp(B);
      temp3 := add(A,temp1);
		cp := not temp3(16);
		temp4 := add(temp3(15 downto 0),"0000000000000001");
      cr := not temp4(16);
		X<=temp4(15 downto 0);
		cfo<=cp or cr;
		zfo <= zero_check(temp4(15 downto 0));		
		
		elsif (sel="0001" and cz = "11" and cb = '1' and cfi ='0') then
	   temp1:= comp(B);
      temp3 := add(A,temp1);
		X<=temp3(15 downto 0);
		cfo <= not temp3(16);
		zfo <= zero_check(temp3(15 downto 0));
		
--------------------------------------------------------------------------------------------------- add over
				
		
	 elsif (sel="0010"  and (cz = "10" or cz = "01" or cz = "00") and cb = '0') then
      temp1 := anding(A, B);
		temp := not temp1;
		X <= temp;
		cfo <= cfi;
		zfo <= zero_check(temp);
		
	elsif (sel = "0010" and (cz = "10" or cz = "01" or cz = "00") and cb = '1') then
		temp1:= comp(B);
      temp2 := anding(A,temp1);
		temp := not temp2;
		X<=temp(15 downto 0);
		cfo <= cfi;
		zfo <= zero_check(temp);
		
----------------------------------------------------------------------------------------------------------nand over		

	elsif (sel="0011") then
      temp := lli(A,B);
		X <= temp;
----------------------------------------------------------------------------------------------------------LLI over
   elsif(sel = "0100" or sel = "0101" or sel = "0110" or sel = "0111" or sel = "1100" or sel = "1101" or sel = "1111") then
		temp3 := add(A,B);
		X <= temp3(15 downto 0);
		cfo <= cfi;
		zfo <= zfi;
----------------------------------------------------------------------------------------------------------LW,SW,LM,SM also all unconditional jumps
	elsif(sel = "1000" or sel = "1001" or sel = "1010" ) then
	   temp1 := Comp(B);
		temp3 := add(A, temp1);
		cfo <= not temp3(16);
		zfo <= Zero_check(temp3(15 downto 0));
----------------------------------------------------------------------------------------------------------BEQ,BLT,BLE
   elsif(sel = "1011") then
	   if(OpCZ(3 downto 2)="00") then
		   cfo <= cfi;
		elsif(OpCZ(3 downto 2)="01") then
		   cfo <= '1';
		elsif(OpCZ(3 downto 2)="10") then
		   cfo <= '0';
		else
		   cfo <= not cfi;
		end if;
		
		if(OpCZ(1 downto 0)="00") then
		   zfo <= zfi;
		elsif(OpCZ(1 downto 0)="01") then
		   zfo <= '1';
		elsif(OpCZ(1 downto 0)="10") then
		   zfo <= '0';
		else
		   zfo <= not zfi;
		end if;
----------------------------------------------------------------------------------------------------------U added FLag instructions cuz you're a nerd
	else
      null;
    end if;
	
end process;
end a1;