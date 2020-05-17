--Engineer's Adjustments (Unleashed 75/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,4),nil,aux.DiscardHandCost(1,1,Card.IsEnergy))
end
scard.trainer_supporter=true
--[[
	Rulings
		Q. If I don't discard an energy, can I play "Engineer's Adjustments"?
		A. No. You must be able to discard an energy to play the card. (HS:Unleashed FAQ; May 13, 2010 PUI Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#147
]]
