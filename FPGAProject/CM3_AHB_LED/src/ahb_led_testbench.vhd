LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ahb_led_testbench IS
END ahb_led_testbench;

ARCHITECTURE simulation OF ahb_led_testbench IS

	SIGNAL MOSI_HADDR: std_logic_vector(31 downto 0);
    SIGNAL MOSI_HCLK: std_logic := '0';
    SIGNAL MOSI_HWDATA: std_logic_vector(31 downto 0);
    SIGNAL MOSI_HRESETn: std_logic := '0';
    SIGNAL MOSI_HTRANS: std_logic_vector(1 downto 0);
    SIGNAL MOSI_HWRITE: std_logic;

    SIGNAL MISO_HRDATA: std_logic_vector(31 downto 0);
    SIGNAL MISO_HREADY: std_logic;
    SIGNAL MISO_HRESP: std_logic;

    SIGNAL SUBO_SELECT: std_logic;
	SIGNAL led_out: std_logic_vector(3 downto 0);

	COMPONENT ahb_led 
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
    END COMPONENT;
	
	COMPONENT ahb_interconnect 
        PORT(
            HADDR: in std_logic_vector(31 downto 0);
            HSEL_LED: out std_logic
        );
    END COMPONENT;
	
	BEGIN
		MOSI_HCLK <= NOT MOSI_HCLK after 1 ns;
		MOSI_HRESETn <= '0', '1' after 5 ns;
		
		led : ahb_led
            PORT MAP (
                HADDR => MOSI_HADDR,
                HBURST => "000",
				HMASTLOCK => '0',
				HPROT => "0000",
				HREADY => '1',
				HSIZE => "000",
                HCLK => MOSI_HCLK,
                HRDATA => MISO_HRDATA,
                HREADYOUT => MISO_HREADY,
                HRESETn => MOSI_HRESETn,
                HRESP => MISO_HRESP,
                HSEL => SUBO_SELECT,
                HTRANS => MOSI_HTRANS,
                HWDATA => MOSI_HWDATA,
                HWRITE => MOSI_HWRITE,
                H_LED_OUT => led_out
            );
		
		decoder : ahb_interconnect
            PORT MAP (
                HADDR => MOSI_HADDR,
                HSEL_LED => SUBO_SELECT
            );
			
		PROCESS BEGIN
			WAIT UNTIL(MOSI_HRESETn = '1');
			MOSI_HADDR <= X"A000000A";
			MOSI_HWDATA <= X"5FFFFFFF";
			MOSI_HWRITE <= '1';
			MOSI_HTRANS <= "10";
			WAIT FOR 2 ns;
			MOSI_HTRANS <= "00";
			WAIT FOR 2 ns;
			MOSI_HWRITE <= '0';
			MOSI_HTRANS <= "10";
			WAIT FOR 2 ns;
			MOSI_HTRANS <= "00";
			MOSI_HADDR <= (others => 'Z');
			MOSI_HWDATA <= (others => 'Z');
			WAIT;
		END PROCESS;
END simulation;