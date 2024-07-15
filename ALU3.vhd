library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity ALU3  is
  port (A,B: in std_logic_vector(15 downto 0); sum: out std_logic_vector(15 downto 0));
end entity ALU3;

architecture Struct of ALU3 is
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
  return sumf(15 downto 0);
end add;


begin
 alu_proc: process(A,B)
 variable summing:std_logic_vector(15 downto 0);
 begin
 summing:= add(A,B);
 sum<=summing;

	end process;
end Struct;