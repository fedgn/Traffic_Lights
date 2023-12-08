library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_div is
generic(
    N: integer := 50000
);
Port ( 
    clk: in std_logic;
    div_clk: buffer std_logic := '0'
);
end clock_div;

architecture Behavioral of clock_div is

signal count: integer := 0;

begin

process(clk) begin
    if rising_edge(clk) then
        if(count = N-1) then
            count <= 0;
            div_clk <= not div_clk;
        else
            count <= count + 1;
        end if;
    end if;
end process;
end Behavioral;
