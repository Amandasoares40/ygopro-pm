--Darkness Energy (Neo Genesis 104/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_D)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,10,aux.SelfEnergyTypeCondition(ENERGY_D))
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfEnergyTypeCondition(ENERGY_D))
end
scard.energy_special=true
