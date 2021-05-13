----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:53 05/01/2021 
-- Design Name: 
-- Module Name:    alustrucs - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alustruc is
port (x,y : in std_logic_vector(7 downto 0);
	  cb : in std_logic_vector(5 downto 0);
	  zr : out std_logic;
	  ng : out std_logic;
	  O : out std_logic_vector(7 downto 0));
end alustruc;

architecture Structural of alustruc is

component not8 is
port (i : in std_logic_vector(7 downto 0);
	   o : out std_logic_vector(7 downto 0));
end component;

component and8 is
port (a,b : in std_logic_vector(7 downto 0);
	   c : out std_logic_vector(7 downto 0));
end component; 

component mux8 is
port (a,b : in std_logic_vector(7 downto 0);
	   sel : in std_logic;
		o : out std_logic_vector(7 downto 0));
end component;

component add8 is
port (a,b : in std_logic_vector(7 downto 0);
	   c : out std_logic_vector(7 downto 0));
end component; 

component or8way is
port (i0,i1,i2,i3,i4,i5,i6,i7 : in std_logic;
	   o : out std_logic);
end component;

component not1 is
port (ip : in std_logic;
		op : out std_logic);
end component; 

component and1 is
port(a,b : in std_logic;
	  o : out std_logic);
end component; 

signal op2compliment : std_logic_vector(7 downto 0);

--Signals for Computing for x
signal xb,zx1,zxm,xc,Xf:std_logic_vector(7 downto 0);

---Signals for Computing for y
signal yb,zy1,zym,yc,Yf : std_logic_vector(7 downto 0);

--Signals for Computing for op O,zr,ng
signal nxandy,nxaddy,fm,fmb,nom,O1,O2 : std_logic_vector(7 downto 0);

signal one : std_logic_vector(7 downto 0):="11111111";
signal zrb,ngo : std_logic:='0';

signal one2 : std_logic_vector(7 downto 0):="00000001";
begin

notx : not8 port map(x,xb);
andxb : and8 port map(x,xb,zx1);

-- For x=0 wrt zx
muxzx : mux8 port map(x,zx1,cb(5),zxm);

-- For x compliment wrt nx
notxc : not8 port map(zxm,xc);
muxxc : mux8 port map(zxm,xc,cb(4),Xf);

--Similarly for y
noty : not8 port map(y,yb);
andyb : and8 port map(y,yb,zy1);

--For y wrt zy
muxzy : mux8 port map(y,zy1,cb(3),zym);

-- For y compliment wrt ny
notmy : not8 port map(zym,yc);
muxny : mux8 port map(zym,yc,cb(2),Yf);

-- Performing Func wrt f
andnxy : and8 port map(Xf,Yf,nxandy);
addnxy : add8 port map(Xf,Yf,nxaddy);
muxf : mux8 port map(nxandy,nxaddy,cb(1),fm);

--Output wrt no
notfm: not8 port map(fm,fmb);
muxno : mux8 port map(fm,fmb,cb(0),nom);
outg : and8 port map(nom,one,O);

--zr wrt output O
splitzr : or8way port map(nom(0),nom(1),nom(2),nom(3),nom(4),nom(5),nom(6),nom(7),zrb);
zrout : not1 port map(zrb,zr);

ngout: and1 port map(nom(7),one(0),ngo);
ngout1 : and1 port map(one(0),ngo,ng);
 
--Output O wrt ng
notO : not8 port map(nom,O1);
addO : add8 port map(O1,one2,O2);
mout : mux8 port map(nom,O2,ngo,op2compliment);

end Structural;