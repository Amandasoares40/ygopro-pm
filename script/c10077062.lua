--Lunala Prism Star (Ultra Prism 62/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_D}
scard.resistance_20={ENERGY_F}
--attach
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_P) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
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
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetAttachedGroup(tp,1,1):GetSum(Card.GetEnergyCount,nil)
	Duel.AttackDamage(e,20*ct)
end
