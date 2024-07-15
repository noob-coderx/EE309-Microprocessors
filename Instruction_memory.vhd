----Instruction memory
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 	 
use ieee.std_logic_unsigned.all;

entity Instruction_memory is 
port(
    M_add, M_inp : in std_logic_vector(15 downto 0);
    M_data : out std_logic_vector(15 downto 0);
    clock, Mem_R, Mem_W : in std_logic);
end entity
 Instruction_memory;

architecture behav of Instruction_memory is

-- address of any location in memory is 16 bit. so memory size is 2^16
type array_of_vectors is array (65536 downto 0) of std_logic_vector(15 downto 0);
signal memory_storage : array_of_vectors := ( 0 => "0011011000000001",
													  1 => "0101011010000010",
													  2 => "0011001000001111",
													  3 => "0111111001111111",
													  4 => "0011111000000001",
													  5 => "0101011111000011",
													  others => "1110000000000000");
                                            --FIRST lets see if it can deal these independent instruction that are not even jump or BEQ

                                            
                                            --A miny testcase to check forwarding  uncomment and use

                                            -- (0 => "0001101111001000", -- this is r1 = r5 + r7 with no condition
                                            --  1 => "0001 001 111 110 0 1      0", --ADC or Add if carry = 1   r6 = r1 + r7  --Collision
                                            -- others => "0000000000000000");



                                           -- Memory_fetch
                                            --(0 => "0100 101 111 000001", -- this is r5 = M[r7 + IMM] with no condition 
                                            --  1 => "0001 001 111 110 0 00", --ADC or Add if carry = 1   r6 = r1 + r7  
                                            -- others => "0000000000000000");


                                            --Alright time for the string testcase (SMLM and Hazards)
                                            -- (0 => "0001101111001000", -- this is r1 = r5 + r7 with no condition
                                            --  1 => "0001101111001010", --ADC or Add if carry = 1   r1 = r5 + r7
                                            --  2 => "0110 010 0 11100000", -- LM from M[r3]->r5, M[r3 + 1]->r6, M[r3+2]->r7
                                            --  3 => "0110 010 0 00011000",  -- LM from M[r3]->r3 and M[r3 + 1]->r4 --crazy logic is that r3 will be changed after the first loading,
                                            --  --so whether our code takes the new r3 or prev r3(I think the question demands the previous value of r3)
                                            --  4 => "0001101111001000", --r1 = r5 + r7 with no condition
                                            --  5 => "0001 001 111 110 0 00", --r6 = r1 + r7 with no condition -- collision
                                            --  6 => "0001 001 010 111 0 00", --r7 = r2 + r1 --collision with 4 
                                            --  7 => "0010 001 010 111 0 00", -- r7 = r2 nand r1  
                                            --  8 => "0011 010 000001110", -- LLI immediate in the lower values of R3
                                            --  9 => "0111 010 000000111", --SM but values is taken from r3 this is will cause collision with the prev instruction
                                            --  10 => "1000 101 011 000001", -- BEQ for the WIN  no collision here though
                                            -- others => "0000000000000000");
                                    
                                            

begin
-- memory read and write is synchronous and has enable signal
memory_write: process(clock, Mem_W, M_inp, M_add)
    begin
        if(clock' event and clock = '1') then
            if (Mem_W = '1') then
                memory_storage(to_integer(unsigned(M_add))) <= M_inp;
            else 
                null;
            end if;
        else
            null;
        end if;
    end process;

memory_read: process(Mem_R, M_add)
    begin
	 if (Mem_R = '1') then
            M_data <= memory_storage(to_integer(unsigned(M_add))) ;
        else
            null;
        end if;
    end process;
end architecture behav;