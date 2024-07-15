Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dec5 is 
  port (IRin,PCin :in std_logic_vector( 15 downto 0); Wr, clock: in std_logic;
       Destin : out std_logic_vector(2 downto 0);
       IRout, PCout: out std_logic_vector(15 downto 0); WrMe, Sel : out std_logic);
end entity Dec5 ;


architecture Struct of Dec5 is

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
		
		if(IRstore(15 downto 12)="0001" or IRstore(15 downto 12)="0010") then
		 Destin <= IRstore(5 downto 3);
		elsif(IRstore(15 downto 12)="0000") then
		 Destin <= IRstore(8 downto 6);
		elsif(IRstore(15 downto 12)="0011" or IRstore(15 downto 12)="0100" or (IRstore(15 downto 12) = "1100" or IRstore(15 downto 12) = "1101" or IRstore(15 downto 12) = "1111")) then
		 Destin <= IRstore(11 downto 9);
		elsif(IRstore(15 downto 12)="0110") then
			 if(IRstore(6)='1') then
			  Destin <= "001";
			 elsif(IRstore(5)='1') then
			  Destin <= "010";
			 elsif(IRstore(4)='1') then
			  Destin <= "011";
			 elsif(IRstore(3)='1') then
			  Destin <= "100";
			 elsif(IRstore(2)='1') then
			  Destin <= "101";
			 elsif(IRstore(1)='1') then
			  Destin <= "110";
			 elsif(IRstore(0)='1') then
			  Destin <= "111";
			 else
			  Destin <= "000";
			 end if;
		else
		 Destin <= IRstore(5 downto 3);
		end if;
	  if((IRstore(15 downto 12)  = "0101") or	(IRstore(15 downto 12) = "0111" and (not (IRstore(7 downto 0) = "00000000")))) then
	     WrMe <= '1';
	  else
	     WrMe <= '0';
	  end if;
	--Write2Me
	Sel <= (not IRstore(15) and IRstore(14));--Sel 3out or output from Data storage
	PCout <= PCstore;
	IRout <= IRstore;	
	end process Str;
end Struct;