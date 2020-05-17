--Metal Energy (Neo Genesis 19/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_M)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_AFTER,-10,aux.SelfEnergyTypeCondition(ENERGY_M))
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,aux.SelfEnergyTypeCondition(ENERGY_M))
end
scard.energy_special=true
