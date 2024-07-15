library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port (inst: in std_logic_vector(15 downto 0);
			opcode : in std_logic_vector(3 downto 0);
			a1,a2,regc:out std_logic_vector(2 downto 0);
			cb : out std_logic;
			cz : out std_logic_vector(1 downto 0);
			imm6: out std_logic_vector(5 downto 0);
			imm9 : out std_logic_vector(8 downto 0));
end decoder;

architecture bhv of decoder is
begin
	opcode <= inst(15 downto 11);
	a1<=inst(11 downto 9);
	a2<=inst(8 downto 6);
	regc<=inst(5 downto 3);
	imm6<=inst(5 downto 0);
	imm9<=inst(8 downto 0);
	cb <= inst(2);
	cz<= inst(1 downto 0);
	

	
end bhv;



