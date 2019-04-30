library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX_4to1 is
	port(
    		R0, R1, R2, R3: in STD_LOGIC_VECTOR(7 downto 0);
  		S: in STD_LOGIC_VECTOR(1 downto 0);
	     	K: out STD_LOGIC_VECTOR(7 downto 0)
    	);
end MUX_4to1;

architecture behavioral of MUX_4to1 is
begin
	process(R0,R1,R2,R3,S) is
  	begin
    	if (S = "00") then
      		K <= R0;
    	elsif (S = "01") then
      		K <= R1;
    	elsif (S = "10") then
      		K <= R2;
    	elsif(S = "11") then
      		K <= R3;
    	end if;
  	end process;
end behavioral;   
