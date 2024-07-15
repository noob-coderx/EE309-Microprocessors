library ieee;
use ieee.std_logic_1164.all;

--A package declaration is used to store a set of common declarations, such as components.
--These declarations can then be imported into other design units using a use clause.

package Gates is
  component INVERTER is
   port (A: in std_logic; Y: out std_logic);
  end component INVERTER;

  component AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component AND_2;

  component NAND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component NAND_2;

  component OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component OR_2;

  component NOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component NOR_2;

  component XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component XOR_2;

  component XNOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component XNOR_2;

  component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;
  
  component Dec5 is
  port (IRin,PCin :in std_logic_vector( 15 downto 0); Wr, clock: in std_logic;
       Destin : out std_logic_vector(2 downto 0);
       IRout, PCout: out std_logic_vector(15 downto 0); WrMe, Sel : out std_logic);
  end component Dec5;
  
  component Dec4 is
  port (IRin,PCin :in std_logic_vector( 15 downto 0);
       IRprevopcod : in std_logic_vector(15 downto 0);
       Wr, clock, HazardBit: in std_logic;
       HazardbitsA, HazardbitsB: in std_logic_vector(1 downto 0);
       IRout, PCout: out std_logic_vector(15 downto 0); IRopcod : out std_logic_vector(7 downto 0);
		 SelALU_A,SelALU_B,Destin: out std_logic_vector(2 downto 0);
		 CZ : out std_logic_vector(1 downto 0);
		 SEBit,Cb,ALU3inp, STorSM: out std_logic);
  end component Dec4;
  
  component Dec3 is
  port (IRin,PCin :in std_logic_vector( 15 downto 0);
        SMLMinp : in std_logic_vector(2 downto 0); 
		  Wr, clock: in std_logic;
        IRout, PCout: out std_logic_vector(15 downto 0); 
		  A1, A2 : out std_logic_vector(2 downto 0); 
		  bit2denotenumberofsources : out std_logic_vector(1 downto 0);
		  SMLMUnit: out std_logic);
  end component Dec3;
  
  component Dec2
   port (IRin,PCin :in std_logic_vector( 15 downto 0); Wr, clock: in std_logic; IRout, PCout: out std_logic_vector(15 downto 0));
  end component Dec2;
  
  component Data_Memory is
  port(
    M_add, M_inp : in std_logic_vector(15 downto 0);
    M_data : out std_logic_vector(15 downto 0);
    clock, Mem_R, Mem_W : in std_logic);
  end component  ;
  
  component Instruction_memory is
  port(
    M_add, M_inp : in std_logic_vector(15 downto 0);
    M_data : out std_logic_vector(15 downto 0);
    clock, Mem_R, Mem_W : in std_logic);
  end component;
  
  component Dec6 is
  port (IRin,PCin :in std_logic_vector( 15 downto 0);
        IRout, PCout: out std_logic_vector(15 downto 0); clock, Wr: in std_logic;
        LMSM : in std_logic_vector(2 downto 0);
		  Destin: out std_logic_vector(2 downto 0); 
        Zero_flag: in std_logic; Carry_flag : in std_logic; 
        Wr_rf: out std_logic;
        A3 : out std_logic_vector(2 downto 0));
  end component Dec6;
  
  component se10 is
      port (InputIR : in  std_logic_vector(15 downto 0);SEbit : in std_logic;Imm : out std_logic_vector(15 downto 0));
  end component;
  
  component ALU3 is
   port (A,B: in std_logic_vector(15 downto 0); sum: out std_logic_vector(15 downto 0));
  end component;

  
  component TempRegister is
   port(A: in std_logic_vector(15 downto 0); clock,reset:in std_logic; Q:out std_logic_vector(15 downto 0));
  end component TempRegister;
  
  component temporary_register is
  Port (
        Input : in  std_logic_vector(15 downto 0);
        Clock : in std_logic;
        Enable : in std_logic;
        Output : out std_logic_vector(15 downto 0)
    );
  end component   ;
  
  component reg_2bit is
  Port (
        Input : in  std_logic_vector(1 downto 0);
        Clock : in std_logic;
        Enable : in std_logic;
        Output : out std_logic_vector(1 downto 0)
    );
	end component;
	
	component reg_3bit is
	 Port (
        Input : in  std_logic_vector(2 downto 0);
        Clock : in std_logic;
        Enable : in std_logic;
        Output : out std_logic_vector(2 downto 0)
    );
	 end component;
	 
  component MUX_2_1  is
  port (S, A, B: in std_logic; Y: out std_logic);
  end component MUX_2_1;
  
  component MUX_1X2_16BIT is
  port (A,B: in std_logic_vector(15 downto 0) ;Sig_16BIT: in std_logic;Y: out std_logic_vector(15 downto 0));
  end component;
  component MUX_4X1_16BIT is
  port (D3,D2,D1,D0 : in std_logic_vector(15 downto 0);C_1,C_0: in std_logic; Y : out std_logic_vector(15 downto 0));
  end component;
  
  component MUX_8X1_16BIT is
   port (A7,A6,A5,A4,A3,A2,A1,A0 :in std_logic_vector( 15 downto 0);
       S_2,S_1,S_0: in std_logic;Y : out std_logic_vector(15 downto 0));
  end component;
  
  component alu_final is
   port (
			clock: in std_logic;
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	sel,OpCZ: in std_logic_vector(3 downto 0);
	cfi,zfi,cb: in std_logic;					--cb is complement bit
	cz : in std_logic_vector(1 downto 0);
	X: out std_logic_vector(15 downto 0);
	cfo,zfo : out std_logic);
  end component;
  
  component Hazard_detect
    port(
		    IR_STAGE_5: in std_logic_vector(15 downto 0);IR_STAGE_6: in std_logic_vector(15 downto 0);
			 IR_STAGE_4: in std_logic_vector(15 downto 0);S1I3, S2I3, DI4,DI5, DI6: in std_logic_vector(2 downto 0);
			 CZ1,CZ2,CZ3: in std_logic_vector(1 downto 0);
			 carryflag, zeroflag: in std_logic;
			 NumS: in std_logic_vector(1 downto 0);
          HazardBitsA,HazardBitsB,stopbit : out std_logic_vector(1 downto 0);
			 HazardBit :out std_logic
        );
  end component Hazard_detect;
  
  component Writer is
   port(
		    clock: in std_logic; stopbit: in std_logic_vector(1 downto 0);
          PClineSelector, UnconditionalWr, PCWr, IR2Wr, IR3Wr, stage2Bubble, stage3Bubble, stage4Bubble, IR3sel: out std_logic);
  end component Writer;
  
  component LMSMcomponent is
   port (inpinst  : in std_logic_vector(15 downto 0);
			outreg : out std_logic_vector(2 downto 0);
			outinst : out std_logic_vector(15 downto 0)
			);
  end component LMSMcomponent;

  
  component dff_reset is
   port(D,clock,reset:in std_logic;Q:out std_logic);
  end component dff_reset;
  
  component pc_update is
   port (A: in std_logic_vector(15 downto 0); sum: out std_logic_vector(15 downto 0));
  end component;
  
  component register_file is
   port(
    clock, reset,  RF_W : in std_logic;
	 R0_w : in std_logic;
	 Pc_in : in std_logic_vector(15 downto 0);
    A1, A2, A3 : in std_logic_vector(2 downto 0);
    D3 : in std_logic_vector(15 downto 0);
    R0out, D1, D2: out std_logic_vector(15 downto 0));
  end component register_file;

  

end package Gates;


library ieee;
use ieee.std_logic_1164.all;
entity INVERTER is
   port (A: in std_logic; Y: out std_logic);
end entity INVERTER;

architecture Equations of INVERTER is
begin
   Y <= not A;
end Equations;
  

library ieee;
use ieee.std_logic_1164.all;
entity AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity AND_2;

architecture Equations of AND_2 is
begin
   Y <= A and B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity NAND_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity NAND_2;

architecture Equations of NAND_2 is
begin
   Y <= not (A and B);
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity OR_2;

architecture Equations of OR_2 is
begin
   Y <= A or B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity NOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity NOR_2;

architecture Equations of NOR_2 is
begin
   Y <= not (A or B);
end Equations;
  

library ieee;
use ieee.std_logic_1164.all;
entity XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity XOR_2;

architecture Equations of XOR_2 is
begin
   Y <= A xor B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity XNOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity XNOR_2;

architecture Equations of XNOR_2 is
begin
   Y <= not (A xor B);
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is
begin
   S <= (A xor B);
   C <= (A and B);
end Equations;







library ieee;
use ieee.std_logic_1164.all;
entity dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end entity dff_reset;
architecture behav of dff_reset is
begin
dff_reset_proc: process (clock,reset)
begin
if(reset='1')then -- reset implies flip flip output logic low
Q <= '0'; -- write the flip flop output when reset
elsif (clock'event and (clock='1')) then
Q <= D; -- write flip flop output when not reset
end if ;
end process dff_reset_proc;
end behav;
  
