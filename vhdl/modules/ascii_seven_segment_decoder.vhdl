library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ascii_seven_segment_decoder is
    port(
        input_char : in  character;
        segments   : out std_ulogic_vector(7 downto 0)
    );
end ascii_seven_segment_decoder;

architecture rtl of ascii_seven_segment_decoder is

    signal ascii_code : natural;

    type segment_map_t is array (0 to 95) of std_ulogic_vector(7 downto 0);

    -- array to map ASCII characters to their corresponding segments
    constant segment_map : segment_map_t := (
        "00000000",                     -- (space) 
        "10000110",                     -- ! 
        "00100010",                     -- " 
        "01111110",                     -- # 
        "01101101",                     -- $ 
        "11010010",                     -- % 
        "01000110",                     -- & 
        "00100000",                     -- ' 
        "00101001",                     -- ( 
        "00001011",                     -- ) 
        "00100001",                     -- * 
        "01110000",                     -- + 
        "00010000",                     -- , 
        "01000000",                     -- - 
        "10000000",                     -- . 
        "01010010",                     -- / 
        "00111111",                     -- 0 
        "00000110",                     -- 1 
        "01011011",                     -- 2 
        "01001111",                     -- 3 
        "01100110",                     -- 4 
        "01101101",                     -- 5 
        "01111101",                     -- 6 
        "00000111",                     -- 7 
        "01111111",                     -- 8 
        "01101111",                     -- 9 
        "00001001",                     -- : 
        "00001101",                     -- ; 
        "01100001",                     -- < 
        "01001000",                     -- = 
        "01000011",                     -- > 
        "11010011",                     -- ? 
        "01011111",                     -- @ 
        "01110111",                     -- A 
        "01111100",                     -- B 
        "00111001",                     -- C 
        "01011110",                     -- D 
        "01111001",                     -- E 
        "01110001",                     -- F 
        "00111101",                     -- G 
        "01110110",                     -- H 
        "00110000",                     -- I 
        "00011110",                     -- J 
        "01110101",                     -- K 
        "00111000",                     -- L 
        "00010101",                     -- M 
        "00110111",                     -- N 
        "00111111",                     -- O 
        "01110011",                     -- P 
        "01101011",                     -- Q 
        "00110011",                     -- R 
        "01101101",                     -- S 
        "01111000",                     -- T 
        "00111110",                     -- U 
        "00111110",                     -- V 
        "00101010",                     -- W 
        "01110110",                     -- X 
        "01101110",                     -- Y 
        "01011011",                     -- Z 
        "00111001",                     -- [ 
        "01100100",                     -- \ 
        "00001111",                     -- ] 
        "00100011",                     -- ^ 
        "00001000",                     -- _ 
        "00000010",                     -- ` 
        "01011111",                     -- a 
        "01111100",                     -- b 
        "01011000",                     -- c 
        "01011110",                     -- d 
        "01111011",                     -- e 
        "01110001",                     -- f 
        "01101111",                     -- g 
        "01110100",                     -- h 
        "00010000",                     -- i 
        "00001100",                     -- j 
        "01110101",                     -- k 
        "00110000",                     -- l 
        "00010100",                     -- m 
        "01010100",                     -- n 
        "01011100",                     -- o 
        "01110011",                     -- p 
        "01100111",                     -- q 
        "01010000",                     -- r 
        "01101101",                     -- s 
        "01111000",                     -- t 
        "00011100",                     -- u 
        "00011100",                     -- v 
        "00010100",                     -- w 
        "01110110",                     -- x 
        "01101110",                     -- y 
        "01011011",                     -- z 
        "01000110",                     -- { 
        "00110000",                     -- | 
        "01110000",                     -- } 
        "00000001",                     -- ~ 
        "00000000"                      -- (del) 
    );

begin

    -- convert the input char to ASCII code
    process(input_char)
    begin
        ascii_code <= character'pos(input_char) - 32; -- get ascii code, remove first 32 ascii chars
    end process;

    -- assign the segments based on the ASCII code
    segments <= segment_map(ascii_code);

end architecture rtl;
