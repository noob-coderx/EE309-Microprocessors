library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Writer is
    port(
		    clock: in std_logic; stopbit: in std_logic_vector(1 downto 0);
          PClineSelector, UnconditionalWr, PCWr, IR2Wr, IR3Wr, stage2Bubble, stage3Bubble, stage4Bubble, IR3sel: out std_logic);
end entity Writer;

architecture bhv of Writer is

    begin
        alu_proc: process(clock, stopbit)
    begin
        if(stopbit = "11") then
		    PClineSelector <= '1';
			 UnconditionalWr <= '1';
			 PCWr <= '0';
			 IR2Wr <= '1';
			 IR3Wr <= '1';
			 stage2Bubble <= '0';------this wasn't needed apparently changed this on 26th of may
			 stage3Bubble <= '1';
			 stage4Bubble <= '1';
			 IR3sel <= '0';
			elsif(stopbit = "01") then
			 PClineSelector <= '0';
			 UnconditionalWr <= '0';
			 PCWr <= '0';
			 IR2Wr <= '0';
			 IR3Wr <= '0';
			 stage4Bubble <= '1';
			 stage2Bubble <= '0';
			 stage3Bubble <= '0';
			 IR3sel <= '0';
			elsif(stopbit = "10") then
			 PClineSelector <= '0';
			 UnconditionalWr <= '0';
			 PCWr <= '1';---
			 IR2Wr <= '1';---
			 IR3Wr <= '1';
			 stage2Bubble <= '0';
			 stage3Bubble <= '0';
			 stage4Bubble <= '0';
			 IR3sel <= '0';--Selects instruction from SMLMUnit instead of IM
			else
			 PClineSelector <= '0';
			 UnconditionalWr <= '0';
			 PCWr <= '1';
			 IR2Wr <= '1';
			 IR3Wr <= '1';
			 stage2Bubble <= '0';
			 stage3Bubble <= '0';
			 stage4Bubble <= '0';
			 IR3sel <= '0';
			end if;
	 end process;
    end architecture bhv;