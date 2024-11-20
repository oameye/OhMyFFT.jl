module OhMyFFT

using FFTW: FFTW
using DSP: DSP, nextfastfft
using RecipesBase: @recipe, @series
using Term
using Peaks

using DispatchDoctor: @stable
@stable default_mode = "disable" begin # enforces type_stability
    include("FFT_type.jl")
    include("plotting.jl")
    include("utils.jl")
    include("fft_utils.jl")
    include("fft.jl")
end # @stable

export magnitude, phased, phase, magnitude, fft
export response_at, FFT, fft, mirror, finddomfreq, domfreq
end
