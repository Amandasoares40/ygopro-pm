--Ancient Technical Machine [Steel] (Hidden Legends 86/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack (attach)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and not c:IsPokemonex() and not c:IsOwnersPokemon()
end
--gain attack (attach)
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.cfilter(c)
	return c:GetAttachedGroup():IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsBasicEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetInPlayPokemon(1-tp):Filter(scard.cfilter,tc)
	if tc:IsInPlay() and (not tc:IsHasPokePower() and not tc:IsHasPokeBody()) or g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.atfilter,1,2,nil,sg1:GetFirst())
	Duel.Attach(e,tc,sg2)
end
