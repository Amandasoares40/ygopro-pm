--Broken Time-Space (Platinum 104/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--evolve turn played
	aux.EnablePlayerEffectCustom(c,EFFECT_EVOLVE_PLAY_TURN,LOCATION_STADIUM,1,1)
end
--[[
	Rulings
	Q. If the "Broken Time-Space" stadium is in effect, can I evolve a Pokemon on the same turn it comes into play? And
	what if the Pokemon comes into play first, and then I play the stadium?
	A. Whenever "Broken Time-Space" is in play as a stadium you can evolve your Pokemon as much as you like, regardless of
	when it comes into play. (Feb 12, 2009 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#350
]]
