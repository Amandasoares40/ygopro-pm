--Mystery Plate Delta (Skyridge 136/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,nil,1)
	--gain attack (search - to hand or remove counter)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (search - to hand or remove counter)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(1-tp)>=5 or Duel.GetPrizeCount(1-tp)==2
end
function scard.thfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.GetPrizeCount(1-tp)>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,3,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		else
			Duel.ShuffleDeck(tp)
		end
	elseif Duel.GetPrizeCount(1-tp)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
		local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,LOCATION_INPLAY,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		tc:RemoveCounter(tp,COUNTER_DAMAGE,tc:GetCounter(COUNTER_DAMAGE),REASON_EFFECT)
	end
end
