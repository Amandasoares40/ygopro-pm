--Weakness Guard Energy (Unified Minds 213/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS)
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS)
end
scard.energy_special=true
