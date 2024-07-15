library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;


entity ALU_add  is

port(
	a : in std_logic_vector (15 downto 0);
b : in std_logic_vector(15 downto 0);
m : in std_logic;
outpt : out std_logic_vector(15 downto 0);
co,zf : out std_logic
);
end entity ALU_add;

architecture Struct of ALU_add is


component fulladder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end component fulladder;
  signal x0,X1,X2,X3,X4,X5,X6,X7,X8,x9,x10,x11,x12,x13,x14,x15,C1, C2, C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13  : std_logic;
  variable s : std_logic_vector(15 downto 0) := (others => '0');
begin


  -- component instances
  XOR1: XOR_2 port map (A => M, B => B(0), Y => x0);
  XOR2: XOR_2 port map (A => M, B => B(1), Y => x1);
  XOR3: XOR_2 port map (A => M, B => B(2), Y => x2);
  XOR4: XOR_2 port map (A => M, B => B(3), Y => x3);
  XOR5: XOR_2 port map (A => M, B => B(4), Y => x4);
  XOR6: XOR_2 port map (A => M, B => B(5), Y => x5);
  XOR7: XOR_2 port map (A => M, B => B(6), Y => x6);
  XOR8: XOR_2 port map (A => M, B => B(7), Y => x7);
  XOR9: XOR_2 port map (A => M, B => B(8), Y => x8);
  XOR10: XOR_2 port map (A => M, B => B(9), Y => x9);
  XOR11: XOR_2 port map (A => M, B => B(10), Y => x10);
  XOR12: XOR_2 port map (A => M, B => B(11), Y => x11);
  XOR13: XOR_2 port map (A => M, B => B(12), Y => x12);
  XOR14: XOR_2 port map (A => M, B => B(13), Y => x13);
  XOR15: XOR_2 port map (A => M, B => B(14), Y => x14);
  XOR16: XOR_2 port map (A => M, B => B(15), Y => x15);
  fulladder2: FULLADDER port map(A=>A(1), B=>x1, Cin=>C1, S=>S(1),Cout=>C2);
  fulladder3: FULLADDER port map(A=>A(2), B=>x2, Cin=>C2, S=>S(2),Cout=>C3);
  fulladder4: FULLADDER port map(A=>A(3), B=>x3, Cin=>C3, S=>S(3),Cout=>C4);
  fulladder5: FULLADDER port map(A=>A(4), B=>x4, Cin =>C4, S=>S(4), Cout=>C5);
  fulladder6: FULLADDER port map(A=>A(5), B=>x5, Cin=>C5, S=>S(5),Cout=>C6);
  fulladder7: FULLADDER port map(A=>A(6), B=>x6, Cin=>C6, S=>S(6),Cout=>C7);
  fulladder8: FULLADDER port map(A=>A(7), B=>x7, Cin=>C7, S=>S(7),Cout=>C8);
  fulladder9: FULLADDER port map(A=>A(8), B =>x8, Cin =>C8, S=>S(8), Cout=>C9);
  fulladder10: FULLADDER port map(A=>A(9), B=>x9, Cin=>C9, S=>S(9),Cout=>C10);
  fulladder11: FULLADDER port map(A=>A(10), B=>x10, Cin=>C10, S=>S(10),Cout=>C11);
  fulladder12: FULLADDER port map(A=>A(11), B=>x11, Cin=>C11, S=>S(11),Cout=>C12);
  fulladder13: FULLADDER port map(A=>A(12), B=>x12, Cin =>C12, S=>S(12), Cout=>C13);
  fulladder14: FULLADDER port map(A=>A(13), B=>x13, Cin=>C13, S=>S(13),Cout=>C14);
  fulladder15: FULLADDER port map(A=>A(14), B=>x14, Cin=>C14, S=>S(14),Cout=>C15);
  fulladder16: FULLADDER port map(A=>A(15), B=>x15, Cin=>C15, S=>S(15),Cout=>Co);
  AND1:AND_2 port map (A=>s(0),B=>s(1),Y=>a1);
  AND_2:AND_2 port map (A=>a(1),B=>s(2),Y=>a2);
  AND3:AND_2 port map (A=>a(2),B=>s(3),Y=>a3);
  AND1:AND_2 port map (A=>a(3),B=>s(4),Y=>a4);
  AND_2:AND_2 port map (A=>a(4),B=>s(5),Y=>a5);
  AND3:AND_2 port map (A=>a(5),B=>s(6),Y=>a6);
  AND1:AND_2 port map (A=>a(6),B=>s(7),Y=>a7);
  AND_2:AND_2 port map (A=>a(7),B=>s(8),Y=>a8);
  AND3:AND_2 port map (A=>a(8),B=>s(9),Y=>a9);
  AND1:AND_2 port map (A=>a(9),B=>s(10),Y=>a10);
  AND_2:AND_2 port map (A=>a(10),B=>s(11),Y=>a11);
  AND3:AND_2 port map (A=>a(11),B=>s(12),Y=>a12);
  AND1:AND_2 port map (A=>s(12),B=>s(13),Y=>a13);
  AND_2:AND_2 port map (A=>a(13),B=>s(14),Y=>a14);
  AND3:AND_2 port map (A=>a(14),B=>s(15),Y=>ZF);
 
end Struct;