library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Traffic is
Generic(
    GR_time: integer := 50;
    YR_time: integer := 5;
    RG_time: integer := 35;
    RY_time: integer := 5
);
Port( 
    clk: in std_logic;
    reset: in std_logic;
    
    R1: out std_logic;
    Y1: out std_logic;
    G1: out std_logic;
    R2: out std_logic;
    Y2: out std_logic;
    G2: out std_logic
);
end Traffic;

architecture Behavioral of Traffic is

component clock_div
Generic(
    N: integer
);
Port(
    clk: in std_logic;
    div_clk: buffer std_logic
);
end component;

signal div_clk: std_logic;
signal counterGR: integer := 0;
signal counterYR: integer := 0;
signal counterRG: integer := 0;
signal counterRY: integer := 0;

type s_type is (GR, YR, RG, RY);
signal state: s_type;

begin

clk_div: clock_div
Generic map(
    N => 50
)
Port map(
    clk => clk,
    div_clk => div_clk
);

process(reset, div_clk) begin
    if(reset = '1') then
        state <= GR;
        R1 <= '0';
        Y1 <= '0';
        G1 <= '0';
        R2 <= '0';
        Y2 <= '0';
        G2 <= '0';
        counterGR <= 0;
        counterYR <= 0;
        counterRG <= 0;
        counterRY <= 0;
    elsif rising_edge(div_clk) then
        case state is
            when GR =>
                R1 <= '0';
                Y1 <= '0';
                G1 <= '1';
                R2 <= '1';
                Y2 <= '0';
                G2 <= '0';
                if(counterGR = GR_time - 1) then
                    state <= YR;
                    counterGR <= 0;
                else
                    state <= GR;
                    counterGR <= counterGR + 1;
                end if;
            when YR =>
                R1 <= '0';
                Y1 <= '1';
                G1 <= '0';
                R2 <= '1';
                Y2 <= '0';
                G2 <= '0';
                if(counterYR = YR_time - 1) then
                    state <= RG;
                    counterYR <= 0;
                else
                    state <= YR;
                    counterYR <= counterYR + 1;
                end if;
            when RG =>
                R1 <= '1';
                Y1 <= '0';
                G1 <= '0';
                R2 <= '0';
                Y2 <= '0';
                G2 <= '1';
                if(counterRG = RG_time - 1) then
                    state <= RY;
                    counterRG <= 0;
                else
                    state <= RG;
                    counterRG <= counterRG + 1;
                end if;
            when RY =>
                R1 <= '1';
                Y1 <= '0';
                G1 <= '0';
                R2 <= '0';
                Y2 <= '1';
                G2 <= '0';
                if(counterRY = RY_time - 1) then
                    state <= GR;
                    counterRY <= 0;
                else
                    state <= RY;
                    counterRY <= counterRY + 1;
                end if;
        end case;
    end if;
end process;
end Behavioral;
