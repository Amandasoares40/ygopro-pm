--Solgaleo Prism Star (Ultra Prism 89/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_M,ENERGY_M,ENERGY_M)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--attach
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_M) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DPILE,0,nil,tp)
	if g:GetCount()==0 then return end
	local count=Duel.GetInPlayPokemon(1-tp):GetCount()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
		local sg1=g:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
		g:Sub(sg1)
		g:Sub(sg2)
		count=count-1
	until count==0 or g:GetCount()==0
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,160)
	local c=e:GetHandler()
	--cannot attack
	aux.AddTempEffectCustom(c,c,DESC_CANNOT_ATTACK,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
