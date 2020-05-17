--Ancient Technical Machine [Rock] (Hidden Legends 85/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack (devolve - return)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and not c:IsPokemonex() and not c:IsOwnersPokemon()
end
--gain attack (devolve - return)
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.devfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEvolved() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.devfilter,tp,0,LOCATION_INPLAY,nil)
	Duel.Devolve(g,LOCATION_HAND,nil,REASON_EFFECT)
end
