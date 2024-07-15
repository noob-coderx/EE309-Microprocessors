Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Dataflow is 
  port (PCin :in std_logic_vector( 15 downto 0); clock, initialhigh: in std_logic; 
       IR6o: out std_logic_vector(15 downto 0));
end entity Dataflow ;


architecture Struct of Dataflow is

signal trueIR2in, truePCin, trueIR4in, trueIR3in, truePC, IR1, IR2, IR3, IR4, IR5, IR6, IR3in, PC2, PC3, PC4, PC5, 
       instSMLM, ALU1out, ALU3out, goestoPC, SEout, ALU2Ainp, ALU2Binp, RF_D1, RF_D1delay, RF_D2, 
		 RF_D2delay, RF_D3, out4, out5, out6, inout5, inout4, din, dindelay1, dindelay2, dincorrection,
		 ALU2out, ALU3Ainn, DMemout, R0O: std_logic_vector(15 downto 0);
signal opcodforalu: std_logic_vector(7 downto 0);
signal RF_A1,RF_A2,RF_A3, SelALU_A, SelALU_B, DI4, DI5, DI6, SMLMoutAdd, SMLMoutdelay1, LMSMoutdelay2,
       LMSMoutdelay3: std_logic_vector(2 downto 0);
signal NumS, CZforALU2, CZregisterinp, CZregisterop, CZregisteropdelay, CZregisteropdelay2,
       HBA, HBB, HBBdelay, HBAdelay, HBCdelay, stopobit: std_logic_vector(1 downto 0);
signal bitSMLM, SEinp, ComplimentbitALU2, truePCWr, ALU3inpsel, DMemWr, DMemor3Out, PCsel, UnconditionalWr, PCWr, IR2Wr, IR3Wr,
       IR4Wr, RfWr, RFWrdelay, S2B, S3B, S4B, IR3selIMorSLMLM, IR3sel, trueIR2Wr, HB, HBdelay: std_logic;

begin
one:Instruction_Memory port map(M_add => R0O, M_inp => "0000000000000000", M_data => IR1, clock => clock, 
                                Mem_R => '1', Mem_W => '0');
one0:temporary_register port map(Input => R0O, clock => clock, Enable => truePCWr, Output => truePC);

two: Dec2 port map(PCin => R0O, IRin => trueIR2in, Wr => trueIR2Wr, clock => clock, IRout => IR2, 
                    PCout => PC2);
						  
three:Dec3 port map(PCin => PC2, IRin => trueIR3in, SMLMinp => SMLMoutAdd, Wr => IR3Wr, clock => clock, IRout => IR3, 
                    PCout => PC3, A1 => RF_A1, A2 => RF_A2,
						  bit2denotenumberofsources => NumS, SMLMUnit => bitSMLM);
						  
tempSMLMout: reg_3bit port map(Input => SMLMoutAdd, Output => SMLMoutdelay1,  Enable => '1', clock => clock);
tempSMLMout2: reg_3bit port map(Input => SMLMoutdelay1, Output => LMSMoutdelay2, Enable =>'1', clock => clock);
tempSMLMout3: reg_3bit port map(Input => LMSMoutdelay2, Output => LMSMoutdelay3, Enable =>'1', clock => clock);

						  
four: Dec4 port map(PCin => PC3, IRin => trueIR4in, Wr => '1', clock => clock, HazardBit => HBdelay, IRprevopcod => IR5,
                    HazardBitsA => HBAdelay, HazardBitsB => HBBdelay, IRout => IR4, 
						  PCout => PC4, SelALU_A => SelALU_A, SelALU_B => SelALU_B, 
						  IRopcod => opcodforalu, Destin => DI4, CZ => CZforALU2, 
						  SEbit => SEinp, Cb => ComplimentbitALU2, ALU3inp => ALU3inpsel);
						  
five: Dec5 port map(PCin => PC4, IRin => IR4, Wr => '1', clock => clock, Destin => DI5, IRout => IR5, PCout => PC5, 
                    WrMe => DMemWr, Sel => DMemor3Out);
						  
six: Dec6 port map(PCin => PC5, IRin => IR5, IRout => IR6, clock => clock, Wr => '1', LMSM => LMSMoutdelay3, Destin => DI6,
                   Zero_flag => CZregisteropdelay2(0), carry_flag => CZregisteropdelay2(1), Wr_rf => RFWr, A3 => RF_A3);
						 						 
DM: Data_Memory port map(M_add => out4, M_inp => dindelay2, M_data => DMemout, clock => clock,
                         Mem_R => '1', Mem_W => DMemWr);
								 
mulfordin: MUX_1X2_16BIT port map(A => RF_D2, B => RF_D1, Sig_16BIT => bitSMLM, Y => din);
								 
tempD1oD2: temporary_register port map(Input => din, clock => clock, Enable => '1', Output => dindelay1);

isAsourceorisBsource: MUX_2_1 port map(A => HBBdelay(0), B => HBAdelay(0), S => HB, Y => HBCdelay(0));
isAsourceorisBsource2: MUX_2_1 port map(A => HBBdelay(1), B => HBAdelay(1), S => HB, Y => HBCdelay(1));


Storecorrect: MUX_4X1_16BIT port map(D0 => dindelay1, D1 => out4, D2 => out5, D3 => out6,
												 C_0 => HBCdelay(0), C_1 => HBCdelay(1), Y => dincorrection);
												 
tempD1oD22: temporary_register port map(Input => dincorrection, clock => clock, Enable => '1', Output => dindelay2);
						 
bigboi: Hazard_detect port map(IR_STAGE_4 => IR4, IR_STAGE_5 => IR5, IR_STAGE_6 => IR6, S1I3 => RF_A1, S2I3 => RF_A2, 
                               DI4 => DI4, DI5 => DI5, DI6 => DI6, NumS => NumS, CZ1 => CZregisterop,
										 CZ2 => CZregisteropdelay, CZ3 => CZregisteropdelay2, carryflag => CZregisterinp(1), 
										 zeroflag => CZregisterinp(0), HazardBitsA => HBA, HazardBitsB => HBB,
										 stopbit => stopobit, HazardBit => HB);
										 
tempHBB: reg_2bit port map(clock => clock, Input => HBB, Output => HBBdelay, Enable => '1');
tempHBA: reg_2bit port map(clock => clock, Input => HBA, Output => HBAdelay, Enable => '1');
tempHB: dff_reset port map(D => HB, clock => clock, reset => '0', Q => HBdelay);

PenaltyHandler: Writer port map(clock => clock, stopbit => stopobit, PClineSelector => PCsel, 
                                UnconditionalWr => UnconditionalWr, PCWr => PCWr,
                                IR2Wr => IR2Wr, IR3Wr => IR3Wr, stage2Bubble => S2B, 
										  stage3Bubble => S3B, stage4Bubble => S4B, IR3sel => IR3sel);
										  
truePCwritein: truePCWr <= (PCWr and (not bitSMLM)) or UnconditionalWr;
										  
SMLMUnit: LMSMcomponent port map(inpinst => IR3, outreg => SMLMoutAdd, outinst => instSMLM);

trueIR3Selectline:IR3selIMorSLMLM <= IR3Sel or bitSMLM;--Select line for instruction register 3

MuxforIR3:MUX_1X2_16BIT port map(A => instSMLM, B => IR2, Sig_16BIT => IR3selIMorSLMLM, Y => IR3in);--1st out of 2Mux for IR3

MuxforIR3Bubble:MUX_1X2_16BIT port map(A => "1110000000000000", B => IR3in, Sig_16BIT => S3B, Y => trueIR3in); --Bubble or output from Dec2

MuxforIR2Bubble:MUX_1X2_16BIT port map(A => "1110000000000000", B => IR1, Sig_16BIT => S2B, Y => trueIR2in); --Bubble or output from IM

MuxforIR4Bubble:MUX_1X2_16BIT port map(A => "1110000000000000", B => IR3, Sig_16BIT => S4B, Y => trueIR4in); --Bubble or output from Dec2

ALU1: pc_update port map(A => truePC, sum => ALU1out);

PClinee: MUX_1X2_16BIT port map(A => ALU3out, B => ALU1out, sig_16BIT => PCsel, Y => goestoPC);--selects output from alu3 or alu1

PClineee:MUX_1X2_16BIT port map(A => PCin, B => goestoPC, sig_16BIT => initialhigh, Y => truePCin);

trueIR2write: trueIR2Wr <= (IR2Wr and (not bitSMLM)) or UnconditionalWr;--when 2 disable wr in IR2/

RF:register_file port map(clock => clock, reset => '0', RF_W => RFWr, R0_W => truePCWr, PC_in => truePCin, A1 => RF_A1, A2 => RF_A2, A3 => RF_A3, 
                          D1 => RF_D1, D2 => RF_D2, R0out => R0O, D3 => out5);
temd1: temporary_register port map(Input => RF_D1, clock => clock, Enable => '1', Output => RF_D1delay);
temd2: temporary_register port map(Input => RF_D2, clock => clock, Enable => '1', Output => RF_D2delay);

ALU2Ainn: MUX_8X1_16BIT port map(A0 => RF_D1delay, A1 => out4, A2 => out5, A3 => PC4, A4 => SEout, A5 => SEout, 
                                 A6 => SEout, A7 => out6, S_0 => SelALU_A(0), S_1 => SelALU_A(1), 
											S_2 => SelALU_A(2), Y => ALU2Ainp);

ALU2Binn: MUX_8X1_16BIT port map(A0 => RF_D2delay, A1 => out4, A2 => out5, A3 => "0000000000000001", A4 => SEout, 
                                 A5 => SEout, A6 => "0000000000000000", A7 => out6, S_0 => SelALU_B(0), S_1 => SelALU_B(1), 
											S_2 => SelALU_B(2), Y => ALU2Binp);

CZRegisttt: reg_2bit port map(clock => clock, Input => CZregisterinp, Output => CZregisterop, Enable => '1');

CZRegisttt2: reg_2bit port map(clock => clock, Input => CZregisterop, Output => CZregisteropdelay, Enable => '1');

CZRegisttt3: reg_2bit port map(clock => clock, Input => CZregisteropdelay, Output => CZregisteropdelay2, Enable => '1');

ALU2: alu_final port map(clock => clock, A => ALU2Ainp, B => ALU2Binp, sel => opcodforalu(7 downto 4),
                         OpCZ => opcodforalu(3 downto 0), cfi => CZregisterop(1), zfi => CZregisterop(0),
								 cb => ComplimentbitALU2, CZ => CZforALU2, X => ALU2out, 
								 cfo => CZregisterinp(1), zfo => CZregisterinp(0));
								 
out3now4out: temporary_register port map(Input => ALU2out, clock => clock, Enable => '1', Output => out4);
mulforout5: MUX_1X2_16BIT port map(A => DMemout, B => out4, sig_16BIT => DMemor3Out, Y => inout5);
out4now5out: temporary_register port map(Input => inout5, clock => clock, Enable => '1', Output => out5);

out5now6out: temporary_register port map(Input => out5, clock => clock, Enable => '1', Output => out6);

selALU3Ainn: MUX_1X2_16BIT port map(A => RF_D2delay, B => PC4, sig_16BIT => ALU3inpsel, Y => ALU3Ainn);

SE: se10 port map(InputIR => IR4, SEbit => SEinp, Imm => SEout);

ALU33: ALU3 port map(A => ALU3Ainn, B => SEout, sum => ALU3out);

dumbledore: IR6o <= "0110011001100110";

								 
end Struct;