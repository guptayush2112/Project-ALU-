--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:02:19 05/01/2021
-- Design Name:   
-- Module Name:   C:/Xilinx/14.7/myproject/alu_tst.vhd
-- Project Name:  myproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY alu_tst IS
END alu_tst;
 
ARCHITECTURE behavior OF alu_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         x : IN  std_logic_vector(0 to 7);
         y : IN  std_logic_vector(0 to 7);
         cb : IN  std_logic_vector(0 to 5);
         zr : OUT  std_logic;
         ng : OUT  std_logic;
         O : OUT  std_logic_vector(0 to 8)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(0 to 7) := (others => '0');
   signal y : std_logic_vector(0 to 7) := (others => '0');
   signal cb : std_logic_vector(0 to 5) := (others => '0');

 	--Outputs
   signal zr : std_logic;
   signal ng : std_logic;
   signal O : std_logic_vector(0 to 8);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          x => x,
          y => y,
          cb => cb,
          zr => zr,
          ng => ng,
          O => O
        );
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