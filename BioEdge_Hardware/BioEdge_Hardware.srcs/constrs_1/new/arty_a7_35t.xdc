## Configuration Bank Voltage Select
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## Clock signal (100 MHz)
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Switches (SW0 = Auto-Scan, SW1 = DNA Input, SW3:2 = Gene Select)
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]

## Buttons (BTN0 = Reset, BTN1 = Inject)
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports rst_btn]
set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS33} [get_ports btn_inject]

## ------------------------------------------------------------------------
## OUTPUT 1: LOCAL STANDALONE VISUALS (Physical LEDs)
## ------------------------------------------------------------------------

## RESULT: RGB LEDs (LD0-LD3) - RED Channels
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports {rgb_red[0]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {rgb_red[1]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {rgb_red[2]}]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {rgb_red[3]}]

## RESULT: RGB LEDs (LD0-LD3) - GREEN Channels
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {rgb_green[0]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {rgb_green[1]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {rgb_green[2]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {rgb_green[3]}]

## PROGRESS BAR: Standard Green LEDs (LD4-LD7)
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {led_progress[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {led_progress[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {led_progress[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {led_progress[3]}]

## ------------------------------------------------------------------------
## OUTPUT 2: STM32 UI DATA LINK (PMOD JA)
## ------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[0]}] ;# JA1 -> STM32 A0
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[1]}] ;# JA2 -> STM32 D0
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[2]}] ;# JA3 -> STM32 D1
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[3]}] ;# JA4 -> STM32 D10
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[4]}] ;# JA7 -> STM32 D11
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[5]}] ;# JA8 -> STM32 D12
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[6]}] ;# JA9 -> STM32 SDA
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {pmod_ja[7]}] ;# JA10 -> STM32 SCL