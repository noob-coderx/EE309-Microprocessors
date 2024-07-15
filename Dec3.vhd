Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dec3 is 
  port (IRin,PCin :in std_logic_vector( 15 downto 0);
        SMLMinp : in std_logic_vector(2 downto 0); 
		  Wr, clock: in std_logic;
        IRout, PCout: out std_logic_vector(15 downto 0); 
		  A1, A2 : out std_logic_vector(2 downto 0); 
		  bit2denotenumberofsources : out std_logic_vector(1 downto 0);
		  SMLMUnit: out std_logic);
end entity Dec3 ;


architecture Struct of Dec3 is

  --signal y_31,y_30,y_21,y_20,y_11,y_10,y_01,y_00 : std_logic;
signal PCstore,IRstore: std_logic_vector(15 downto 0);
begin
Str: process(IRin, PCin, Wr, clock)
	begin
		if(clock' event and clock = '0') then
		 if(Wr = '1') then
			PCstore <= Pcin;
			IRstore <= IRin;
			PCout <= PCstore;
	      IRout <= IRstore;
		 end if;
	  end if;
	  if(IRstore(15 downto 12) = "0001" or IRstore(15 downto 12) = "0010" or IRstore(15 downto 13) = "100" or IRstore(15 downto 12) = "1010"or IRstore(15 downto 12) = "0101" or IRstore(15 downto 12) ="0111") then
		    bit2denotenumberofsources <= "00"; --Both source
		 elsif(IRstore(15 downto 12) = "0011" or IRstore(15 downto 0) = "1011") then
		    bit2denotenumberofsources <= "11"; --No sources
		 elsif(IRstore(15 downto 12) = "0000" or IRstore(15 downto 12) ="0110" or IRstore(15 downto 12) = "1111") then
		    bit2denotenumberofsources <= "01"; --Only A is source
		 elsif(IRstore(15 downto 12) = "0000" or IRstore(15 downto 13) ="010" or IRstore(15 downto 12) = "1101") then
		    bit2denotenumberofsources <= "10"; --Only B is source
		end if;
	A1 <= IRstore(11 downto 9);
	if(IRstore(15 downto 12) = "0111") then
	  A2 <= SMLMinp;
	elsif(IRstore(15 downto 12) = "1111") then
	  A2 <= IRstore(11 downto 9);
	else
	  A2 <= IRstore(8 downto 6);
	end if;
	PCout <= PCstore;
	IRout <= IRstore;
   if(IRstore(15 downto 13) = "011" and (not (IRstore(7 downto 0) = "00000000"))) then
    SMLMUnit <= '1';
	else
	 SMLMUnit <= '0';
	end if;
	end process Str;
end Struct;