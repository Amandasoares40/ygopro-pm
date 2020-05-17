--Holon Energy WP (Delta Species 106/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_HOLON_ENERGY)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--immune to effects
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT,aux.AttackImmuneOppoFilter,scard.con1(ENERGY_W))
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT_NONDAMAGE,nil,scard.con1(ENERGY_W))
	aux.AddAttachedDescription(c,DESC_IMMUNE_ATTACK_EFFECT_OPPO,scard.con1(ENERGY_W))
	--0 retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_CHANGE_RETREAT_COST,0,scard.con1(ENERGY_P))
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED,scard.con1(ENERGY_P))
end
scard.energy_special=true
--immune to effects, 0 retreat cost
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.con1(energy_type)
	return	function(e)
				local c=e:GetHandler()
				return c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,energy_type) and not c:IsPokemonex()
			end
end
