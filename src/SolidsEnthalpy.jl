include("data.jl")
function SolidsEnthalpy(subName::String, Temp::Real)
    try
        Trange, value = solidEnthalpyData[subName]
        if Temp > maximum(Trange) || Temp < minimum(Trange)
            printstyled(color=:red, @sprintf("%4.4f K is out of range, %4.4f K -
            %4.4f K \n", T, minimum(Trange), maximum(Trange)))
            return NaN
        else
            loc = findfirst(x -> x> Temp, Trange)
            return (Temp -Trange[loc-1])*(value[loc] -value[loc-1])/
                (Trange[loc] - Trange[loc-1]) + value[loc-1]
        end
    catch
        printstyled(color=:red,@sprintf("%s not found in database.\n",subName))
        return NaN
    end
end

function SolidsEnthalpy()
    println(keys(solidEnthalpyData))
end
