ghdl -a ahb_led_testbench.vhd ahb_led.vhd ahb_interconnect.vhd
ghdl -e ahb_led_testbench
ghdl -r ahb_led_testbench --wave=wave.ghw --stop-time=1us