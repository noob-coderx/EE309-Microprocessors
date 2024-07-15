library ieee;
use ieee.std_logic_1164.all;

entity LMSMcomponent is
	port (inpinst  : in std_logic_vector(15 downto 0);
			outreg : out std_logic_vector(2 downto 0);
			outinst : out std_logic_vector(15 downto 0)
			);
end LMSMcomponent;

architecture bhv of LMSMcomponent is


function reg(inp: in std_logic_vector(7 downto 0))
    return std_logic_vector is
	   
variable s : std_logic_vector(10 downto 0) := (others => '0');
    begin

if inp(0) = '1' then
s:= "11111110000";
elsif inp(1) = '1' then
s:="11111101001";
elsif inp(2) = '1' then
s:="11111011010";
elsif inp(3) = '1' then
s:="11110111011";
elsif inp(4) = '1' then
s:="11101111100";
elsif inp(5) = '1' then
s:="11011111101";
elsif inp(6) = '1' then
s:="10111111110";
elsif inp(7) = '1' then
s:="01111111111";
else
null;
end if;
return s;
end reg;

function invert(inp: in std_logic_vector(7 downto 0))
return std_logic_vector is
variable s : std_logic_vector(15 downto 0):=(others =>'0');
begin
s(15):=inp(0);
s(14):=inp(1);
s(13):=inp(2);
s(12):=inp(3);
s(11):=inp(4);
s(10):=inp(5);
s(9):=inp(6);
s(8):=inp(7);

return s(15 downto 8);
end invert;


begin
cmp_process:process(inpinst)
variable k : std_logic ;
variable invertstore : std_logic_vector(7 downto 0);
variable tempand : std_logic_vector(10 downto 0);
variable instr_new : std_logic_vector(7 downto 0);
variable invert_back : std_logic_vector(7 downto 0);
begin

if((inpinst(15 downto 12) = "0110") or (inpinst(15 downto 12) = "0111")) then

k:= inpinst(1) or inpinst(2) or inpinst (3) or inpinst(4) or inpinst(5) or inpinst(6) or inpinst(0);


if(k = '1') then

	invertstore := invert(inpinst(7 downto 0));
	tempand:=reg(invertstore);
	outreg<=tempand(2 downto 0);
	instr_new := tempand(10 downto 3) and invertstore;
	invert_back := invert(instr_new);
	outinst(7 downto 0) <= invert_back;
	outinst(15 downto 8)<=inpinst(15 downto 8);

		else 
outinst(7 downto 0) <= "00000000";
	outinst(15 downto 8)<=inpinst(15 downto 8);

		end if;
		else 
		null;

		end if;




end process cmp_process; 
end bhv;