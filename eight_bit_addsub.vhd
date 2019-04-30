library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_addsub is
  port(x        : in std_logic_vector(7 downto 0);
       y        : in std_logic_vector(7 downto 0);
       sub      : in std_logic;
       sum      : out std_logic_vector(7 downto 0);
       overflow : out std_logic;
       underflow: out std_logic
       );
end entity eight_bit_addsub;

architecture dataflow of eight_bit_addsub is

  component full_adder

    port(x      : in std_logic;
         y      : in std_logic;
         c_in   : in std_logic;
         sum    : out std_logic;
         c_out  : out std_logic
         );

  end component full_adder;

  signal new_y0, new_y1, new_y2, new_y3, new_y4, new_y5, new_y6, new_y7  : std_logic;
  signal c_in1, c_in2, c_in3, c_in4, c_in5, c_in6, c_in7, c_in8   : std_logic;
  signal MSB    : std_logic;

begin

  new_y0 <= y(0) xor sub;
  new_y1 <= y(1) xor sub;
  new_y2 <= y(2) xor sub;
  new_y3 <= y(3) xor sub;
  new_y4 <= y(4) xor sub;
  new_y5 <= y(5) xor sub;
  new_y6 <= y(6) xor sub;
  new_y7 <= y(7) xor sub;

  fadd0: full_adder port map(x => x(0),
                             y => new_y0,
                             c_in => sub,
                             sum => sum(0),
                             c_out => c_in1
                             );

  
  fadd1: full_adder port map(x => x(1),
                             y => new_y1,
                             c_in => c_in1,
                             sum => sum(1),
                             c_out => c_in2
                             );

  
  fadd2: full_adder port map(x => x(2),
                             y => new_y2,
                             c_in => c_in2,
                             sum => sum(2),
                             c_out => c_in3
                             );

  
  fadd3: full_adder port map(x => x(3),
                             y => new_y3,
                             c_in => c_in3,
                             sum => sum(3),
                             c_out => c_in4
                             );

  
  fadd4: full_adder port map(x => x(4),
                             y => new_y4,
                             c_in => c_in4,
                             sum => sum(4),
                             c_out => c_in5
                             );


  fadd5: full_adder port map(x => x(5),
                             y => new_y5,
                             c_in => c_in5,
                             sum => sum(5),
                             c_out => c_in6
                             );
  
  fadd6: full_adder port map(x => x(6),
                             y => new_y6,
                             c_in => c_in6,
                             sum => sum(6),
                             c_out => c_in7
                             );
  
  fadd7: full_adder port map(x => x(7),
                             y => new_y7,
                             c_in => c_in7,
                             sum => MSB,
                             c_out => c_in8
                             );

  underflow <= (not MSB and c_in8 and x(7) and new_y7);
  overflow <= c_in7 xor c_in8;
  sum(7) <= MSB;

end dataflow;

                
  
