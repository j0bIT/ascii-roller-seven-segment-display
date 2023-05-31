library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ascii_display_top is
    port(
        clock_in     : in  std_ulogic;
        reset_n      : in  std_ulogic;
        roller_en    : in  std_ulogic;
        -- segment 1
        segment_a_1  : out std_ulogic;
        segment_b_1  : out std_ulogic;
        segment_c_1  : out std_ulogic;
        segment_d_1  : out std_ulogic;
        segment_e_1  : out std_ulogic;
        segment_f_1  : out std_ulogic;
        segment_g_1  : out std_ulogic;
        segment_dp_1 : out std_ulogic;
        -- segment 2
        segment_a_2  : out std_ulogic;
        segment_b_2  : out std_ulogic;
        segment_c_2  : out std_ulogic;
        segment_d_2  : out std_ulogic;
        segment_e_2  : out std_ulogic;
        segment_f_2  : out std_ulogic;
        segment_g_2  : out std_ulogic;
        segment_dp_2 : out std_ulogic;
        -- segment 3
        segment_a_3  : out std_ulogic;
        segment_b_3  : out std_ulogic;
        segment_c_3  : out std_ulogic;
        segment_d_3  : out std_ulogic;
        segment_e_3  : out std_ulogic;
        segment_f_3  : out std_ulogic;
        segment_g_3  : out std_ulogic;
        segment_dp_3 : out std_ulogic;
        -- segment 4
        segment_a_4  : out std_ulogic;
        segment_b_4  : out std_ulogic;
        segment_c_4  : out std_ulogic;
        segment_d_4  : out std_ulogic;
        segment_e_4  : out std_ulogic;
        segment_f_4  : out std_ulogic;
        segment_g_4  : out std_ulogic;
        segment_dp_4 : out std_ulogic;
        -- segment 5
        segment_a_5  : out std_ulogic;
        segment_b_5  : out std_ulogic;
        segment_c_5  : out std_ulogic;
        segment_d_5  : out std_ulogic;
        segment_e_5  : out std_ulogic;
        segment_f_5  : out std_ulogic;
        segment_g_5  : out std_ulogic;
        segment_dp_5 : out std_ulogic;
        -- segment 6
        segment_a_6  : out std_ulogic;
        segment_b_6  : out std_ulogic;
        segment_c_6  : out std_ulogic;
        segment_d_6  : out std_ulogic;
        segment_e_6  : out std_ulogic;
        segment_f_6  : out std_ulogic;
        segment_g_6  : out std_ulogic;
        segment_dp_6 : out std_ulogic
    );
end entity ascii_display_top;

architecture rtl of ascii_display_top is
    constant ASCII_STRING          : string  := "HEY   ";
    constant ASCII_ROLLER_INTERVAL : natural := 20000000;

    -- reset
    signal reset : std_ulogic;

    -- segments
    signal segments_1 : std_ulogic_vector(7 downto 0);
    signal segments_2 : std_ulogic_vector(7 downto 0);
    signal segments_3 : std_ulogic_vector(7 downto 0);
    signal segments_4 : std_ulogic_vector(7 downto 0);
    signal segments_5 : std_ulogic_vector(7 downto 0);
    signal segments_6 : std_ulogic_vector(7 downto 0);

    -- chars
    signal char_1 : character;
    signal char_2 : character;
    signal char_3 : character;
    signal char_4 : character;
    signal char_5 : character;
    signal char_6 : character;

    component ascii_roller is
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
    end component ascii_roller;

    component ascii_seven_segment_decoder is
        port(
            input_char : in  character;
            segments   : out std_ulogic_vector(7 downto 0)
        );
    end component ascii_seven_segment_decoder;

begin
    -- roll the string
    ascii_roller_1 : ascii_roller
        port map(
            clock        => clock_in,
            reset        => reset,
            roller_en    => roller_en,
            interval     => ASCII_ROLLER_INTERVAL,
            input_string => ASCII_STRING,
            char_1       => char_1,
            char_2       => char_2,
            char_3       => char_3,
            char_4       => char_4,
            char_5       => char_5,
            char_6       => char_6
        );

    -- decode ascii chars to seven segment
    ascii_decoder_1 : ascii_seven_segment_decoder
        port map(
            input_char => char_6,
            segments   => segments_1
        );

    ascii_decoder_2 : ascii_seven_segment_decoder
        port map(
            input_char => char_5,
            segments   => segments_2
        );

    ascii_decoder_3 : ascii_seven_segment_decoder
        port map(
            input_char => char_4,
            segments   => segments_3
        );

    ascii_decoder_4 : ascii_seven_segment_decoder
        port map(
            input_char => char_3,
            segments   => segments_4
        );

    ascii_decoder_5 : ascii_seven_segment_decoder
        port map(
            input_char => char_2,
            segments   => segments_5
        );

    ascii_decoder_6 : ascii_seven_segment_decoder
        port map(
            input_char => char_1,
            segments   => segments_6
        );

    -- assign reset
    reset <= not reset_n;

    -- assign the segments
    segment_a_1  <= not segments_1(0);
    segment_b_1  <= not segments_1(1);
    segment_c_1  <= not segments_1(2);
    segment_d_1  <= not segments_1(3);
    segment_e_1  <= not segments_1(4);
    segment_f_1  <= not segments_1(5);
    segment_g_1  <= not segments_1(6);
    segment_dp_1 <= not segments_1(7);

    segment_a_2  <= not segments_2(0);
    segment_b_2  <= not segments_2(1);
    segment_c_2  <= not segments_2(2);
    segment_d_2  <= not segments_2(3);
    segment_e_2  <= not segments_2(4);
    segment_f_2  <= not segments_2(5);
    segment_g_2  <= not segments_2(6);
    segment_dp_2 <= not segments_2(7);

    segment_a_3  <= not segments_3(0);
    segment_b_3  <= not segments_3(1);
    segment_c_3  <= not segments_3(2);
    segment_d_3  <= not segments_3(3);
    segment_e_3  <= not segments_3(4);
    segment_f_3  <= not segments_3(5);
    segment_g_3  <= not segments_3(6);
    segment_dp_3 <= not segments_3(7);

    segment_a_4  <= not segments_4(0);
    segment_b_4  <= not segments_4(1);
    segment_c_4  <= not segments_4(2);
    segment_d_4  <= not segments_4(3);
    segment_e_4  <= not segments_4(4);
    segment_f_4  <= not segments_4(5);
    segment_g_4  <= not segments_4(6);
    segment_dp_4 <= not segments_4(7);

    segment_a_5  <= not segments_5(0);
    segment_b_5  <= not segments_5(1);
    segment_c_5  <= not segments_5(2);
    segment_d_5  <= not segments_5(3);
    segment_e_5  <= not segments_5(4);
    segment_f_5  <= not segments_5(5);
    segment_g_5  <= not segments_5(6);
    segment_dp_5 <= not segments_5(7);

    segment_a_6  <= not segments_6(0);
    segment_b_6  <= not segments_6(1);
    segment_c_6  <= not segments_6(2);
    segment_d_6  <= not segments_6(3);
    segment_e_6  <= not segments_6(4);
    segment_f_6  <= not segments_6(5);
    segment_g_6  <= not segments_6(6);
    segment_dp_6 <= not segments_6(7);

end architecture rtl;
