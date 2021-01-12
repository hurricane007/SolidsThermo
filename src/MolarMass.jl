function Mm(subName::String)
    try
        return molarMassData[subName]
    catch
        println("Cannot fin $subName")
    end
end

function Mm()
    println(keys(molarMassData))
end
