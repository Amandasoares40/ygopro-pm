--Upper Energy (Rising Rivals 102/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1,scard.val2)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	local tp=e:GetHandlerPlayer()
	local tc=c:GetAttachedTarget()
	if Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) and tc and not tc:IsPokemonLVX() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
function scard.val2(e,c)
	local tp=e:GetHandlerPlayer()
	local tc=c:GetAttachedTarget()
	if Duel.GetPrizeCount(tp)>Duel.GetPrizeCount(1-tp) and tc and not tc:IsPokemonLVX() then
		return 2
	else
		return 1
	end
end
