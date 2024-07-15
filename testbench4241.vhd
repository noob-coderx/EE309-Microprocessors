library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

library work;
use ieee.std_logic_unsigned.ALL;

entity testbench4241 is
end entity;
architecture struc of testbench4241 is

component Dataflow is
  port (PCin :in std_logic_vector( 15 downto 0); clock, initialHigh: in std_logic;
       IR6o: out std_logic_vector(15 downto 0));
end component Dataflow;

signal clk50: std_logic :='1';
signal Wrsignal: std_logic :='1';
signal iri: std_logic_vector(15 downto 0):="0001100111000000";
signal pci: std_logic_vector(15 downto 0):="0000000000000000";
signal clkout: std_logic_vector(15 downto 0);
signal clkoutbitt: std_logic;
signal clkout2: std_logic_vector(15 downto 0);
signal qq: std_logic_vector(1 downto 0);
signal addr1: std_logic_vector(2 downto 0);
signal addr2: std_logic_vector(2 downto 0);
constant clkper:time:= 20 ns;
begin
p: Dataflow port map(PCin => pci, clock => clk50, initialHigh => Wrsignal, IR6o => clkout);
   clk50 <= not clk50 after clkper/2;
	Wrsignal <= '0' after clkper;
end struc;