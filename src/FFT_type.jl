"""
    FFT(frequencies, response)

A type to hold the response and corresponding frequencies of
a discrete fourier transform.
Has the fields `freq` and `resp`, which can be accessed by dot syntax.
Mainly intended to be constructed through [`fft`](@ref).
"""
struct FFT
    freq::Vector{Float64}
    resp::Vector{Complex{Float64}}
end

Base.length(ef::FFT) = length(ef.resp)
Base.getindex(ef::FFT, i) = getindex((ef.freq, ef.resp), i)
Base.firstindex(ef::FFT) = 1
Base.lastindex(ef::FFT) = 2

# Allow (f, r) = fft(...)
Base.iterate(ef::FFT, i=1) = iterate((; freq=ef.freq, resp=ef.resp), i)

function Base.show(io::IO, ef::FFT)
    dominant_frequency_indices = finddomfreq(ef)
    table = Term.Table(
        hcat(
            round.(ef.freq[dominant_frequency_indices], sigdigits=5),
            round.(abs.(ef.resp[dominant_frequency_indices]), sigdigits=5),
        );
        header=["Frequency", "Magnitude"],
    )
    return print(io, "FFT with ", length(ef), " samples.\nDominant component(s):", table)
end

# Convenience functions:
"""
    magnitude(ef::FFT)

The absolute values of the response vector.

See also: [`phase`](@ref), [`phased`](@ref)
"""
magnitude(ef::FFT) = abs.(ef.resp)

"""
    phase(ef::FFT)

The phase of the response vector.

See also: [`magnitude`](@ref), [`phased`](@ref)
"""
phase(ef::FFT) = angle.(ef.resp)

"""
    phased(ef::FFT)

The phase of the response vector in degrees.

See also: [`phase`](@ref), [`magnitude`](@ref)
"""
phased(ef::FFT) = rad2deg.(angle.(ef.resp))
