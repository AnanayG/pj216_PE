onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /M216A_TB/D_In1
add wave -noupdate -radix unsigned /M216A_TB/D_In2
add wave -noupdate -radix unsigned /M216A_TB/D_In3
add wave -noupdate -radix unsigned /M216A_TB/Instruction_In
add wave -noupdate -radix unsigned /M216A_TB/clk
add wave -noupdate -radix unsigned /M216A_TB/rst
add wave -noupdate -radix unsigned /M216A_TB/D_Out
add wave -noupdate -radix unsigned /M216A_TB/uut/D_In1
add wave -noupdate -radix unsigned /M216A_TB/uut/D_Out
add wave -noupdate /M216A_TB/uut/Instruction_In
add wave -noupdate -radix unsigned /M216A_TB/uut/reg_in1_0
add wave -noupdate -radix unsigned /M216A_TB/uut/reg_in1_1
add wave -noupdate -radix unsigned /M216A_TB/uut/reg_in1_3
add wave -noupdate -radix unsigned /M216A_TB/uut/reg_in1_4
add wave -noupdate -radix unsigned /M216A_TB/uut/adder_in1
add wave -noupdate -radix unsigned /M216A_TB/uut/adder_in2
add wave -noupdate -radix unsigned /M216A_TB/uut/adder_out
add wave -noupdate -radix unsigned /M216A_TB/uut/mult_in1
add wave -noupdate -radix unsigned /M216A_TB/uut/mult_in2
add wave -noupdate -radix unsigned /M216A_TB/uut/mult_out
add wave -noupdate -radix unsigned /M216A_TB/uut/reg_in1_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {174800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {100300 ps} {205300 ps}
