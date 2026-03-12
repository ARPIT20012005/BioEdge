# BioEdge 1.0: Hardware-Accelerated Genomic Diagnostics at the Edge

![Hardware](https://img.shields.io/badge/Hardware-Arty_A7_35T-blue?style=flat-square)
![FPGA](https://img.shields.io/badge/FPGA-Xilinx_Vivado-red?style=flat-square)
![Software](https://img.shields.io/badge/Software-Python_3.8+-yellow?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**BioEdge** is a custom-engineered, fully offline diagnostic system that bridges the gap between complex bioinformatics and point-of-care medical hardware. By hardwiring a 1D-CNN risk-scoring algorithm directly into custom FPGA silicon, BioEdge bypasses traditional CPU bottlenecks to deliver real-time, zero-latency DNA mutation analysis.

![BioEdge prototype hardware](BioEdge_Project/docs/images/bioedge_hardware_setup.jpg)

---

## 🧬 The Problem 

* DNA mutations occur naturally in every human body every single day.
* Certain mutation changes can cause serious diseases like cancer.
* It is very difficult to identify mutations and difficult to know which change is harmless or dangerous.
* Doctors often face challenges in predicting the cause of disease and diagnosis.
* **Quick analysis and identification is required** for better early detection for preventive and early detection of disease.

## 💡 The BioEdge Solution

* **Instant Mutation Analysis:** Helps doctors to identify dangerous mutations immediately.
* **Database Comparison:** By comparing patients' DNA sequences with the Public NIH (National Institute of Health) ClinVar database, early and quick diagnosis is possible.
* **Hardware Architecture:** We proposed an **FPGA-based low power, zero latency**, and **completely offline solution** for the detection of DNA sequence changes and diagnosis.
* **Edge AI Integration:** We incorporated an **Artificial Intelligence 1D-CNN** model for the analysis of DNA directly on the FPGA Arty-A7.

---

## ⚙️ System Architecture & Data Flow

BioEdge operates on a highly modular hardware-software co-design. The data flows seamlessly from raw DNA input to a clinical medical verdict:

1. **Input Generation:** Genomic sequence data is fed into the system, representing a patient's DNA mutations.
2. **FPGA Processing (Arty A7):** The custom Multiply-Accumulate (MAC) engine runs the quantized 1D-CNN model directly at the gate level, cross-referencing the DNA stream with hardcoded clinical weights.
3. **Zero-Latency Parallel Bus:** A high-speed data bridge connects the FPGA processor directly to the display unit, ensuring no communication lag.
4. **Actionable Output:** An STM32 microcontroller receives the raw binary risk score and translates it into an intuitive, color-coded dashboard, giving doctors an immediate clinical verdict.

![BioEdge system architecture](BioEdge_Project/docs/images/architeture_diagram.png)

## 📂 Repository Structure

```text
BioEdge/
├── BioEdge_Hardware/              # Main Vivado Workspace
│   ├── BioEdge_Hardware.xpr       # Full Vivado project file
│   ├── BioEdge_Hardware.srcs/     # HDL sources & Verilog constraints
│   └── BioEdge_Hardware.runs/     # Synthesis & Implementation outputs
│
└── BioEdge_Project/               # High-Level Project & Tooling
    ├── data/                      # Local datasets (Excluded from VC via .gitignore)
    ├── docs/                      # Technical reports and images
    ├── hardware/                  
    │   ├── constraints/           # Board constraint files (e.g., arty_a7_35t.xdc)
    │   ├── hdl/                   # Standalone Verilog top-level and submodules
    │   └── tb/                    # Testbench simulation sources
    └── software/                  
        ├── phase1_training.ipynb  # ML Training and Quantization notebooks (1D-CNN)
        └── dashboard.py           # Host-side logic and UI scripts
