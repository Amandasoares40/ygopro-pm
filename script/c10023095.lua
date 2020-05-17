--Scramble Energy (Deoxys 95/107)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,scard.energyfilter)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1,scard.val2)
end
scard.energy_special=true
--energy
function scard.energyfilter(c)
	return c:IsEvolved() and not c:IsPokemonex()
end
--provide energy
function scard.val1(e,c)
	local tp=e:GetHandlerPlayer()
	if Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) and c:GetAttachedTarget() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
function scard.val2(e,c)
	local tp=e:GetHandlerPlayer()
	if Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) and c:GetAttachedTarget() then
		return 3
	else
		return 1
	end
end
