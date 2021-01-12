module pureSubstanceThermo
    import Printf.@sprintf
    include("data.jl")
    include("SolidsEnthalpy.jl")
    include("SolidsCp.jl")
    include("SolidsEntropy.jl")
    include("GasThermo.jl")
    include("MolarMass.jl")
end  # module SolidsThermo
