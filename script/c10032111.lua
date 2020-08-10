--Pokedex Handy910is (Diamond & Pearl 111/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct<=0 then return end
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg1=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	if sg1:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		g:Sub(sg1)
	end
	if ct<=1 then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKBOT)
		local sg2=g:Select(tp,1,1,nil)
		Duel.MoveSequence(sg2:GetFirst(),SEQ_DECK_BOTTOM)
	else
		Duel.MoveSequence(g:GetFirst(),SEQ_DECK_BOTTOM)
	end
end
--[[
	Rulings
	Q. Can you use "Pokedex HANDY910is" if there's only 1 card left in your deck?
	A. Yes, you can. It says to draw two cards, but you do as much as you can since you only have one card in your deck.
	Then, you choose one to keep, so you keep the one you drew. Now, you're supposed to put the other card back, but since
	there is no other card you simply don't put anything back. (Jan 15, 2009 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#353
]]
