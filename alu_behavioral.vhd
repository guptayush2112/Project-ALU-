----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:31 04/29/2021 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
port (x,y : in std_logic_vector(0 to 7);
	  cb : in std_logic_vector(0 to 5);
	  zr : out std_logic;
	  ng : out std_logic;
	  O : out std_logic_vector(0 to 8));
end alu;

architecture Behavioral of alu is

-- 8 bit one to send to 8 bit adder to compute aforementioned operations
signal one : std_logic_vector(0 to 8):= "000000001";

begin

process(x,y,cb,one)
	begin
	if (cb = "101010") then          --0
   O <= "000000000";
	zr <= '1';
	ng <= '0';
	elsif (cb="111111") then         -- 1
	O <= one;
	zr <= '0';
	ng <= '0';
	elsif cb = "111010" then         -- -1
   O <= one;
	zr <= '0';
	ng <= '1';
	elsif (cb="001100") then         -- x
	O <= '0' & x;
	zr <= '0';
	ng <= '0';
	elsif (cb="110000") then         -- y
	O <= '0' & y;
	zr <= '0';
	ng <= '0';
	elsif (cb="001101") then         -- !x
	O <= '0' & not x;
	zr <= '0';
	ng <= '0';
	elsif (cb="110001") then         -- !y
	O <= '0' & not y;
	zr <= '0';
	ng <= '0';
	elsif (cb="001111") then         -- -x
	O <= '0' & x;
	zr <= '0';
	ng <= '1';
	elsif (cb="110011") then         -- -y
	O <= '0' & y;
	zr <= '0';
	ng <= '1';
	elsif (cb="011111") then         -- x+1
	O <= ('0' & x) + one;
	zr <= '0';
	ng <= '0';
	elsif (cb="110111") then         -- y+1
	O <= ('0' & y) + one;
   zr <= '0';
	ng <= '0';
	elsif (cb="001110") then         -- x-1
	O <= ('0' & x) - one;
	zr <= '0';
	ng <= '0';
	elsif (cb="110010") then         -- y-1
	O <= ('0' & y) - one;
	zr <= '0';
	ng <= '0';
	elsif (cb="000010") then         -- x+y
	O <= ('0' & x) + ('0' & y);
	zr <= '0';
	ng <= '0';
	elsif (cb="010011") then         -- x-y
		if(x>=y) then
		O <= ('0' & x) - ('0' & y);
		zr <= '0';
	   ng <= '0';
		elsif(x<y) then 
		O <= ('0' & y) - ('0' & x);
		zr <= '0';
		ng <= '1';
		elsif(x=y) then
		O <= ('0' & x) - ('0' & y);
		zr <= '1';
		ng <= '0';
		end if;
	elsif (cb="000111") then         -- y-x
		if(y>x) then
		O <= ('0' & y) - ('0' & x);
		zr <= '0';
	   ng <= '0';
		elsif(y<x) then
		O <= ('0' & x) - ('0' & y);
		zr <= '0';
		ng <= '1';
		elsif(y=x) then
		O <= ('0' & x) - ('0' & y);
		zr <= '1';
		ng <= '0';
      end if;
	elsif (cb="000000") then         -- x&y
		O <= ('0' & x) and ('0' & y);
		zr <= '0';
		ng <= '0';
	elsif (cb="010101") then         -- x|y
		O <= ('0' & x) or ('0' & y);
		zr <= '0';
		ng <= '0';
	end if;
end process;
	
end;
