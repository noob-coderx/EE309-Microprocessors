library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Hazard_detect is
    port(
		    IR_STAGE_5: in std_logic_vector(15 downto 0);IR_STAGE_6: in std_logic_vector(15 downto 0);
			 IR_STAGE_4: in std_logic_vector(15 downto 0);S1I3, S2I3, DI4,DI5, DI6: in std_logic_vector(2 downto 0);
			 CZ1,CZ2,CZ3: in std_logic_vector(1 downto 0);
			 carryflag, zeroflag: in std_logic;
			 NumS: in std_logic_vector(1 downto 0);
          HazardBitsA,HazardBitsB,stopbit : out std_logic_vector(1 downto 0);
			 HazardBit : out std_logic
        );
end entity Hazard_detect;
architecture bhv of Hazard_detect is

    begin
        alu_proc: process(IR_STAGE_4, S1I3, S2I3, DI4, DI5, carryflag, zeroflag)
    begin
        ---------------------------------------------------------
		  if((IR_STAGE_4(15 downto 12) = "1100" or IR_STAGE_4(15 downto 12) = "1101" or IR_STAGE_4(15 downto 12) = "1111") or (IR_STAGE_4(15 downto 12) = "1000" and Zeroflag = '1') or (IR_STAGE_4(15 downto 12) = "1001" and carryflag = '1') or (IR_STAGE_4(15 downto 12) = "1010" and (carryflag = '1' or Zeroflag = '1'))) then
		     stopbit <= "11";
        elsif (NumS = "00") then
            if ((IR_STAGE_4(15 downto 12)) = "0100" and ((S1I3 = DI4) or (S2I3 = DI4))) then 
				   stopbit <= "01";
            else 
				   stopbit <= "00";
				   if(S1I3 = DI4 and not((IR_STAGE_4(15 downto 12)="0001" or IR_STAGE_4(15 downto 12)="0010") and ((IR_STAGE_4(1 downto 0)="01" and CZ1(1)='0') or (IR_STAGE_4(1 downto 0)="10" and CZ1(0)='0')))) then
					  HazardBitsA <= "01";
					elsif(S1I3 = DI5 and not((IR_STAGE_5(15 downto 12)="0001" or IR_STAGE_5(15 downto 12)="0010") and ((IR_STAGE_5(1 downto 0)="01" and CZ2(1)='0') or (IR_STAGE_5(1 downto 0)="10" and CZ2(0)='0')))) then
				     HazardBitsA <= "10";
					elsif(S1I3 = DI6 and not((IR_STAGE_6(15 downto 12)="0001" or IR_STAGE_6(15 downto 12)="0010") and ((IR_STAGE_6(1 downto 0)="01" and CZ3(1)='0') or (IR_STAGE_6(1 downto 0)="10" and CZ3(0)='0')))) then
					  HazardBitsA <= "11";
					else
				       HazardBitsA <= "00";
					end if;
					  
					if(S2I3 = DI4 and not((IR_STAGE_4(15 downto 12)="0001" or IR_STAGE_4(15 downto 12)="0010") and ((IR_STAGE_4(1 downto 0)="01" and CZ1(1)='0') or (IR_STAGE_4(1 downto 0)="10" and CZ1(0)='0')))) then
					  HazardBitsB <= "01";
					elsif(S2I3 = DI5 and not((IR_STAGE_5(15 downto 12)="0001" or IR_STAGE_5(15 downto 12)="0010") and ((IR_STAGE_5(1 downto 0)="01" and CZ2(1)='0') or (IR_STAGE_5(1 downto 0)="10" and CZ2(0)='0')))) then
				     HazardBitsB <= "10";
					elsif(S2I3 = DI6 and not((IR_STAGE_6(15 downto 12)="0001" or IR_STAGE_6(15 downto 12)="0010") and ((IR_STAGE_6(1 downto 0)="01" and CZ3(1)='0') or (IR_STAGE_6(1 downto 0)="10" and CZ3(0)='0')))) then
					  HazardBitsB <= "11";
					else
				       HazardBitsB <= "00";
					end if;
				end if;

        elsif (NumS = "01")  then
            if (IR_STAGE_4(15 downto 12) = "0100" and S1I3 = DI4)   then
				 stopbit <= "01";
            else
				     stopbit <= "00";
				    HazardBitsB <= "00";
                if(S1I3 = DI4 and not((IR_STAGE_4(15 downto 12)="0001" or IR_STAGE_4(15 downto 12)="0010") and ((IR_STAGE_4(1 downto 0)="01" and CZ1(1)='0') or (IR_STAGE_4(1 downto 0)="10" and CZ1(0)='0')))) then
					  HazardBitsA <= "01";
					elsif(S1I3 = DI5 and not((IR_STAGE_5(15 downto 12)="0001" or IR_STAGE_5(15 downto 12)="0010") and ((IR_STAGE_5(1 downto 0)="01" and CZ2(1)='0') or (IR_STAGE_5(1 downto 0)="10" and CZ2(0)='0')))) then
				     HazardBitsA <= "10";
					elsif(S1I3 = DI6 and not((IR_STAGE_6(15 downto 12)="0001" or IR_STAGE_6(15 downto 12)="0010") and ((IR_STAGE_6(1 downto 0)="01" and CZ3(1)='0') or (IR_STAGE_6(1 downto 0)="10" and CZ3(0)='0')))) then
					  HazardBitsA <= "11";
					else
				       HazardBitsA <= "00";
					end if;
				end if;
		  elsif (NumS = "10")  then
            if (IR_STAGE_4(15 downto 12) = "0100" and S2I3 = DI4)  then
                stopbit <= "01"; 
            else
				     stopbit <= "00";
                HazardBitsA <= "00";
					 if(S2I3 = DI4 and not((IR_STAGE_4(15 downto 12)="0001" or IR_STAGE_4(15 downto 12)="0010") and ((IR_STAGE_4(1 downto 0)="01" and CZ1(1)='0') or (IR_STAGE_4(1 downto 0)="10" and CZ1(0)='0')))) then
					  HazardBitsB <= "01";
					elsif(S2I3 = DI5 and not((IR_STAGE_5(15 downto 12)="0001" or IR_STAGE_5(15 downto 12)="0010") and ((IR_STAGE_5(1 downto 0)="01" and CZ2(1)='0') or (IR_STAGE_5(1 downto 0)="10" and CZ2(0)='0')))) then
				     HazardBitsB <= "10";
					elsif(S2I3 = DI6 and not((IR_STAGE_6(15 downto 12)="0001" or IR_STAGE_6(15 downto 12)="0010") and ((IR_STAGE_6(1 downto 0)="01" and CZ3(1)='0') or (IR_STAGE_6(1 downto 0)="10" and CZ3(0)='0')))) then
					  HazardBitsB <= "11";
					else
				       HazardBitsB <= "00";
					end if;
            end if;
		  else
		      HazardBitsA <= "00";
				HazardBitsB <= "00";
				stopbit <= "00";
		  end if;	
		  
		  if((IR_STAGE_4(15 downto 13) = "011") and (not (IR_STAGE_4(7 downto 0) = "00000000"))) then
		     stopbit <= "10";
			  HazardBit <= '1';
		  else
		     HazardBit <= '0';
		  end if;
	 end process;
    end architecture bhv;