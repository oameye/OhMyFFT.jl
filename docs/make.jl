CI = get(ENV, "CI", nothing) == "true" || get(ENV, "GITHUB_TOKEN", nothing) !== nothing

using OhMyFFT
using Documenter
using DocumenterVitepress
using DocumenterCitations

DocMeta.setdocmeta!(OhMyFFT, :DocTestSetup, :(using OhMyFFT); recursive=true)

# using Downloads: Downloads
# Downloads.download(
#   "https://raw.githubusercontent.com/oameye/OhMyFFT.jl/master/README.md",
#   joinpath(@__DIR__, "src/index.md"),
# )

bib = CitationBibliography(
    joinpath(@__DIR__, "src", "refs.bib");
    style=:numeric,  # default
)

makedocs(;
    modules=[OhMyFFT],
    repo=Remotes.GitHub("oameye", "OhMyFFT.jl"),
    authors="Orjan Ameye <orjan.ameye@hotmail.com>",
    sitename="OhMyFFT.jl",
    format=DocumenterVitepress.MarkdownVitepress(;
        repo="github.com/oameye/OhMyFFT.jl", devbranch="master", devurl="dev"
    ),
    pages=["Home" => "index.md", "API" => "API.md"],
    plugins=[bib],
)

if CI
    deploydocs(;
        repo="github.com/oameye/OhMyFFT.jl",
        devbranch="master",
        target="build",
        branch="gh-pages",
        push_preview=true,
    )
end
