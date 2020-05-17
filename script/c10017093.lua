--Multi Energy (Sandstorm 93/100)
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
	if not tc then return false end
	local g=tc:GetAttachedGroup()
	if g:FilterCount(Card.IsSpecialEnergy,nil)==1 then
		return ENERGY_ALL
	elseif g:FilterCount(Card.IsSpecialEnergy,nil)>1 then
		return ENERGY_C
	end
end
--[[
	Rulings
		Q. The wording for Multi Energy is a bit confusing; does it mean that if I have Multi Energy already attached, and
		then I attach a special energy card, does the "rainbow effect" of Multi Energy disappear at that time?
		A. Yes. Multi Energy provides colorless energy when any other Special Energy card is present on the Pokémon
		(Sep 11, 2003 PUI Rules Team)
		http://compendium.pokegym.net/compendium-ex.html#ecards
]]
