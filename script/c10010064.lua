--Old Rod (Neo Revelation 64/64)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter1,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to hand
function scard.thfilter1(c)
	return (c:IsBasicPokemon() or c:IsEvolution() or c:IsTrainer()) and c:IsAbleToHand()
end
function scard.thfilter2(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.thfilter3(c)
	return c:IsTrainer() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_TAILS then return end
	local f=(c1+c2==RESULT_HEADS+RESULT_HEADS and scard.thfilter2 or scard.thfilter3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
