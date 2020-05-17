--Prism Energy (Next Destinies 93/99)
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
	local tc=c:GetAttachedTarget()
	if tc and tc:IsBasicPokemon() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
