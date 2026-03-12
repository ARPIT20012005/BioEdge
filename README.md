# BioEdge 1.0: Hardware-Accelerated Genomic Diagnostics at the Edge

![Hardware](https://img.shields.io/badge/Hardware-Arty_A7_35T-blue?style=flat-square)
![FPGA](https://img.shields.io/badge/FPGA-Xilinx_Vivado-red?style=flat-square)
![Software](https://img.shields.io/badge/Software-Python_3.8+-yellow?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**BioEdge** is a custom-engineered, fully offline diagnostic system that bridges the gap between complex bioinformatics and point-of-care medical hardware. By hardwiring a 1D-CNN risk-scoring algorithm directly into custom FPGA silicon, BioEdge bypasses traditional CPU bottlenecks to deliver real-time, zero-latency DNA mutation analysis.

![BioEdge prototype hardware](BioEdge_Project/docs/images/bioedge_hardware_setup.jpg)


---

## 🧬 The Problem & Our Solution

### The Clinical Challenge
Every day, DNA mutations occur in the human body. While many are benign, specific pathogenic mutations can trigger severe diseases like cancer. Currently, hospitals rely on cloud-based bioinformatics pipelines to sequence and analyze these mutations. This approach creates two major problems:
1. **Severe Time Delays:** Traditional software processing takes weeks, delaying life-saving treatments.
2. **Data Privacy Risks:** Uploading highly sensitive patient genomic data to cloud servers exposes hospitals to massive cybersecurity and HIPAA compliance risks.

### The BioEdge Solution
BioEdge solves this by moving the entire diagnostic pipeline to the **"Edge"**. 
Instead of sending data to the cloud, BioEdge uses a custom-built hardware accelerator (FPGA) paired with a local microcontroller (STM32) to process genomic data right at the doctor's desk. It achieves 100% offline patient privacy while slashing diagnostic wait times from weeks to milliseconds.

---

## ⚙️ System Architecture & Data Flow

BioEdge operates on a highly modular hardware-software co-design. The data flows seamlessly from raw DNA input to a clinical medical verdict:

1. **Input Generation (The DNA Stream):** Genomic sequence data (A, C, T, G base pairs) is fed into the system, representing a patient's DNA mutations.
2. **FPGA Processing (Arty A7-35T):** The "brain" of the system. We engineered a custom **Multiply-Accumulate (MAC) engine** in Verilog. This engine runs a quantized **1D-CNN Artificial Intelligence model** directly at the gate level, cross-referencing the DNA stream with hardcoded clinical weights (ClinVar) to calculate a Polygenic Risk Score instantly.
3. **Zero-Latency Parallel Bus:** A custom-engineered, high-speed data bridge connects the FPGA processor directly to the display unit, ensuring no communication lag.
4. **Actionable Output (STM32 Interface):** An STM32 microcontroller receives the raw binary risk score and translates it into an intuitive, color-coded TouchGFX dashboard. This gives doctors an immediate Low, Medium, or High-risk clinical verdict at the bedside.
![BioEdge system architecture](BioEdge_Project/docs/images/architeture_diagram.png)

---

## 📂 Repository Structure

The workspace is cleanly divided into hardware design, software tooling, and documentation.

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
