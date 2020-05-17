--Mystery Plate Alpha (Skyridge 133/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,nil,1)
	--gain attack (search - to hand or burned, paralyzed, poisoned)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (search - to hand or burned, paralyzed, poisoned)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(1-tp)>=5 or Duel.GetPrizeCount(1-tp)==1
end
function scard.thfilter(c)
	return c:IsTrainer() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if Duel.GetPrizeCount(1-tp)>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		else
			Duel.ShuffleDeck(tp)
		end
	elseif Duel.GetPrizeCount(1-tp)==1 and tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_BURNED+SPC_PARALYZED+SPC_POISONED)
	end
end
