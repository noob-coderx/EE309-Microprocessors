library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity pc_update  is
  port (A: in std_logic_vector(15 downto 0); sum: out std_logic_vector(15 downto 0));
end entity pc_update;

architecture Struct of pc_update is
begin
 alu_proc: process(A)

		variable carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
  	      sum(i) <= A(i) xor '1' xor '0';
		  carry(i) := A(i) and '1';
	  else 
	    sum(i) <= A(i) xor '0' xor carry(i-1);
		 carry(i) := (A(i) and '0') or (carry(i-1) and (A(i) xor '0'));
	  end if;
	end loop L1;

	end process;
end Struct;