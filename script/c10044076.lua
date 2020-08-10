--Good Rod (Unleashed 76/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.tdfilter1,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to deck
function scard.tdfilter1(c)
	return (c:IsPokemon() or c:IsTrainer()) and c:IsAbleToDeck()
end
function scard.tdfilter2(c)
	return c:IsPokemon() and c:IsAbleToDeck()
end
function scard.tdfilter3(c)
	return c:IsTrainer() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local f=scard.tdfilter2
	if Duel.TossCoin(tp,1)==RESULT_TAILS then f=scard.tdfilter3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. If you have don't have a Pokemon or a Trainer in your discard pile, can you play "Good Rod"?
	A. No. You can't play a trainer or supporter if it's public knowledge that it won't have any game effect. If you have
	at least one Trainer or Pokemon in your discard pile, you can play Good Rod.
	(HS:Unleashed FAQ; May 13, 2010 PUI Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#152
]]
