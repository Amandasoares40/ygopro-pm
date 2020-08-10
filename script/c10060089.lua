--Fiery Torch (Flashfire 89/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2),nil,aux.DiscardHandCost(1,1,Card.IsEnergy,ENERGY_R))
end
scard.trainer_item=true
--[[
	Rulings
	Q. Can you play Professor Juniper or Fiery Torch, or any draw Trainer, with no cards in your deck?
	A. No, you cannot play a Trainer when it is known that it will have no effect. (Nov 13, 2014 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#c6
]]
