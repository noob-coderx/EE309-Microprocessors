library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;


entity ALU_plus1  is

port(
	a : in std_logic_vector (15 downto 0);
s : out std_logic_vector(15 downto 0);
c0,zf : out std_logic
);
end entity ALU_plus1;
architecture Struct of ALU_add is

component ALU_add  is

port(
	a : in std_logic_vector (15 downto 0);
b : in std_logic_vector(15 downto 0);
m : in std_logic;
s : out std_logic_vector(15 downto 0);
c0,zf : out std_logic
);
end component ALU_add;

signal inpt : std_logic_vector (15 downto 0);
signal outpt : std_logic_vector (15 downto 0);
signal c,z : std_logic;

begin
alu_add1 : ALU_add port map(inpt,"00000000000000001",'0',outpt,c,z);
s <= outpt;
end Struct;