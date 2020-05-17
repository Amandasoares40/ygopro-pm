--Holon Lass (Delta Species 92/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--to hand
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,nil,aux.DiscardHandCost(1))
end
scard.trainer_supporter=true
--to hand
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetPrizeCount()>0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.thfilter(c)
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetPrizeCount()
	if ct1==0 or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,ct1)
	Duel.ConfirmCards(tp,g)
	local ct2=g:FilterCount(scard.thfilter,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,ct2,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	else
		Duel.ShuffleDeck(tp)
	end
end
