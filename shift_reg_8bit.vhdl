library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_8bit is
port(		I:	in std_logic_vector (7 downto 0); -- for loading
		I_SHIFT_IN: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(7 downto 0) -- output the current register content
);
end entity shift_reg_8bit;

architecture behav of shift_reg_8bit is
signal bottomshift : std_logic;
signal topshift : std_logic;
component shift_reg
	port(	I:	in std_logic_vector (3 downto 0); -- for loading
		I_SHIFT_IN: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) -- output the current register content
	);
end component shift_reg;
signal content : std_logic_vector(7 downto 0);
begin
	
	bottom4 : shift_reg port map (I(3 downto 0), bottomshift, sel, clock, enable, content(3 downto 0));

	top4 : shift_reg port map (I(7 downto 4), topshift, sel, clock, enable, content(7 downto 4));

	reg_process: process (clock) is
	begin
		if sel = "01" then --shift left
			bottomshift <= I_SHIFT_IN;
			topshift <= content(3);
		elsif sel = "10" then --shift right
			bottomshift <= content(4);
			topshift <= I_SHIFT_IN;
		end if;
	end process reg_process;
	O <= content;
end architecture behav;

