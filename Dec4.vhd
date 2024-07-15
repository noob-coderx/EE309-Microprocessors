Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dec4 is 
  port (IRin,PCin :in std_logic_vector( 15 downto 0); Wr, clock, HazardBit: in std_logic;
       IRprevopcod : in std_logic_vector(15 downto 0);
       HazardbitsA, HazardbitsB: in std_logic_vector(1 downto 0);
       IRout, PCout: out std_logic_vector(15 downto 0); IRopcod : out std_logic_vector(7 downto 0);
		 SelALU_A,SelALU_B,Destin: out std_logic_vector(2 downto 0);
		 CZ : out std_logic_vector(1 downto 0);
		 SEBit,Cb,ALU3inp,STorSM: out std_logic);
end entity Dec4 ;


architecture Struct of Dec4 is

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
		else
		 Destin <= IRstore(5 downto 3);
		end if;
		 
	 if(IRstore(15 downto 12) = "1100" or IRstore(15 downto 12) = "1111"or IRstore(15 downto 12) = "0011") then
		   SEBit <= '1';--9bits
		 else
		   SEBit <= '0';--6b
		 end if;
		 -----------------------------SE to extend 9 bits or 6 bits
		 if(IRstore(15 downto 12) = "1100" or IRstore(15 downto 12) = "1101" or IRstore(15 downto 12) = "1111") then
		   ALU3inp <= '1';
		 else
		   ALU3inp <= '0';
		 end if;
		 -----------------------------ALU3input from multiplexer of ALU A or PC
		 if(IRstore(15 downto 13) = "011" and HazardBit = '1') then
		     SelALU_A <= "001";
		 elsif(IRstore(15 downto 12) = "0001" or IRstore(15 downto 12) = "0010" or IRstore(15 downto 12) = "0000" or IRstore(15 downto 12) = "1000" or IRstore(15 downto 12) = "1001" or IRstore(15 downto 12) = "1010" or IRstore(15 downto 13) = "011") then
		    if(HazardbitsA = "00") then--denotes no Hazard
			  SelALU_A <= "000" ;-- Selects D1
			 elsif(HazardbitsA = "01") then--denotes ID(S1)=IE(D)
			  SelALU_A <= "001" ;--Selects 3out
			 elsif(HazardbitsA = "10") then--denotes ID(S1)=Mem(D) Also when add instruction collides with load(ID(S1)=IE(D)), we halt for one cycle and then this condition becomes true in next cycle
			  SelALU_A <= "010" ;--Selects 4 out
			 elsif(HazardbitsA = "11") then--denotes ID(S1)=Mem(D) Also when add instruction collides with load(ID(S1)=IE(D)), we halt for one cycle and then this condition becomes true in next cycle
			  SelALU_A <= "111" ;--Selects 5 out
			 else
			  SelALU_A <= "000";--just preventing latching
			 end if;
		elsif(IRstore(15 downto 12) = "1100" or IRstore(15 downto 12) = "1101" or IRstore(15 downto 12) = "1111") then
		   SelALU_A <= "011" ;--Selects PC for Jump instructions
		else
		   SelALU_A <= "100" ;--Selects Imm value for all leftout instructions
		end if;--Select line for ALU_A done-------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------
		if(IRstore(15 downto 12) = "0001" or IRstore(15 downto 12) = "0010" or IRstore(15 downto 12) = "0100" or IRstore(15 downto 12) = "0101" or IRstore(15 downto 12) = "1000" or IRstore(15 downto 12) = "1001" or IRstore(15 downto 12) = "1010") then
		    if(HazardbitsB = "00") then--denotes no Hazard
			  SelALU_B <= "000" ;-- Selects D1
			 elsif(HazardbitsB = "01") then--denotes ID(S2)=IE(D)
			  SelALU_B <= "001" ;--Selects 3out
			 elsif(HazardbitsB = "10") then--denotes ID(S2)=Mem(D) Also when add instruction collides with load(ID(S1)=IE(D)), we halt for one cycle and then this condition becomes true in next cycle
			  SelALU_B <= "010" ;--Selects 4 out
			 elsif(HazardbitsB = "11") then--denotes ID(S2)=Mem(D) Also when add instruction collides with load(ID(S1)=IE(D)), we halt for one cycle and then this condition becomes true in next cycle
			  SelALU_B <= "111" ;--Selects 5 out
			 else
			  SelALU_B <= "000";--just preventing latching
			 end if;
		elsif(IRstore(15 downto 12) = "1100" or IRstore(15 downto 12) = "1101" or IRstore(15 downto 12) = "1111") then
		   SelALU_B <= "011" ;--Selects +1 for Jump instructions
		elsif(IRstore(15 downto 12) = "0110" or IRstore(15 downto 12) = "0111") then
		   if((IRstore(15 downto 12) = IRprevopcod(15 downto 12)) and ( not (IRprevopcod(7 downto 0) = "00000000"))) then
		    SelALU_B <= "011" ;--Selects output +1
			else
			 SelALU_B <= "110";--Select 0
			end if;
		else
		   SelALU_B <= "100";--Selects Imm value for all leftout instructions
		end if;--Sel line of ALU_B done-------------------------------------------------------------------------------------------------------
		----------------------------------------------------------------------------------------------------------------------------
		if(IRstore(15 downto 12) = "1101" or IRstore(15 downto 12) = "1111") then
		 ALU3inp <= '1';
		else
		 ALU3inp <= '0';
		end if;
		if(IRstore(15 downto 12)="0111") then
		 STorSM <= '1';
		else
		 STorSM <= '0';
		end if;
	IRopcod <= IRstore(15 downto 8);
	CZ <= IRstore(1 downto 0);
	Cb <= IRstore(2);
	PCout <= PCstore;
	IRout <= IRstore;	
	end process Str;
end Struct;