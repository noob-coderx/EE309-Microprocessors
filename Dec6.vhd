Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dec6 is 
  port (IRin,PCin :in std_logic_vector( 15 downto 0);
        IRout, PCout: out std_logic_vector(15 downto 0);
		  clock, Wr: in std_logic;
        LMSM : in std_logic_vector(2 downto 0);
		  Destin: out std_logic_vector(2 downto 0); 
        Zero_flag: in std_logic; Carry_flag : in std_logic; 
        Wr_rf: out std_logic;
        A3 : out std_logic_vector(2 downto 0));
end entity Dec6 ;


architecture Struct of Dec6 is

  --signal y_31,y_30,y_21,y_20,y_11,y_10,y_01,y_00 : std_logic;
signal PCstore,IRstore: std_logic_vector(15 downto 0);
begin
Str: process(IRin, PCin, LMSM, Wr, clock)
	begin
		if(clock' event and clock = '0') then
		 if(Wr = '1') then
			PCstore <= Pcin;
			IRstore <= IRin;
		 end if;
		end if;
		 PCout <= PCstore;
	    IRout <= IRstore;
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
        if((Carry_flag = '0')  and ((IRstore(15 downto 12) = "0001") or (IRstore(15 downto 12) = "0010"))and (IRstore(1 downto 0) = "10")) then 
            Wr_rf <= '0';
            A3 <= "111";   -- Dont care value
        elsif((Zero_flag = '0') and ((IRstore(15 downto 12) = "0001") or (IRstore(15 downto 12) = "0010")) and (IRstore(1 downto 0) = "01")) then
            Wr_rf <= '0';
            A3  <= "111";  -- Dont care value 
        elsif(IRstore(15 downto 12) = "0101" or IRstore(15 downto 14) = "10") then
            Wr_rf <= '0';
            A3 <= "111";   -- Dont care value
        elsif (IRstore(15 downto 12) = "0001") or (IRstore(15 downto 12) = "0010")  then
            Wr_rf <= '1';
            A3 <= IRstore(5 downto 3);
        elsif(IRstore(15 downto 12) = "0011" or IRstore(15 downto 14) = "11" or (IRstore(15 downto 12) = "0100")) then
            Wr_rf <= '1';
            A3 <= IRstore(11 downto 9);
        elsif((IRstore(15 downto 12) = "0000"))then
            Wr_rf <= '1';
            A3 <= IRstore(8 downto 6);
        elsif((IRstore(15 downto 12) = "0110") and (not (IRstore(7 downto 0) = "00000000")))then   -- the code that the device gives for whether the LMSM unit has some ones left
            Wr_rf <= '1';
            A3 <= LMSM;
        else 
            WR_rf <= '0';
            A3 <= "111";     -- Dont care values
		  end if;
	end process Str;
end Struct;