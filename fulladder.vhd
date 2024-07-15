library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity fulladder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity fulladder;

architecture Struct of fulladder is
  signal x, w, z : std_logic;
begin
  -- component instances
  
  XOR1: XOR_2 port map (A => A, B =>B, Y=>x);
  XOR2: XOR_2 port map (A => x, B =>Cin, Y=>S);
  AND1: AND_2 port map (A => Cin, B=>x, Y=>w);
  AND2: AND_2 port map (A => A, B=>B, Y=>z);
  OR1: OR_2 port map (A=>w, B=>z, Y=> Cout);

end Struct;