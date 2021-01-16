function Mm(subName::String)
    try
        return molarMassData[subName]
    catch
        println("Cannot find $subName")
    end
end

function Mm()
    println(keys(molarMassData))
end
