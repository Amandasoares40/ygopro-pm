--Blaine's Last Resort (Gym Heroes 105/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--confirm hand, draw
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(nil,LOCATION_HAND,0,1,c),scard.op1)
end
scard.trainer_item=true
--confirm hand, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
end
--[[
	Rulings
		Q. Can you play Blaine's Last Resort if you have another Blaine's Last Resort in your Hand? Cause Since it says
		you can't use it if you have no cards in your hand other than "Blaine's Last Resort" and the one in your hand
		simply bypasses it. If not, why do you have to state to show your hand when you don't have any cards in your hand
		when you play it?
		A. Yes you can play Blaine's Last Resort if you have another in your hand. (August 17, 2000 WotC Chat Q94)
		http://compendium.pokegym.net/compendium.html#trainers
]]
