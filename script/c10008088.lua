--PokeGear (Neo Genesis 88/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand, gain effect
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--to hand, gain effect
function scard.thfilter(c)
	return c:IsTrainer() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,7)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	else
		Duel.ShuffleDeck(tp)
	end
	--cannot play trainer
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(DESC_PLAYER_CANNOT_PLAY_TRAINER)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--cannot play trainer
function scard.val1(e,re,tp)
	return re:IsActiveType(TYPE_TRAINER)
end
