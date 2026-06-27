# FIR Low-Pass Filtering for Noisy Measurement Data

This project was completed for the AEE 323 Engineering Experimentation and Data Analysis course. The objective of the project is to apply a low-pass filter to noisy measurement data, analyze the signal in both time and frequency domains, and compare the filtered signal with the original noise-free reference signal.

The dataset consists of three main variables: time, measurement data with noise, and original data without noise. First, the original and measured signals were compared in the time domain. Then, frequency-domain analysis was performed using FFT to identify the dominant frequency components and determine suitable filter parameters.

A Finite Impulse Response (FIR) low-pass filter was designed with appropriate selections of cut-off frequency, transition width, and filter order. The filter was applied to the noisy measurement signal using MATLAB. After filtering, the filtered signal was compared with the original signal. In addition, inverse Fourier transform was applied to the filtered data and compared with the original data.

## Key Topics

* Signal processing
* Sampling frequency
* Nyquist theorem and aliasing
* FFT and frequency-domain analysis
* FIR low-pass filter design
* Cut-off frequency selection
* Filter order and transition width
* Low-pass filtering
* Noise reduction
* Inverse Fourier transform
* MATLAB data analysis

## Repository Structure

* `src/` contains the MATLAB implementation.
* `data/` contains the group data file used in the project.
* `report/` contains the final project report.
* `figures/` contains the generated MATLAB plots in `.png` and `.fig` formats.

## Tools

* MATLAB
* LaTeX

## Note

This project was completed as a group project. I was mainly responsible for the MATLAB code implementation, including FFT-based frequency-domain analysis, FIR low-pass filter design, filter parameter selection, filtering process, and comparison of the filtered signal with the original reference signal.
