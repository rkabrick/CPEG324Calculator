library ieee;
use ieee.std_logic_1164.all;

entity reg_file is
  port( rs, rt, rd  : in std_logic_vector(1 downto 0);
        reg_write   : in std_logic_vector(7 downto 0);
        clk         : in std_logic;
        enable      : in std_logic;
        rs_data, rt_data : out std_logic_vector(7 downto 0)
        );
end entity reg_file;

architecture dataflow of reg_file is
  component shift_reg_8bit is
    port(I:            in std_logic_vector(7 downto 0);
         I_SHIFT_IN:   in std_logic;
         sel:          in std_logic_vector(1 downto 0);
         clock:        in std_logic;
         enable:       in std_logic;
         o:            out std_logic_vector(7 downto 0)
         );
  end component;

  signal input : std_logic_vector(7 downto 0);
  signal reg1_data : std_logic_vector(7 downto 0);
  signal reg2_data : std_logic_vector(7 downto 0);
  signal reg3_data : std_logic_vector(7 downto 0);
  signal reg4_data : std_logic_vector(7 downto 0);
  signal en1,en2,en3,en4 : std_logic := '1';

begin
  reg1 : shift_reg_8bit port map(I => input,
                                 I_SHIFT_IN => '0',
                                 sel => "00",
                                 clock => clk,
                                 enable => en1,
                                 o => reg1_data);

  reg2 : shift_reg_8bit port map(I => input,
                                 I_SHIFT_IN => '0',
                                 sel => "00",
                                 clock => clk,
                                 enable => en2,
                                 o => reg2_data);

  reg3 : shift_reg_8bit port map(I => input,
                                 I_SHIFT_IN => '0',
                                 sel => "00",
                                 clock => clk,
                                 enable => en3,
                                 o => reg3_data);

  reg4 : shift_reg_8bit port map(I => input,
                                 I_SHIFT_IN => '0',
                                 sel => "00",
                                 clock => clk,
                                 enable => en4,
                                 o => reg4_data);

  en1 <= '1' when (rd = "00" and enable = '1') else '0';
  en2 <= '1' when (rd = "01" and enable = '1') else '0';
  en3 <= '1' when (rd = "10" and enable = '1') else '0';
  en4 <= '1' when (rd = "11" and enable = '1') else '0';

  rs_data <= reg1_data when rs = "00" else
             reg2_data when rs = "01" else
             reg3_data when rs = "10" else
             reg4_data when rs = "11";

  rt_data <= reg1_data when rt = "00" else
             reg2_data when rt = "01" else
             reg3_data when rt = "10" else
             reg4_data when rt = "11";
end dataflow;
