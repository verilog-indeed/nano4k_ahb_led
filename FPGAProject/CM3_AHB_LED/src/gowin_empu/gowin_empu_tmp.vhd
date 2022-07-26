--Copyright (C)2014-2021 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--GOWIN Version: GowinSynthesis V1.9.8 Education
--Part Number: GW1NSR-LV4CQN48PC6/I5
--Device: GW1NSR-4C
--Created Time: Fri Jun 10 14:53:22 2022

--Change the instance name and port connections to the signal names
----------Copy here to design--------

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

your_instance_name: Gowin_EMPU_Top
	port map (
		sys_clk => sys_clk_i,
		uart0_rxd => uart0_rxd_i,
		uart0_txd => uart0_txd_o,
		master_hclk => master_hclk_o,
		master_hrst => master_hrst_o,
		master_hsel => master_hsel_o,
		master_haddr => master_haddr_o,
		master_htrans => master_htrans_o,
		master_hwrite => master_hwrite_o,
		master_hsize => master_hsize_o,
		master_hburst => master_hburst_o,
		master_hprot => master_hprot_o,
		master_memattr => master_memattr_o,
		master_exreq => master_exreq_o,
		master_hmaster => master_hmaster_o,
		master_hwdata => master_hwdata_o,
		master_hmastlock => master_hmastlock_o,
		master_hreadymux => master_hreadymux_o,
		master_hauser => master_hauser_o,
		master_hwuser => master_hwuser_o,
		master_hrdata => master_hrdata_i,
		master_hreadyout => master_hreadyout_i,
		master_hresp => master_hresp_i,
		master_exresp => master_exresp_i,
		master_hruser => master_hruser_i,
		reset_n => reset_n_i
	);

----------Copy end-------------------
