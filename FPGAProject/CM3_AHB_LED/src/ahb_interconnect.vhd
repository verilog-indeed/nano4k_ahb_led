LIBRARY ieee;
USE ieee.std_logic_1164.all;

--Provides address decoding
ENTITY ahb_interconnect IS
    PORT(
        HADDR: in std_logic_vector(31 downto 0);
        HSEL_LED: out std_logic
    );
END ahb_interconnect;

ARCHITECTURE behave OF ahb_interconnect IS
    BEGIN
    WITH HADDR SELECT
    HSEL_LED <= '1' WHEN X"A000000C", --LED address is 0xA000000C
                '0' WHEN OTHERS;
END behave;