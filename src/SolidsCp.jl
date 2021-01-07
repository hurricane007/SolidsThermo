# return the heat capacity of substance, kJ/mol*K
function SolidsCp(subName::String, Temp::Real)
    try
        Trange, coeff = solidEnthalpyData[subName]
        if Temp > Trange[end] || Temp < Trange[1]
            printstyled(color=:red,
                @sprintf("%4.4f K is out of range, %4.2f K - %4.2f K \n",
                Temp, Trange[1], Trange[end]))
            return NaN
        else
            T = Temp*1E-3
            loc = findlast(x -> x<=Temp, Trange)
            return sum( [1, T, T^2, T^3, 1/T^2, 0, 0, 0] .* coeff[loc,:])*1E-3
        end
    catch
        printstyled(color=:red,@sprintf("%s not found in database.\n",subName))
        return NaN
    end
end

function SolidsCp()
    println(keys(solidEnthalpyData))
end
