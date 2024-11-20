"""
fft(s)     -> FFT
fft(s, fs) -> FFT

Compute the Discrete Fourier Transform (DFT) of the
input vector `s`, scaling by `1/length(s)` by default.
This function uses FFTW.rfft if `s` has real elements,
and FFTW.fft otherwise.

Note that if `s` has real elements, the one-side spectrum
is returned. This means that the amplitude of the frequencies
is doubled, excluding the frequency=0 component. To get the full symmetric spectrum for real signals, use [`mirror`](@ref), or change the element type of the signal by something like `fft(signal.|>ComplexF64)`.

The output is an `FFT` object, with fields `freq` and `resp` containing the frequences and
response respectivly.

# Keyword arguments

  - `scalebylength::Bool`: determines if the response is scaled by its length. Defaults to `true`.

# Examples

```jldoctest
julia> using OhMyFFT

julia> fs = 100;  # 100 samples per second

julia> timestamps = range(0, 1; step=1 / fs);

julia> s = sin.(2π * 2 * timestamps); # sine of frequency = 2 Hz

julia> fft(s, fs)
FFT with 51 samples.
Dominant component(s):
Frequency  │  Magnitude
╺━━━━━━━━━━━━━┿━━━━━━━━━━━━━╸
1.9802    │   0.98461

julia> fft(s)  # `fs` defaults to 1
FFT with 51 samples.
Dominant component(s):
Frequency  │  Magnitude
╺━━━━━━━━━━━━━┿━━━━━━━━━━━━━╸
0.019802   │   0.98461
          ╵
```
"""
function fft(
    s::AbstractVector{T},
    fs::Real=1.0;
    onesided::Bool=T <: Real,
    scalebylength=true,
    nfft::Int=nextfastfft(length(s)),
    window::Union{Function,AbstractVector,Nothing}=nothing,
) where {T<:Number}
    (onesided && T <: Complex) &&
        throw(ArgumentError("cannot compute one-sided FFT of a complex signal"))
    nfft >= length(s) ||
        throw(DomainError((; nfft, n=length(s)), "nfft must be >= n = length(s)"))

    w, norm2 = DSP.Periodograms.compute_window(window, length(s))
    input = pad_signal(s, nfft, w)

    resp = T <: Real ? FFTW.rfft(input) : FFTW.fft(input)
    if !isnothing(w)
        resp .*= nfft / sum(w)
    end

    resp[1] /= 2
    resp .*= 2
    if scalebylength
        resp ./= nfft
    end

    freq = onesided ? FFTW.rfftfreq(nfft, fs) : FFTW.fftfreq(nfft, fs)
    return FFT(freq, resp)
end
