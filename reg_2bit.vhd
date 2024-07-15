library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_2bit is
    Port (
        Input : in  std_logic_vector(1 downto 0);
        Clock : in std_logic;
        Enable : in std_logic;
        Output : out std_logic_vector(1 downto 0)
    );
end reg_2bit;

architecture Behavioral of reg_2bit is
    signal TempReg : std_logic_vector(1 downto 0);
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if Enable = '1' then
                TempReg <= Input;
            end if;
        end if;
    end process;

    Output <= TempReg;
end Behavioral;