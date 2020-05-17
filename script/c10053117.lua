--Blend Energy GRPD (Dragons Exalted 117/124)
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
		return ENERGY_C+ENERGY_G+ENERGY_R+ENERGY_P+ENERGY_D
	else
		return ENERGY_C
	end
end
