--Ancient Technical Machine [Ice] (Hidden Legends 84/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and not c:IsPokemonex() and not c:IsOwnersPokemon()
end
--gain attack
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsTrainer()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.dtfilter,tp,0,LOCATION_INPLAY,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	if Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)>0 then
		--immune to effects
		aux.AddTempEffectImmune(c,c,DESC_IMMUNE_EFFECT,scard.val1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
function scard.val1(e,te)
	return te:GetOwner()~=e:GetOwner()
end
