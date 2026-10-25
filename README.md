<div align="center">

# 📡 DWT-OFDM Based Image Transmission System

### Image Transmission Using Discrete Wavelet Transform and Orthogonal Frequency Division Multiplexing

A MATLAB simulation project for transmitting a grayscale image through a noisy communication channel, reconstructing the received image, and evaluating image quality.

[![MATLAB](https://img.shields.io/badge/MATLAB-Simulation-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Signal Processing](https://img.shields.io/badge/Signal%20Processing-Digital%20Communication-6C5CE7?style=for-the-badge)](https://en.wikipedia.org/wiki/Digital_signal_processing)
[![Wavelets](https://img.shields.io/badge/Transform-Discrete%20Wavelet-00B894?style=for-the-badge)](https://en.wikipedia.org/wiki/Discrete_wavelet_transform)
[![Status](https://img.shields.io/badge/Project-Academic%20Simulation-FF9F43?style=for-the-badge)](https://github.com/tharungutta/Major_Project)

</div>

---

## 📌 About the Project

**DWT-OFDM Based Image Transmission System** explores digital image transmission using signal-processing techniques. The MATLAB graphical interface lets a user load an image, process it through a transmitter stage, introduce channel noise, reconstruct the received image, and inspect image-quality measurements.

The repository's MATLAB implementation demonstrates image loading and grayscale conversion, QPSK modulation, Haar wavelet decomposition, an additive white Gaussian noise (AWGN) channel, receiver-side reconstruction, and image-quality evaluation using Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR).

> **Implementation note:** The current `main_code.m` implements a DWT-based image transmission simulation and channel equalization workflow. Although the project title refers to OFDM, the published code should be reviewed before describing it as a complete OFDM implementation with subcarrier mapping, IFFT/FFT, cyclic prefix, and explicit channel estimation.

## 🎯 Objectives

- Simulate the transmission of image data through a communication channel.
- Convert image pixels into a binary data stream.
- Apply QPSK modulation to represent data as complex symbols.
- Explore Haar Discrete Wavelet Transform (DWT) decomposition in the transmitter and inverse DWT at the receiver.
- Add AWGN to simulate channel noise.
- Reconstruct the received image and compare it with the original.
- Calculate MSE and PSNR as image-quality indicators.
- Visualize the original image, transmitter output, channel output, received image, and a performance graph in a MATLAB GUI.

## 🧠 Concepts Used

### 1. Image preprocessing
The selected image is loaded using MATLAB's image functions. RGB images are converted to grayscale, and the image is resized to 128 × 128 pixels for the simulation.

### 2. Binary conversion and modulation
Pixel values are converted into bits. The code groups bits into pairs and uses QPSK modulation with a phase offset of π/4 to produce modulation symbols.

### 3. Haar Discrete Wavelet Transform
The transmitter applies a Haar wavelet decomposition to blocks of the real part of the modulated symbols. The approximation and detail coefficients are arranged into a transmitted sequence.

### 4. Noisy communication channel
The simulation adds Additive White Gaussian Noise (AWGN) at a configured SNR of 20 dB. A simple coefficient-based correction is then applied to the noisy sequence.

### 5. Receiver and image reconstruction
The receiver groups the sequence into blocks, applies inverse Haar wavelet reconstruction, demodulates the symbols, converts the recovered bits back into pixel values, and displays the reconstructed image.

### 6. Image-quality evaluation
The application calculates:
- **MSE (Mean Squared Error):** Measures the average squared difference between original and reconstructed pixel values. Lower values indicate less pixel error.
- **PSNR (Peak Signal-to-Noise Ratio):** Expresses reconstruction quality in decibels. Higher values generally indicate less visible distortion for the same image representation.

The GUI also plots a PSNR-related graph against a range of SNR values. The current graph code adds AWGN directly to the image for this comparison, so it should be interpreted as an illustrative image-noise curve rather than a full end-to-end DWT-OFDM link performance evaluation.

## ✨ Application Features

- 🖼️ Load JPG, PNG, and TIFF images.
- ⚫ Convert RGB images to grayscale.
- 📐 Resize the input image to 128 × 128 pixels.
- 📡 Run the transmitter processing stage.
- 🌊 Apply Haar wavelet decomposition.
- 📶 Simulate an AWGN channel.
- 🔄 Reconstruct the image at the receiver.
- 📊 Display MSE and PSNR values.
- 📈 Plot an image-quality performance graph.
- 🖥️ Use a MATLAB graphical interface with separate panels for the original image, transmitter output, channel output, received image, and performance graph.

## 🔄 System Workflow

```text
Input Image
    |
    v
Image Loading and Preprocessing
(Grayscale Conversion, 128 x 128 Resize)
    |
    v
Pixel-to-Bit Conversion
    |
    v
QPSK Modulation
    |
    v
Haar DWT Processing
    |
    v
AWGN Channel (configured SNR)
    |
    v
Receiver-Side Correction
    |
    v
Inverse Haar DWT
    |
    v
QPSK Demodulation
    |
    v
Bit-to-Pixel Conversion
    |
    v
Reconstructed Image
    |
    v
MSE / PSNR Evaluation
```

## 🛠️ Tools and Requirements

- **MATLAB**
- **Image Processing Toolbox** functions such as `imread`, `imshow`, `imresize`, `immse`, and `psnr`
- **Communications Toolbox** functions such as `pskmod`, `pskdemod`, and `awgn`
- **Wavelet Toolbox** functions such as `dwt` and `idwt`
- `de2bi` and `bi2de` functions available in supported MATLAB toolbox environments

Exact toolbox availability and function compatibility depend on your MATLAB release. If MATLAB reports that a function is undefined, check the installed toolboxes and the function's availability in your version.

## 🚀 How to Run

### 1. Clone the repository

```bash
git clone https://github.com/tharungutta/Major_Project.git
cd Major_Project
```

### 2. Open MATLAB

Open MATLAB and set the Current Folder to the cloned repository directory.

### 3. Run the MATLAB function

In the MATLAB Command Window, run:

```matlab
main_code
```

The GUI should open.

### 4. Follow the application steps

1. Select **Load Image** and choose a JPG, PNG, or TIFF image.
2. Select **Transmitter** to process the image data.
3. Select **Channel** to add noise and apply the code's correction step.
4. Select **Receiver** to reconstruct and display the received image.
5. Select **Performance** to display MSE, PSNR, and the performance graph.

Run the stages in order because later stages use data produced by earlier stages.

## 📁 Repository Contents

The repository includes the MATLAB source code, project abstract and base-paper materials, presentation and report documents, and project-related images/certificates.

| File or folder | Purpose |
|---|---|
| `main_code.m` | MATLAB GUI and image-transmission simulation |
| `ABSTRACT-.../` | Project abstract material |
| `BASE PAPER-.../` | Reference paper material |
| `BATCH 10 MAJOR PROJECT PPT.pptx` | Project presentation |
| `BATCH 10 MAJOR PROJECT REPORT.docx` | Project report |
| `THE ONLY final project report dec, ackn. (2).pdf` | Additional report document |
| Image files | Project figures, screenshots, or supporting material |

Names above reflect the repository listing; exact folder contents may change.

## 📈 Understanding the Results

- **Original Image:** The preprocessed input image.
- **Transmitter Output:** A plotted portion of the transmitter's DWT coefficient sequence.
- **Channel Output:** A plotted portion of the sequence after noise is added.
- **Received Image:** The image reconstructed by the receiver pipeline.
- **MSE and PSNR:** Numerical indicators comparing the original and reconstructed images.
- **Performance Graph:** A plotted relationship between configured SNR points and calculated PSNR values for the image-noise illustration in the current code.

For a rigorous experiment, test multiple SNR values through the complete transmit/channel/receive pipeline and record PSNR, MSE, and preferably BER. Ensure the receiver reverses the transmitter's exact bit ordering, padding, modulation, and transform operations.

## ⚠️ Current Implementation Notes

This repository is an academic simulation. Before using the results for a formal research comparison, review and validate the implementation details:

- The transmitter currently applies DWT to the real part of the QPSK symbols; this is not by itself a complete OFDM modulator.
- The receiver and transmitter block sizes, padding, coefficient arrangement, and inverse-transform inputs should be validated together.
- The current correction step uses a mean ratio between noisy and transmitted coefficients; it is a simplified correction model, not a general channel estimator.
- The displayed performance curve adds noise directly to the image rather than rerunning the full transmission chain for each SNR.
- Validate numerical results with repeatable test images and documented parameters before drawing performance conclusions.

These notes are intended to make the project's documentation technically precise and help guide future improvements.

## 🔮 Future Enhancements

- Implement complete OFDM processing with subcarrier mapping, IFFT/FFT, and cyclic prefix handling.
- Add explicit channel models and robust channel estimation/equalization.
- Compare DWT-OFDM with conventional FFT-based OFDM.
- Evaluate BER, MSE, and PSNR across multiple SNR values.
- Add support for color images and different image sizes.
- Export plots and numerical results for reports.
- Improve input validation and stage-by-stage error messages.
- Add automated experiments across several test images and channel conditions.

## 🎓 Academic Context

This project demonstrates concepts from digital communication, image processing, modulation, wavelet transforms, noisy-channel simulation, and objective image-quality measurement. It can serve as a starting point for further research and experimentation in image transmission systems.

## 👤 Author and Repository

**Author:** Tharun Gutta

- **GitHub:** [@tharungutta](https://github.com/tharungutta)
- **Repository:** [Major_Project](https://github.com/tharungutta/Major_Project)

## 📚 References

- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [Communications Toolbox Documentation](https://www.mathworks.com/help/comm/)
- [Wavelet Toolbox Documentation](https://www.mathworks.com/help/wavelet/)
- [Image Processing Toolbox Documentation](https://www.mathworks.com/help/images/)

---

<div align="center">

### 💙 Built with MATLAB and signal-processing concepts

*Explore, simulate, measure, and improve image transmission.*

</div>
