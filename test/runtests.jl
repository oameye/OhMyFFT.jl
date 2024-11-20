using Test
using OhMyFFT, DSP

@testset "Code quality" begin
    using ExplicitImports, Aqua
    ignore_deps = [:Random, :Printf, :Test, :Pkg]

    @test check_no_stale_explicit_imports(OhMyFFT) == nothing
    @test check_all_explicit_imports_via_owners(OhMyFFT) == nothing
    Aqua.test_ambiguities(OhMyFFT)
    Aqua.test_all(
        OhMyFFT;
        deps_compat = (ignore=ignore_deps, check_extras=(ignore=ignore_deps,), check_weakdeps=(ignore=ignore_deps,)),
        piracies    = (treat_as_own=[],),
        ambiguities = false,
    )
end

@testset "Code linting" begin
    using JET
    JET.test_package(OhMyFFT; target_defined_modules=true)
end

using Preferences: set_preferences!
set_preferences!("OhMyFFT", "instability_check" => "warn")

fs = 25;
duration = 100_000;
timestamps = range(0, duration, step=1 / fs);
f1 = 5.0 ; A1 = 2.0;
f2 = 10.0; A2 = 3.0;
s = @. A1 * sin(f1 * 2π * timestamps) + A2 * sin(f2 * 2π * timestamps);

@testset "correctness" begin
    ef = fft(s, fs, window=DSP.hanning)
    peaks = finddomfreq(ef)
    freq, resp = response_at(ef, [f2, f1])
    @test domfreq(ef) == [f2, f1]
    @test abs.(ef.resp[peaks]) ≈ [A2, A1] atol= 1e-5
end

@testset "response_at vs finddomfreq" begin
    ef = fft(s, fs, window=DSP.hanning)
    peaks = finddomfreq(ef)
    freq, resp = response_at(ef, [f2, f1])
    @test abs.(ef.resp[peaks]) == abs.(resp)
end
@testset begin
    ef = fft(s, fs, window=DSP.hanning)
    @test magnitude(ef) == abs.(ef.resp)
    @test phase(ef) == angle.(ef.resp)
    @test phased(ef) == rad2deg.(angle.(ef.resp))
end
