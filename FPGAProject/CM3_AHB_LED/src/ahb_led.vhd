LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ahb_led IS
    PORT(
        HADDR: in std_logic_vector(31 downto 0);
        HBURST: in std_logic_vector(2 downto 0);
        HCLK: in std_logic;
        HMASTLOCK: in std_logic;
        HPROT: in std_logic_vector(3 downto 0);
        HRDATA: out std_logic_vector(31 downto 0);
        HREADYOUT: out std_logic;
        HREADY: in std_logic;
        HRESETn: in std_logic; --active low reset
        HRESP: out std_logic;
        HSEL: in std_logic;
        HSIZE: in std_logic_vector(2 downto 0);
        HTRANS: in std_logic_vector(1 downto 0);
        HWDATA: in std_logic_vector(31 downto 0);
        HWRITE: in std_logic;
        H_LED_OUT: out std_logic_vector(3 downto 0)
    );
END ahb_led;

ARCHITECTURE behave OF ahb_led IS
	SIGNAL data_received: std_logic_vector(31 downto 0) := X"00000000";
	BEGIN
	PROCESS(HRESETn, HCLK, HSEL, HWRITE, HTRANS) IS
		BEGIN
        IF (HRESETn = '1') THEN 
            IF (HCLK'event AND HCLK = '1') THEN
                IF (HSEL = '1') THEN
                    IF (HTRANS(1) = '1') THEN
                        IF (HWRITE = '1') THEN
                            CASE HSIZE IS
                                WHEN "000" =>
                                    data_received(7 downto 0) <=  HWDATA(7 downto 0);
                                    data_received(31 downto 8) <= (others => '0');
                                WHEN "001" =>
                                    data_received(15 downto 0) <=  HWDATA(15 downto 0);
                                    data_received(31 downto 16) <= (others => '0');
                                    --data_received(31 downto 16) <= HWDATA(31 downto 16);
                                WHEN "010" =>
                                    data_received <= HWDATA;
                                WHEN OTHERS =>
                                    data_received <= (others => '0');
                            END CASE;
                        END IF;
                    ELSE
                    END IF;
                END IF;
            END IF;
        ELSE --active low reset
            data_received <= X"00000000";
        END IF;
	END PROCESS;

	H_LED_OUT <= NOT(data_received(3 downto 0)); --LED inverted sink current output
    HREADYOUT <= '1';
    HRDATA <= data_received;
    HRESP <= '0';
END behave;