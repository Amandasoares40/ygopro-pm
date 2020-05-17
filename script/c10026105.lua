--Holon Energy GL (Delta Species 105/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_HOLON_ENERGY)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--immune to special conditions
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_SPECIAL_CONDITION,nil,scard.con1(ENERGY_G))
	aux.AddAttachedDescription(c,DESC_IMMUNE_SPC,scard.con1(ENERGY_G))
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_EX_OLD_AFTER,-10,scard.con1(ENERGY_L))
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,scard.con1(ENERGY_L))
end
scard.energy_special=true
--immune to special conditions, reduce damage
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.con1(energy_type)
	return	function(e)
				local c=e:GetHandler()
				return c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,energy_type) and not c:IsPokemonex()
			end
end
