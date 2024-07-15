library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity se10 is
    port (InputIR : in  std_logic_vector(15 downto 0);SEbit : in std_logic;Imm : out std_logic_vector(15 downto 0));
end se10;

architecture Struct of se10 is
    signal TempReg : std_logic_vector(15 downto 0):="0000000000000000";
begin
    process(InputIR, SEbit)
    begin
            if (SEbit = '1') then
                TempReg(15 downto 9) <= "0000000";
					 Tempreg(8 downto 0) <= InputIR(8 downto 0);
            else
                TempReg(15 downto 6) <= "0000000000";
					 Tempreg(5 downto 0) <= InputIR(5 downto 0);
        end if;
    end process;

    Imm <= TempReg;
end Struct;
