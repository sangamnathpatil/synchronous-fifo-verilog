# Synchronous FIFO Design and Verification Using Verilog

A synthesizable **8-bit × 16-depth Synchronous FIFO** implemented using Verilog HDL and simulated in QuestaSim.

This project demonstrates FIFO memory management, circular read/write pointers, occupancy tracking, full/empty flag generation, and simultaneous read/write operations.

## Project Overview

FIFO (First-In, First-Out) is a memory-buffering technique in which the first data written is the first data read.

The design uses a **single clock** for both read and write operations, with independent pointers to manage data storage and retrieval.

### Design Specifications

| Parameter | Specification |
|---|---|
| Design | Synchronous FIFO |
| Data Width | 8 bits |
| FIFO Depth | 16 locations |
| Total Storage | 128 bits |
| Clock | Single positive-edge clock |
| Reset | Active-high asynchronous reset |
| Write Pointer | 4 bits |
| Read Pointer | 4 bits |
| Occupancy Counter | 5 bits |
| RTL Language | Verilog HDL |
| Simulation Tool | QuestaSim |

## Key Features

- 16 × 8-bit memory array
- Circular read and write pointer management
- Full and empty flag generation
- FIFO occupancy counter
- Overflow and underflow protection logic
- Simultaneous read and write functionality
- Registered data output
- Asynchronous reset for control registers

## FIFO Architecture

The architecture consists of:

1. **Memory Array:** Stores up to 16 bytes.
2. **Write Pointer:** Selects the next location for incoming data.
3. **Read Pointer:** Selects the oldest unread data.
4. **Occupancy Counter:** Tracks the number of stored bytes.
5. **Control Logic:** Controls accepted read and write operations.

### Read and Write Control

```verilog
assign read_accept = rd_enable && !empty;

assign write_accept =
    wr_enable && (!full || read_accept);
```

### Counter Operation

| Write | Read | Counter |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Decrement |
| 1 | 0 | Increment |
| 1 | 1 | Hold |

When the FIFO is full, a simultaneous read and write is permitted because the read frees space. When empty, simultaneous requests accept only the write.

## Repository Structure

```text
synchronous-fifo-verilog/
│
├── rtl/
│   └── fifo_synchronous.v
│
├── tb/
│   └── fifo_synchronous_tb.v
│
├── docs/
│   └── waveform.png
│
├── run.do
├── README.md
└── .gitignore
```

## Functional Verification

The initial directed Verilog simulation demonstrates:

- FIFO reset functionality
- Writing multiple 8-bit data values
- Reading data in FIFO order
- Simultaneous read and write operations
- Occupancy counter updates
- Empty flag assertion after reading all stored data

### Test Sequence

| Operation | Data | Count |
|---|---|---|
| Reset | — | 0 |
| Write | A5 | 1 |
| Write | FF | 2 |
| Read | A5 | 1 |
| Read FF + Write AA | FF / AA | 1 |
| Read | AA | 0 |

**Observed read sequence:** `A5 → FF → AA`

The basic functional simulation showed correct data ordering and occupancy behavior.

### Simulation Waveform

(docs/Screenshot 2026-10-19 000001.png)

## How to Run the Simulation

Open QuestaSim and execute the following command from the project root:

```tcl
do run.do
```

Example `run.do` script:

```tcl

vlog rtl/fifo_synchronous.v tb/fifo_synchronous_tb.v +acc
vsim work.fifo_tb
add wave -r *
run -all

```

Ensure the testbench calls `$finish` after completing its test sequence.

## Verification Improvements Planned

- Full condition testing with 16 writes
- Overflow and underflow testing
- Simultaneous read/write at full and empty
- Pointer wraparound verification
- SystemVerilog self-checking scoreboard
- Randomized transactions and functional coverage

## Tools and Technologies

- **HDL:** Verilog
- **Simulator:** QuestaSim
- **Design Concepts:** Sequential Logic, FIFO Memory, Circular Pointers
- **Verification:** Directed Testbench, Functional Simulation, Waveform Analysis

## Future Enhancements

Integrate the Synchronous FIFO with a UART Transmitter and Receiver to implement a buffered serial communication system.

Additional enhancements may include SystemVerilog verification, assertions, and a Python-based monitoring GUI.

---

**Project Category:** Digital RTL Design and Functional Verification

**Application Areas:** Data buffering, serial communication interfaces, and digital SoC subsystems.

