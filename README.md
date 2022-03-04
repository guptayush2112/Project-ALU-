# RTL Design and Analysis of an 8-bit ALU using Xilinx ISE Design Suite

This repository showcases the RTL [Register Transfer Level] coding of an 8-bit Arithmetic Logic Unit as well as its Synthesis and Analysis done using the Xilinx ISE Design Suite 14.7 and ISim.

# Table of Contents
 * [Introduction](#Introduction)
 * [Approach](#Approach)
 * [Design Methodology and Explanation](#Design-Methodology-and-Explanation)
 * [Tools Used](#Tools-Used)
 * [RTL Coding and Simulation](#RTL-Coding-and-Simulation)
 * [Synthesis and Analysis](#Synthesis-and-Analysis)
 * [Conclusion](#Conclusion)
 * [Author](#Author)
 * [Acknowledgements](#Acknowledgements)
 * [References](#References)


# Introduction

We all use devices capable of performing millions and billions of computations in the blink of an eye all throughout our daily lives, don't we? But, have we wondered how is this computation taking place? What helps them in performing these tasks in such a short amount of time? This is where the CPU [Central Processing Unit] comes into the picture. The heart of any computing system is its CPU and the heart of any CPU is the ALU!! 
The Arithmetic Logic Unit which lies at the centre of any processing unit is the epicentre of all the operations the CPU performs to get our tasks done. It is the fundamental building block responsible for all sorts of arithmetic, logical or relational operations. 

Modern CPUs contain very powerful and complex which are constantly working and performing basic arithmetic and logic operations involving addition, subtraction, multiplication, and division; comparisons of values i.e. relatinoal operations and also the logical operations such as NOT, AND, and OR In addition to ALUs, modern CPUs contain a control unit (CU) as well whose job is to let the ALU know what operation to perform.
All information is stored and manipulated in the form of binary, of course, and transistor switches are used to manipulate binary numbers since there are only two possible states of a switch: open or closed. An open transistor, through which there is no current, represents a 0. A closed transistor, through which there is a current, represents a 1 and all the required operations are then performed by these multiple transistors connected with each other. 


# Approach

As mentioned earlier, all modern CPUs have a control unit[CU] apart from an ALU. It is the CU which tells the ALU what operation or function it has to perform on the data and the CU does it using a certain set of bits called control bits, and the ALU stores the result of this operation in an output register. 
Now, before we can actually write the RTL code for our ALU, it is important to first know whether the logic with which our ALU is being designed will actually work or not, and so, in order to do that, the digital circuit using basic combinational blocks was designed using Logisim software to check whether the desired output is generated by the ALU or not. Then after doing this, we come to the Xilinx Design Suite wherein this circuit will serve as reference when for writing our VHDL code using structural modelling style. This will then be followed by the simulation of the testbench of our design and finally the Synthesis and Analysis of the entire design.

# Design Methodology and Explanation

## ALU Design
<p align="center">
<img src="Logisim/Img/ALUcirc.jpg"></br>
  Fig 1: Reference Logic Diagram
</p>
<p>
Figure above represents the logic diagram used as reference when designing our RTL code.
Here, we can see that X and Y are the two 8-bit input registers going into the ALU while OP is our output register. Along with that, the ALU also has the very important six control bits viz. zx, nx, zy, ny, f, no. These 6 control bits are the ones which decide which operation will the ALU perform. The ALU also has two single bit staus flags labelled above as zr and ng.

The ALU can perform 18 different logical, arithmetic and relational operations depending upon what the values of the control bits are. The truth table for this along with the block diagram of the ALU are given below.

<p align="center">
<img src="Imgs/Blk_TT_ALU.jpg"></br>
  Fig 2: (a) Block Diagram (b) Operations Truth Table 
</p>

The two status flags, Zr (zero) and Ng (negative) and one out (output) will give us the desired output based on the following criterion:
•	Zr – indicates that the operation performed on inputs resulted in zero (for comparison if both inputs are equal).

•	Ng– indicates the operation performed on the inputs resulted in negative output.

•	OUT – result obtained after some consecutive operations performed on the input

## Working Principle

Multiplexor is one of the most powerful gates in logic design as it provides the function of decision making at hardware level. The ALU accepts two 8 bit inputs and a series of function is performed as listed below:
1. if (zx == 1) set x = 0 (8-bit constant)
2.  if (nx == 1) set x =! x (bitwise not)
3. if (zy == 1) set y = 0 (8-bit constant)	
4. if (ny == 1) set y =! y (bitwise not)
5. if (f == 1) set out = x + y (integer 2's complement addition)
6. if (f == 0) set out = x & y (bitwise and)
7. if (no == 1) set out =! out (bitwise not)
8. if (out == 0) set zr = 1
9. if (out < 0) set ng = 1  

Using the above series of simple logical operations, fundamental arithmetic operations can be performed.

In the above sequence of steps there are 6 control bits if any of the control bit is set to 1 it will perform a specific logical operation on the input as shown within the brackets, meaning of each control bit is listed below.
    1. zx, zero the x input?
    2. nx, negate the x input?
    3. zy, zero the y input?
    4. ny, negate the y input?
    5. f, compute out = x + y (if 1) or x & y (if 0)
    6. no, negate the out output? 

The basic design is that the output for each control bit a specific logical operation is performed first and then those outputs are passed through the multiplexor, the output which propagates further depends upon the selection bit if the multiplexor which is actually one of the six control bits. The user has to enter one of the 18 different combinations of the control bits and one of 18 different operations x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y, x+1, y+1, x-1, y-1, x&y, x|y on two 8-bit inputs will be performed.

In order to check if the output is zero or not the output is split using a 8 bit splitter and an OR operation is performed on the output bits if any one of the 8 bits is 1 then the output is non- zero else the output is zero ,if all bits are zero then the OR operation on those bits will result in 0 therefore the indicator will turn to 0.
   
In order to check if the output is negative or not the most significant bit is used if it is one then the output is negative else it is positive (as followed in the 2’s complement system).

# Tools Used

<b>• Xilinx ISE Design Suite 14.7:</b></br>
ISE® Design Suite is a proven and mature development environment for All Programmable devices. It is an impressive package that has got tools for boosting the designer productivity plus additionally, it supplies the flexible configurations of this Design Suite Editions.  
To know more, kindly refer to: <a href='https://www.xilinx.com/products/design-tools/ise-design-suite.html'>Xilinx ISE Design Suite</a></br>

<b>• ISim Simulator:</b></br>
ISim provides a complete, full-featured HDL simulator integrated within ISE. HDL simulation now can be an even more fundamental step within your design flow with the tight integration of the ISim within your design environment.
To know more, kindly refer to: <a href='https://www.xilinx.com/products/design-tools/isim.html'>Xilinx ISim</a></br>

<b>• Logisim:</b></br>
Logisim is an educational tool for designing and simulating digital logic circuits.

# RTL Coding and Simulation

## VHDL Coding:

The VHDL codes of the 8-bit ALU were designed using behavioral as well as structural modelling. The truth table shown in Fig 2 above was used as reference for the behavioral model and the logic diagram shown in Fig 1 was used as reference for structural model.

For Behavioral Design, kindly refer to: <a href='https://github.com/guptayush2112/Project-ALU-/tree/main/VHDL%20Source%20Codes/Behavioral%20Modelling'>Behavioral Model</a></br>

For Structural Design, kindly refer to: <a href='https://github.com/guptayush2112/Project-ALU-/tree/main/VHDL%20Source%20Codes/Structural%20Modelling'>Structural Model</a></br>

## Testbench Simulation:

After completing the coding and writing the testbench as well, the ALU testbench for Structural model was now simulated using the Xilinx ISim as shown in the two images below.

For the Testbench Design, X and Y were taken initially as 0000100010 and 00001010 
</p>

<p align="center">
  <img src="Testbench Simulation/tb350.jpg"></br>
  Fig. 3 (a): Testbench of 8-bit ALU [Till 350ns]
</p>

<p align="center">
  <img src="Testbench Simulation/tb900.jpg"></br>
  Fig. 3 (b): Testbench of 8-bit ALU [Contd till 900ns]
</p>

Note: Since the port declarations inside the ALU entity of both Structural and Behavioral model are same and the testbench stimuli given to both is same meaning that the testbench of behavioral modelling style is similar to that of the structural modelling, hence the testbench simulation of only one, that is, the structural model is shown here.

# Synthesis and Analysis

Initially, after the function implementation of the design was verified through the testbench simulation, the design was then synthesized to get the RTL and Technology view of the same.

## Top-Level Block:

<p align="center">
  <img src="Synthesis/Imgs/Top_Lvl_Blk.jpg"></br>
</p>

## Detailed RTL View:

<p align="center">
  <img src="Synthesis/Imgs/Detailed_RTLview.jpg"></br>
</p>

## Detailed Technology View:  
<p align="center">
  <img src="Synthesis/Imgs/Detailed_TechView.jpg"></br>
</p>

# Synthesis Report:

## Synthesis Summary:

	=========================================================================
	*                      Synthesis Options Summary                        *
	=========================================================================
	---- Source Parameters
	Input File Name                    : "ALU8b.prj"
	Ignore Synthesis Constraint File   : NO

	---- Target Parameters
	Output File Name                   : "ALU8b"
	Output Format                      : NGC
	Target Device                      : xc7a100t-3-csg324

	---- Source Options
	Top Module Name                    : ALU8b
	Automatic FSM Extraction           : YES
	FSM Encoding Algorithm             : Auto
	Safe Implementation                : Yes
	FSM Style                          : LUT
	RAM Extraction                     : Yes
	RAM Style                          : Auto
	ROM Extraction                     : Yes
	Shift Register Extraction          : YES
	ROM Style                          : Auto
	Resource Sharing                   : YES
	Asynchronous To Synchronous        : NO
	Shift Register Minimum Size        : 2
	Use DSP Block                      : Auto
	Automatic Register Balancing       : No

	---- Target Options
	LUT Combining                      : Auto
	Reduce Control Sets                : Auto
	Add IO Buffers                     : YES
	Global Maximum Fanout              : 100000
	Add Generic Clock Buffer(BUFG)     : 32
	Register Duplication               : YES
	Optimize Instantiated Primitives   : NO
	Use Clock Enable                   : Auto
	Use Synchronous Set                : Auto
	Use Synchronous Reset              : Auto
	Pack IO Registers into IOBs        : Auto
	Equivalent register Removal        : YES

	---- General Options
	Optimization Goal                  : Speed
	Optimization Effort                : 1
	Power Reduction                    : NO
	Keep Hierarchy                     : No
	Netlist Hierarchy                  : As_Optimized
	RTL Output                         : Yes
	Global Optimization                : AllClockNets
	Read Cores                         : YES
	Write Timing Constraints           : NO
	Cross Clock Analysis               : NO
	Hierarchy Separator                : /
	Bus Delimiter                      : <>
	Case Specifier                     : Maintain
	Slice Utilization Ratio            : 100
	BRAM Utilization Ratio             : 100
	DSP48 Utilization Ratio            : 100
	Auto BRAM Packing                  : NO
	Slice Utilization Ratio Delta      : 5

## Design Summary:

	=========================================================================
	*                            Design Summary                             *
	=========================================================================

	Top Level Output File Name         : ALU8b.ngc

	Primitive and Black Box Usage:
	------------------------------
	# BELS                             : 50
	#      GND                         : 1
	#      LUT3                        : 16
	#      LUT5                        : 8
	#      LUT6                        : 10
	#      MUXCY                       : 7
	#      XORCY                       : 8
	# IO Buffers                       : 32
	#      IBUF                        : 22
	#      OBUF                        : 10

	Device utilization summary:
	---------------------------

	Selected Device : 7a100tcsg324-3 

	Slice Logic Utilization: 
	 Number of Slice LUTs:                   34  out of  63400     0%  
	    Number used as Logic:                34  out of  63400     0%  

	Slice Logic Distribution: 
	 Number of LUT Flip Flop pairs used:     34
	   Number with an unused Flip Flop:      34  out of     34   100%  
	   Number with an unused LUT:             0  out of     34     0%  
	   Number of fully used LUT-FF pairs:     0  out of     34     0%  
	   Number of unique control sets:         0

	IO Utilization: 
	 Number of IOs:                          32
	 Number of bonded IOBs:                  32  out of    210    15%  

	Specific Feature Utilization:
	
	---------------------------
	Partition Resource Summary:
	---------------------------
	  No Partitions were found in this design.
	---------------------------
	=========================================================================
	
	
# Conclusion:
Thus, the design and analysis of the 8-bit Arithmetic Logic Unit was successfully done and it was observed that the ALU was performing all the 18 different operations as required.</br>

# Author:
• Ayush Gupta, B.Tech(ECE), SRM Institute of Science and Technology, Kattankulattur, Chennai-603203.

# References:
[1] Arithmetic Logic Units/Function Generators Datasheet, Texas Instruments, Dallas, Texas, 1988. [Online]. Available: http://www-s.ti.com/sc/ds/sn54s181.pdf</br>
[2] Build a Modern Computer from First Principles: From Nand to Tetris (Project-Centered Course) by Hebrew University of Jerusalem
