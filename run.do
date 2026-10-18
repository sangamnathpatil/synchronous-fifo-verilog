vlog fifo_synchronous.v fifo_synchronous_tb.v +acc
vsim fifo_tb
add wave -r *
run -all
