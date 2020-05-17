--Super Boost Energy Prism Star (Ultra Prism 136/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1,scard.val2)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	local tc=c:GetAttachedTarget()
	if tc and tc:IsStage2() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
function scard.val2(e,c)
	local tc=c:GetAttachedTarget()
	if tc and tc:IsStage2() and Duel.GetInPlayPokemon(e:GetHandlerPlayer()):IsExists(Card.IsStage2,3,nil) then
		return 4
	else
		return 1
	end
end
--[[
	Rulings
		Q. If I have 3 or more Stage 2 Pokemon in play, can I attach Super Boost Energy {*} to any of my Pokemon
		(regardless if it's Stage 2 or not) and get the 4-Energy effect?
		A. No, you only get the multiple energy and rainbow effects when it's attached to a Stage 2 Pokemon.
		(Feb 8, 2018 TPCi Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#568
]]
