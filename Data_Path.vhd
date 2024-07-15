library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dataflow is
    port (
			Controller_Outputs: in std_logic;
			CLK : in std_logic;
            IR_STAGE_2 : out std_logic_vector(15 downto 0);
            IR_STAGE_3 : out std_logic_vector(15 downto 0);
            IR_STAGE_4 : out std_logic_vector(15 downto 0);
            IR_STAGE_5 : out std_logic_vector(15 downto 0);
    );
end entity Dataflow;

architecture Dataflow_final of Dataflow is
    ---component - Idhar initialise kardo ya for gates mein daal do sab kuch



    --NOTE - c1, c2, c3 and so on are control signals that will be given by controller


    signal Vice_PC : std_logic_vector(7 downto 0);
    begin
        PC : temporary_register port map( temp_write => Vice_PC , temp_read => PC,  temp_w => C1, clock => CLK, reset => reset );
        
        PLUS_1 : pc_update port map(ALU_A => PC, ALU_C => MUX_of_BRANCH);  -- check if they are 16 bits once

        Instruction_memory: Memory port map (Mem_R => R_IN_EN, Mem_W => "0" , M_add => PC, CLK => CLK, M_data => IR_STAGE_2, M_inp => "0000000000000000"); -- random filler in the M_inp

        --STAGE_2_PC : temporary_register port map(temp_write => PC, temp_read => DECODER_2, temp_w => C2, clock => CLK, reset => reset);
        --probably put for complettion of what code if present not really that important

        STAGE_2_IR : temporary_register port map(temp_write => IR_STAGE_2, temp_read => DECODER_2, temp_w => C3, clock => CLK, reset => reset);

        DECODER_2 : decoder port map(inst => IR_STAGE_2, Opcode => Opcode, a1 => A1, a2 => A2, regc => , cb => , cz => , imm6 => , imm9 => );

        RF : register_file port map(clock => clock, reset => reset, PC_w => , RF_W =>  A1 => A1, A2 => A2, A3 => X0, D3 => 4_out, PC_write => , D1 => , D2 => , PC_read => );

        -- X0 will be calculated with the help of state_5_IR, which will tell us if we need to write in the register file in the first place
        -- 4 out is given in the diagram

        

        





    end architecture Dataflow_final;











-