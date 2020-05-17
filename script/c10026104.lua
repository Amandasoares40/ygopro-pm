--Holon Energy FF (Delta Species 104/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_HOLON_ENERGY)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS,nil,scard.con1(ENERGY_R))
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS,scard.con1(ENERGY_R))
	--ignore resistance
	aux.AddSingleAttachedEffect(c,EFFECT_IGNORE_RESISTANCE,nil,scard.con1(ENERGY_F))
	aux.AddAttachedDescription(c,DESC_IGNORE_RESISTANCE,scard.con1(ENERGY_F))
end
scard.energy_special=true
--no weakness, ignore resistance
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.con1(energy_type)
	return	function(e)
				local c=e:GetHandler()
				return c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,energy_type) and not c:IsPokemonex()
			end
end
