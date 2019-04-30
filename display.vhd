library ieee;
use ieee.std_logic_1164.all;

entity display is
  port (
    enable      : in  std_logic;
    input       : in  std_logic_vector(7 downto 0);
    output      : out std_logic_vector(7 downto 0)
    );
end entity display;

architecture dataflow of display is
begin
  output <= input when (en='1') else "ZZZZZZZZ";

  -- Only activate when there is a change to enable bit
  process(enable) is

  begin                      
    
    if(enable = '1') then     
      report
        std_logic'image(input(7))&
        std_logic'image(input(6))&                                
        std_logic'image(input(5))&
        std_logic'image(input(4))&
        std_logic'image(input(3))&    
        std_logic'image(input(2))&
        std_logic'image(input(1))&
        std_logic'image(input(0))
        severity note;
      
    end if;
    
  end process;
end architecture dataflow;
           
                        
                       
