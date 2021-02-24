function AR_exit_T(MeName::String, MeOName::String, MeOFrac::Real, NMe::Real, NMeO::Real,
    InertName::String, Ts_in::Real, Tg_in = 300::Real)
    if MeOFrac > 1
        println("The metal fraction ($MeOFrac) must be smaller than 1! ")
    else
        # mole of metal and inert
        M_Me = 1000*MeOFrac/Mm(MeOName)*NMe/NMeO
        M_inert = 1000*(1 - MeOFrac)/Mm(InertName)
        # calculate needed air
        M_O2 = M_Me/NMe/0.95 # consider 95% O2 conversion
        M_N2 = M_O2*0.79/0.21
        #
        Hinlet = M_O2*GasEnthalpy("O2", Tg_in) + M_N2*GasEnthalpy("N2", Tg_in) +
        M_Me*SolidsEnthalpy(MeName, Ts_in) + M_inert*SolidsEnthalpy(InertName, Ts_in)
        T_exit = Ts_in # initial exit temperature
        ΔT = 1.0
        while abs(ΔT) > 0.1
            dH = Hinlet - (M_Me/NMe*NMeO*SolidsEnthalpy(MeOName, T_exit) +
            M_inert*SolidsEnthalpy(InertName, T_exit) +
            M_O2*0.05*GasEnthalpy("O2", T_exit) +
            M_N2*GasEnthalpy("N2", T_exit))
            if isnan(dH)
                println("error during calculation")
                return NaN
            end
            ΔT = dH/(M_Me/NMe*NMeO*SolidsCp(MeOName, T_exit) +
            M_inert*SolidsCp(InertName, T_exit) +
            M_O2*0.05*GasCp("O2", T_exit) +
            M_N2*GasCp("N2", T_exit) )

            T_exit = T_exit + ΔT
        end
        return T_exit
    end
end
