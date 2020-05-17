--Double Rainbow Energy (Team Magma vs Team Aqua 88/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,scard.energyfilter)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_ALL,2,aux.FilterBoolFunction(Card.IsInPlay))
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_OPPO_BEFORE,-10,scard.con1)
	aux.AddAttachedDescription(c,DESC_DO_LESS_DAMAGE,scard.con1)
end
scard.energy_special=true
--energy
function scard.energyfilter(c)
	return c:IsEvolved() and not c:IsPokemonex()
end
--reduce damage
function scard.con1(e)
	return scard.energyfilter(e:GetHandler())
end
