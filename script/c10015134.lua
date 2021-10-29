--Mystery Plate Beta (Skyridge 134/144)
--Note: Untested outside puzzle mode to check if Duel.ConfirmCards causes a crash
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,nil,1)
	--gain attack (draw or to deck)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (draw or to deck)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetPrizeCount(1-tp)>=5 or Duel.GetPrizeCount(1-tp)==1
end
function scard.tdfilter(c)
	return c:IsEnergy() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if Duel.GetPrizeCount(1-tp)>=5 then
		Duel.Draw(tp,3,REASON_EFFECT)
	elseif Duel.GetPrizeCount(1-tp)==1 and tc:IsInPlay() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=tc:GetAttachedGroup():FilterSelect(tp,scard.tdfilter,2,2,nil)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
