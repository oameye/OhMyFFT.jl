
<div align="center">

# OhMyFFT.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://oameye.github.io/OhMyFFT.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://oameye.github.io/OhMyFFT.jl/dev/)
[![Build Status](https://github.com/oameye/OhMyFFT.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/oameye/OhMyFFT.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)


[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![JET](https://img.shields.io/badge/%E2%9C%88%EF%B8%8F%20tested%20with%20-%20JET.jl%20-%20red)](https://github.com/aviatesk/JET.jl)
[![DispatchDoctor](https://img.shields.io/badge/%F0%9F%A9%BA_tested_with-DispatchDoctor.jl-blue?labelColor=white)](https://github.com/MilesCranmer/DispatchDoctor.jl)

</div>

---

This package is an opinionated layer on top of [FFTW.jl](https://github.com/JuliaMath/FFTW.jl).
It is a fork of [EasyFFTW.jl](https://github.com/KronosTheLate/EasyFFTs.jl).
The main difference is that `OhMyFFT.jl` also imports DSP to provide windows and zero padding.

## Usage

To use `OhMyFFT.jl`, first install the package by adding it to your Julia environment:

```julia
] add https://github.com/oameye/OhMyFFT.jl
```

Then, you can load the package and use it as follows:
```julia
using OhMyFFT
```

