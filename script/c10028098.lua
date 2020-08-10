--Delta Rainbow Energy (Holon Phantoms 98/110)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	local tc=c:GetAttachedTarget()
	if tc and tc:IsSetCard(SETNAME_DELTA) then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
--[[
	Rulings
	Q. When building a deck, are Delta Rainbow Energy and Rainbow Energy considered to be the same card, or 2 different
	cards? Can I put 4 Rainbow Energies AND 4 Delta Rainbow Energies in the same deck?
	A. They are considered to be different cards; you may have up to 4 of each of them in your deck.
	(May 25, 2006 PUI Rules Team)
	https://compendium.pokegym.net/compendium-ex.html#ecards
]]
