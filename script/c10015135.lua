--Mystery Plate Gamma (Skyridge 135/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,nil,1)
	--gain attack (to deck, draw or devolve - to deck)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (to deck, draw or devolve - to deck)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(1-tp)>=5 or Duel.GetPrizeCount(1-tp)==2
end
function scard.devfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEvolved() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.GetPrizeCount(1-tp)>=5 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,6,REASON_EFFECT)
	elseif Duel.GetPrizeCount(1-tp)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEVOLVE)
		local g=Duel.SelectMatchingCard(tp,scard.devfilter,tp,0,LOCATION_INPLAY,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		Duel.Devolve(g,LOCATION_DECK,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
end
