--Miracle Sphere Beta (Skyridge 130/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack (damage, to deck)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and c:IsEnergyType(ENERGY_R+ENERGY_W+ENERGY_P)
end
--gain attack (damage, to deck)
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.tdfilter(c)
	return c:IsEnergy() and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=30
	local burned=false
	local remove_energy=false
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_R)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_W) then
		dam=dam+10
		burned=true
	end
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_W)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_P) then
		remove_energy=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if not tc:IsInPlay() then return end
	if burned then tc:ApplySpecialCondition(tp,SPC_BURNED) end
	if remove_energy then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=tc:GetAttachedGroup():FilterSelect(tp,scard.tdfilter,1,1,nil)
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	end
end
