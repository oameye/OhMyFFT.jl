function pad_signal(s::AbstractVector{T}, nfft, window) where {T}
    if nfft == length(s) && window === nothing && isa(s, StridedArray)
        input = s # no need to pad
    else
        input = zeros(DSP.fftintype(T), nfft)
        if window !== nothing
            for i in eachindex(s, window)
                @inbounds input[i] = s[i] * window[i]
            end
        else
            copyto!(input, s)
        end
    end
    return input
end
