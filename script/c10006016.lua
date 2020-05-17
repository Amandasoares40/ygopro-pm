--Erika (Gym Heroes 16/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ERIKA)
	--draw
	aux.PlayTrainerFunction(c,aux.OR(aux.DrawTarget(PLAYER_SELF),aux.DrawTarget(PLAYER_OPPO)),scard.op1)
end
scard.trainer_item=true
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DrawUpTo(tp,3,REASON_EFFECT)
	Duel.DrawUpTo(1-tp,3,REASON_EFFECT)
end
--[[
	Rulings
		Q. For Erika, does your opponent have to take cards?
		A. Nope, they may [or may not]. (Nov 30, 2000 WotC Chat, Q147)
		http://compendium.pokegym.net/compendium.html#trainers
]]
