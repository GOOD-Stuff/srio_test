----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2017 18:10:31
-- Design Name: 
-- Module Name: test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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


entity test is
    port(
        CLK             : in std_logic;
        RESET           : in std_Logic;
        S_AXIS_TDATA    : in std_logic_vector ( 63 downto 0 ) ;
        S_AXIS_TVALID   : in std_logic;
        M_AXIS_TDATA    : out std_logic_vector ( 63 downto 0 )
    );
end test;


architecture Behavioral of test is

    signal data : std_logic_vector ( 63 downto 0 ) ;

begin

    data_processing : process(CLK)
    begin
        if CLK'event AND CLK = '1' then
            if RESET = '1' then
                data <= (others => '0');
            else
                if S_AXIS_TVALID = '1' then
                    data <= S_AXIS_TDATA;
                else
                    data <= data;
                end if;
            end if;
        end if;
    end process;

    M_AXIS_TDATA <= DATA;

end Behavioral;
