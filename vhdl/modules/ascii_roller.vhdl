library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ascii_roller is
    port(
        clock        : in  std_ulogic;
        reset        : in  std_ulogic;
        roller_en    : in  std_ulogic;
        interval     : in  natural;
        input_string : in  string;
        char_1       : out character;
        char_2       : out character;
        char_3       : out character;
        char_4       : out character;
        char_5       : out character;
        char_6       : out character
    );
end ascii_roller;

architecture rtl of ascii_roller is
    signal count_reg : natural := 0;
    signal count_nxt : natural;

    signal index_reg : natural := 0;
    signal index_nxt : natural;
begin
    process(clock, reset)
    begin
        if reset = '1' then
            count_reg <= 0;
            index_reg <= 0;
        elsif rising_edge(clock) then
            count_reg <= count_nxt;
            index_reg <= index_nxt;
        end if;
    end process;

    process(count_reg, index_reg, roller_en, interval)
    begin
        if roller_en = '1' then
            count_nxt <= count_reg + 1;
            index_nxt <= index_reg;
        else
            count_nxt <= 0;
            index_nxt <= 0;
        end if;

        if count_reg = interval then
            if index_reg + 1 < input_string'length then
                index_nxt <= index_reg + 1;
            else
                index_nxt <= 0;
            end if;
            count_nxt <= 0;
        end if;
    end process;

    -- assign the char based on the index
    char_1 <= input_string(((index_reg) mod input_string'length) + 1);
    char_2 <= input_string(((index_reg + 1) mod input_string'length) + 1);
    char_3 <= input_string(((index_reg + 2) mod input_string'length) + 1);
    char_4 <= input_string(((index_reg + 3) mod input_string'length) + 1);
    char_5 <= input_string(((index_reg + 4) mod input_string'length) + 1);
    char_6 <= input_string(((index_reg + 5) mod input_string'length) + 1);

end architecture rtl;
