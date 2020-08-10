--Sophocles (Burning Shadows 123/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,4),nil,aux.DiscardHandCost(2))
end
scard.trainer_supporter=true
--[[
	Rulings
	Q. Can I play Sophocles and discard two cards if there are no cards left in my deck?
	A. No, you cannot. Discarding the two cards is a cost not the effect, and you cannot play Trainer cards for no effect.
	(Mar 21, 2019 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#654
]]
