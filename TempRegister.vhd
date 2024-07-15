library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.ALL;
library work;
use work.Gates.all;

entity TempRegister is 
 port(A: in std_logic_vector(15 downto 0); clock,reset:in std_logic; Q:out std_logic_vector(15 downto 0));
end entity TempRegister;

architecture bi of TempRegister is
begin
one: dff_reset port map(D => A(0), clock => clock, reset => reset, Q => Q(0));
two: dff_reset port map(D => A(1), clock => clock, reset => reset, Q => Q(1));
three: dff_reset port map(D => A(2), clock => clock, reset => reset, Q => Q(2));
four: dff_reset port map(D => A(3), clock => clock, reset => reset, Q => Q(3));
five: dff_reset port map(D => A(4), clock => clock, reset => reset, Q => Q(4));
six: dff_reset port map(D => A(5), clock => clock, reset => reset, Q => Q(5));
seven: dff_reset port map(D => A(6), clock => clock, reset => reset, Q => Q(6));
eight: dff_reset port map(D => A(7), clock => clock, reset => reset, Q => Q(7));
nine: dff_reset port map(D => A(8), clock => clock, reset => reset, Q => Q(8));
ten: dff_reset port map(D => A(9), clock => clock, reset => reset, Q => Q(9));
eleven: dff_reset port map(D => A(10), clock => clock, reset => reset, Q => Q(10));
twelve: dff_reset port map(D => A(11), clock => clock, reset => reset, Q => Q(11));
thirteen: dff_reset port map(D => A(12), clock => clock, reset => reset, Q => Q(12));
fourteen: dff_reset port map(D => A(13), clock => clock, reset => reset, Q => Q(13));
fifteen: dff_reset port map(D => A(14), clock => clock, reset => reset, Q => Q(14));
sixteen: dff_reset port map(D => A(15), clock => clock, reset => reset, Q => Q(15));

end bi;