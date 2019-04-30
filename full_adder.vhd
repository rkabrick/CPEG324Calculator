library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_adder is
  port( x: in STD_LOGIC;
        y: in STD_LOGIC;
        c_in: in STD_LOGIC;
        sum: out STD_LOGIC;
        c_out: out STD_LOGIC
        );
end entity full_adder;

architecture bhv of full_adder is
  signal a1, a2, a3: std_logic;
begin
  a1 <= x xor y;
  a2 <= x and y;
  a3 <= a1 and c_in;
  c_out <= a2 or a3;
  sum <= a1 xor c_in;
end bhv;


  
        
