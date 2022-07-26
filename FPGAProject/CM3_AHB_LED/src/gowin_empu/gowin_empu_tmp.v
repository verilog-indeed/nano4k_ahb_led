//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: GowinSynthesis V1.9.8 Education
//Part Number: GW1NSR-LV4CQN48PC6/I5
//Device: GW1NSR-4C
//Created Time: Fri Jun 10 14:51:53 2022

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_EMPU_Top your_instance_name(
		.sys_clk(sys_clk_i), //input sys_clk
		.uart0_rxd(uart0_rxd_i), //input uart0_rxd
		.uart0_txd(uart0_txd_o), //output uart0_txd
		.master_hclk(master_hclk_o), //output master_hclk
		.master_hrst(master_hrst_o), //output master_hrst
		.master_hsel(master_hsel_o), //output master_hsel
		.master_haddr(master_haddr_o), //output [31:0] master_haddr
		.master_htrans(master_htrans_o), //output [1:0] master_htrans
		.master_hwrite(master_hwrite_o), //output master_hwrite
		.master_hsize(master_hsize_o), //output [2:0] master_hsize
		.master_hburst(master_hburst_o), //output [2:0] master_hburst
		.master_hprot(master_hprot_o), //output [3:0] master_hprot
		.master_memattr(master_memattr_o), //output [1:0] master_memattr
		.master_exreq(master_exreq_o), //output master_exreq
		.master_hmaster(master_hmaster_o), //output [3:0] master_hmaster
		.master_hwdata(master_hwdata_o), //output [31:0] master_hwdata
		.master_hmastlock(master_hmastlock_o), //output master_hmastlock
		.master_hreadymux(master_hreadymux_o), //output master_hreadymux
		.master_hauser(master_hauser_o), //output master_hauser
		.master_hwuser(master_hwuser_o), //output [3:0] master_hwuser
		.master_hrdata(master_hrdata_i), //input [31:0] master_hrdata
		.master_hreadyout(master_hreadyout_i), //input master_hreadyout
		.master_hresp(master_hresp_i), //input master_hresp
		.master_exresp(master_exresp_i), //input master_exresp
		.master_hruser(master_hruser_i), //input [2:0] master_hruser
		.reset_n(reset_n_i) //input reset_n
	);

//--------Copy end-------------------
