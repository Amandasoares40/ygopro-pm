--Shield Energy (Primal Clash 143/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_M))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_M,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_M))
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_BEFORE,-10,aux.SelfEnergyTypeCondition(ENERGY_M))
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,aux.SelfEnergyTypeCondition(ENERGY_M))
end
scard.energy_special=true
