LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY soc_top IS
    PORT(
        xtal_clk, reset_button: in std_logic;
        UART_TX: out std_logic;
        led_out: out std_logic_vector(3 downto 0)
    );
END soc_top;

ARCHITECTURE structural OF soc_top IS
    component Gowin_EMPU_Top
        port (
            sys_clk: in std_logic;
            uart0_rxd: in std_logic;
            uart0_txd: out std_logic;
            master_hclk: out std_logic;
            master_hrst: out std_logic;
            master_hsel: out std_logic;
            master_haddr: out std_logic_vector(31 downto 0);
            master_htrans: out std_logic_vector(1 downto 0);
            master_hwrite: out std_logic;
            master_hsize: out std_logic_vector(2 downto 0);
            master_hburst: out std_logic_vector(2 downto 0);
            master_hprot: out std_logic_vector(3 downto 0);
            master_memattr: out std_logic_vector(1 downto 0);
            master_exreq: out std_logic;
            master_hmaster: out std_logic_vector(3 downto 0);
            master_hwdata: out std_logic_vector(31 downto 0);
            master_hmastlock: out std_logic;
            master_hreadymux: out std_logic;
            master_hauser: out std_logic;
            master_hwuser: out std_logic_vector(3 downto 0);
            master_hrdata: in std_logic_vector(31 downto 0);
            master_hreadyout: in std_logic;
            master_hresp: in std_logic;
            master_exresp: in std_logic;
            master_hruser: in std_logic_vector(2 downto 0);
            reset_n: in std_logic
        );
    end component;

    COMPONENT ahb_interconnect 
        PORT(
            HADDR: in std_logic_vector(31 downto 0);
            HSEL_LED: out std_logic
        );
    END COMPONENT;

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
    
    SIGNAL MOSI_HADDR: std_logic_vector(31 downto 0);
    SIGNAL MOSI_HCLK: std_logic;
    SIGNAL MOSI_HWDATA: std_logic_vector(31 downto 0);
    SIGNAL MOSI_HRESETn: std_logic;
    SIGNAL MOSI_HTRANS: std_logic_vector(1 downto 0);
    SIGNAL MOSI_HWRITE: std_logic;
    SIGNAL MOSI_HREADY: std_logic;
    SIGNAL MOSI_HSIZE: std_logic_vector(2 downto 0);
    SIGNAL MOSI_HBURST: std_logic_vector(2 downto 0);


    SIGNAL MISO_HRDATA: std_logic_vector(31 downto 0);
    SIGNAL MISO_HREADY: std_logic;
    SIGNAL MISO_HRESP: std_logic;

    SIGNAL SUBO_SELECT: std_logic;

    BEGIN
        my_led : ahb_led
            PORT MAP (
                HADDR => MOSI_HADDR,
                HBURST => "000",
				HMASTLOCK => '0',
				HPROT => "0000",
				HREADY => '1',
				HSIZE => MOSI_HSIZE,
                HCLK => MOSI_HCLK,
                HRDATA => MISO_HRDATA,
                HREADYOUT => MISO_HREADY,
                HRESETn => MOSI_HRESETn,
                HRESP => MISO_HRESP,
                HSEL => SUBO_SELECT,
                HTRANS => MOSI_HTRANS,
                HWDATA => MOSI_HWDATA,
                H_LED_OUT => led_out,
                HWRITE => MOSI_HWRITE
            );

        my_cm3 : Gowin_EMPU_Top
            port map (
                sys_clk => xtal_clk,
                uart0_rxd => '1',
                uart0_txd => UART_TX,
                master_hclk => MOSI_HCLK,
                master_hrst => MOSI_HRESETn,
                --master_hsel => master_hsel_o,
                master_haddr => MOSI_HADDR,
                master_htrans => MOSI_HTRANS,
                master_hwrite => MOSI_HWRITE,
                master_hsize => MOSI_HSIZE,
                master_hburst => MOSI_HBURST,
                --master_hprot => master_hprot_o,
                --master_memattr => master_memattr_o,
                --master_exreq => master_exreq_o,
                --master_hmaster => master_hmaster_o,
                master_hwdata => MOSI_HWDATA,
                --master_hmastlock => master_hmastlock_o,
                --master_hreadymux => master_hreadymux_o,
                --master_hauser => master_hauser_o,
                --master_hwuser => master_hwuser_o,
                master_hrdata => MISO_HRDATA,
                master_hreadyout => MISO_HREADY,
                master_hresp => MISO_HRESP,
                --master_exresp => master_exresp_i,
                --master_hruser => master_hruser_i,
                reset_n => reset_button
            );
        
        my_decoder : ahb_interconnect
            PORT MAP (
                HADDR => MOSI_HADDR,
                HSEL_LED => SUBO_SELECT
            );
END structural;