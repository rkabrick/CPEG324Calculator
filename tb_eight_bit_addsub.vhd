library ieee;
use ieee.std_logic_1164.all;

entity tb_eight_bit_addsub is
end tb_eight_bit_addsub;

architecture dataflow of tb_eight_bit_addsub is
  component eight_bit_addsub
    port(x : in std_logic_vector(7 downto 0);
         y : in std_logic_vector(7 downto 0);
         sub : in std_logic;
         sum : out std_logic_vector(7 downto 0);
         overflow: out std_logic;
         underflow: out std_logic);
  end component eight_bit_addsub;

  signal x_tb, y_tb, sum_tb: std_logic_vector(7 downto 0);
  signal sub_tb, overflow_tb, underflow_tb: std_logic;

begin
  uut : eight_bit_addsub
    port map(x => x_tb,
             y => y_tb,
             sum => sum_tb,
             sub => sub_tb,
             overflow => overflow_tb,
             underflow => underflow_tb);
  
  process
    type pattern_type is record
      x_tb :         std_logic_vector(7 downto 0);
      y_tb :         std_logic_vector(7 downto 0);
      sub_tb :       std_logic;
      sum_tb :       std_logic_vector(7 downto 0);
      overflow_tb:   std_logic;
      underflow_tb:  std_logic;
    end record;
         
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      ------------------------- ADD -----------------------
      (("00000001", "00000001", '0', "00000010", '0', '0'),
       ("00000011", "00001000", '0', "00001011", '0', '0'),
       ("00000111", "00000001", '0', "00001000", '0', '0'),
       ("00001111", "00000001", '0', "00010000", '0', '0'),
       ("00011111", "00000001", '0', "00100000", '0', '0'),
       ("00111111", "00000001", '0', "01000000", '0', '0'),
       ("01111111", "00000001", '0', "10000000", '1', '0'),
       ("01000000", "00000001", '0', "01000001", '0', '0'),
       ("10000000", "00000000", '0', "10000000", '0', '0'),

       ------------------------ SUB -----------------------
       ("00000001", "00000001", '1', "00000000", '0', '0'),
       ("00000011", "00001000", '1', "11111011", '0', '0'),
       ("00000111", "00000001", '1', "00000110", '0', '0'),
       ("00001111", "00000001", '1', "00001110", '0', '0'),
       ("00011111", "00000001", '1', "00011110", '0', '0'),
       ("00111111", "00000001", '1', "00111110", '0', '0'),
       ("01111111", "00000001", '1', "01111110", '0', '0'),
       ("01000000", "00000001", '1', "00111111", '0', '0')
       ); -- 1 + 1 = 2
       --("00000010", "00000000", '0', "00000010", '0', '0'),
       --("10000000", "10000000", '0', "00000000", '1', '1'),
       --("01111111", "00000001", '1', "01111110", '0', '0'));
       --("10000001", "00000001", '1', "10000000", '0', '0'),
       --("00000111", "11110000", '1', "01110111", '0', '0'));
begin
  for n in patterns'range loop
    x_tb <= patterns(n).x_tb;
    y_tb <= patterns(n).y_tb;
    sub_tb <= patterns(n).sub_tb;

    wait for 10 ns;

    assert sum_tb = patterns(n).sum_tb
      report "Inaccurate Sum" severity error;

    assert overflow_tb = patterns(n).overflow_tb
      report "Innacurate overflow" severity error;

    assert underflow_tb = patterns(n).underflow_tb
      report "Innacurate Underflow" severity error;
  end loop;

  assert false report "End of tests" severity note;

  wait;
end process;
end dataflow;
