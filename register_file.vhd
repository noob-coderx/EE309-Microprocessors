library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity register_file is 
-- PC is R7 so incorporating it in register file itself
-- A1,A2,A3 are reg addresses, D1,D2,D3 are reg data PC_w is write enable for PC and and RF_W is write enable for writing on reg
-- PC_write is input port for PC and PC_read is output port for PC
port(
    clock, reset,  RF_W : in std_logic;
	 R0_w : in std_logic;
	 Pc_in : in std_logic_vector(15 downto 0);
    A1, A2, A3 : in std_logic_vector(2 downto 0);
    D3 : in std_logic_vector(15 downto 0);
    R0out, D1, D2: out std_logic_vector(15 downto 0));
end entity register_file;

architecture behav of register_file is

-- defining RF as an array of 8 regs storing 16 bit data
type reg_array_type is array (7 downto 0) of std_logic_vector(15 downto 0);
signal registers : reg_array_type := (0 => "0000000000000000", 
                                      1 => "0000000000000001", 
                                      2 => "0000000000000010", 
                                      3 => "0000000000000011", 
												  4 => "0000000000000100",
												  5 => "0000000000000001",
												  6 => "1111111111111111",
												  7 => "0000000000000111",
                                 others => "0000000000000000");

signal Register0: std_logic_vector(15 downto 0):="0000000000000000";
begin 

-- RF writing is synchronous
RF_writing : process(RF_W,clock,reset,PC_in)
    begin		  
        if (reset = '1') then
            L1 : for i in 1 to 7 loop
                registers(i) <= "0000000000000000";
            end loop L1;

        elsif(rising_edge(clock)) then
				if (RF_W = '1' and A3 /="000")then
					registers(to_integer(unsigned(A3))) <= D3;
					else null;
					end if;
        else
            null;
            end if;
    end process RF_writing;
PC_writing : process(R0_w,PC_in)
    begin		  
			Register0 <= PC_in;
    end process PC_writing;
-- RF reading is asynchronous
R0out <= Register0;
D1 <= registers(to_integer(unsigned(A1)));
D2 <= registers(to_integer(unsigned(A2)));
--PC_read <= registers(7);

end architecture behav;
