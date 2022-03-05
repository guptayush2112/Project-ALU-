--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:16:44 03/05/2022
-- Design Name:   
-- Module Name:   D:/Xilinx 14.7 Projects/myproject/alustruc_tb.vhd
-- Project Name:  myproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alustruc
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alustruc_tb IS
END alustruc_tb;
 
ARCHITECTURE behavior OF alustruc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU8b
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         y : IN  std_logic_vector(7 downto 0);
         cb : IN  std_logic_vector(5 downto 0);
         zr : OUT  std_logic;
         ng : OUT  std_logic;
         O : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');
   signal y : std_logic_vector(7 downto 0) := (others => '0');
   signal cb : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal zr : std_logic;
   signal ng : std_logic;
   signal O : std_logic_vector(7 downto 0);
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU8b PORT MAP (
          x => x,
          y => y,
          cb => cb,
          zr => zr,
          ng => ng,
          O => O);

   -- Stimulus process
   stim_proc: process
   begin
        x <= "00010010";  --18 in decimal
        y <= "00001010";  --10 in decimal
        cb <= "101010";  wait for 50ns;  -- 0
        cb <= "111111";  wait for 50ns;  -- 1
        cb <= "111010";  wait for 50ns;  -- -1
        cb <= "001100";  wait for 50ns;  -- x
        cb <= "110000";  wait for 50ns;  -- y
        cb <= "001101";  wait for 50ns;  -- !x
        cb <= "110001";  wait for 50ns;  -- !y
        cb <= "001111";  wait for 50ns;  -- -x
        cb <= "110011";  wait for 50ns;  -- -y
        cb <= "011111";  wait for 50ns;  -- x+1
        cb <= "110111";  wait for 50ns;  -- y+1
        cb <= "001110";  wait for 50ns;  -- x-1
        cb <= "110010";  wait for 50ns;  -- y-1
        cb <= "000010";  wait for 50ns;  -- x+y
        cb <= "010011";  wait for 50ns;  -- x-y
        cb <= "000111";  wait for 50ns;  -- y-x
		  cb <= "000000";  wait for 50ns;  -- x&y [bitwise and]
		  cb <= "010101";  wait for 50ns;  -- x|y [bitwise or]
      wait;
   end process;
END;
