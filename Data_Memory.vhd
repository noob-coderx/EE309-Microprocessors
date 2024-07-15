----Instruction memory


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 	 
use ieee.std_logic_unsigned.all;

entity Data_Memory is 
port(
    M_add, M_inp : in std_logic_vector(15 downto 0);
    M_data : out std_logic_vector(15 downto 0);
    clock, Mem_R, Mem_W : in std_logic);
end entity Data_Memory;

architecture behav of Data_Memory is

-- address of any location in memory is 16 bit. so memory size is 2^16
type array_of_vectors is array (65535 downto 0) of std_logic_vector(15 downto 0);
signal memory_storage : array_of_vectors := (0 => "0001001010011000", 
                                             1 => "0001011010100000", 
                                             2 => "0001101110010010", 
                                             3 => "0001010010001000",  --- this is just random data filled in the data_memory
															4 => "0001101110010000",
															5 => "0001101111100010",
															6 => "0001100100001000",
															7 => "0000000000000011",
															8 => "1000000000001001",
															9 => "1000000000001100",
                                            others => "0000000000000101");
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
