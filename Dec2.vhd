Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dec2 is 
  port (IRin,PCin :in std_logic_vector( 15 downto 0); Wr, clock: in std_logic;
       IRout, PCout: out std_logic_vector(15 downto 0));
end entity Dec2 ;


architecture Struct of Dec2 is

  --signal y_31,y_30,y_21,y_20,y_11,y_10,y_01,y_00 : std_logic;
signal PCstore,IRstore: std_logic_vector(15 downto 0);
begin
Str: process(IRin, PCin, Wr, clock)
	begin
		if(clock' event and clock = '0') then
		 if(Wr = '1') then
			PCstore <= Pcin;
			IRstore <= IRin;
		 end if;
	  end if;
	  PCout <= PCstore;
	  IRout <= IRstore;
	end process Str;
end Struct;