--Unit Energy LPM (Ultra Prism 138/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	if c:GetAttachedTarget() then
		return ENERGY_C+ENERGY_L+ENERGY_P+ENERGY_M
	else
		return ENERGY_C
	end
end
