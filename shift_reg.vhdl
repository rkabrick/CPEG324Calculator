library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
port(		I:	in std_logic_vector (3 downto 0); -- for loading
		I_SHIFT_IN: in std_logic; -- shifted in bit for both left and right
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) -- output the current register content
);
end shift_reg;

architecture behav of shift_reg is
signal outvec : std_logic_vector(3 downto 0); --for intermediate stuff
begin
	reg_process: process (clock, enable)
	begin
	if enable = '1' then
		if (clock'event and clock = '1') then
			if sel = "00" then
				-- do nothing?
			elsif sel = "01" then  -- shift left
				outvec(3) <= outvec(2);
				outvec(2) <= outvec(1);
				outvec(1) <= outvec(0);
				outvec(0) <= I_SHIFT_IN;
			elsif sel = "10" then  -- shift right
				outvec(0) <= outvec(1);
				outvec(1) <= outvec(2);
				outvec(2) <= outvec(3);
				outvec(3) <= I_SHIFT_IN;
			elsif sel = "11" then
				outvec <= I; -- load
			end if;
		end if;
	elsif (enable = '0') then
		outvec <= "0000";
	end if;
	end process reg_process;
	O <= outvec;
end behav;

