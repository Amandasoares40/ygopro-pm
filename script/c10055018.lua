--Victini-EX (Plasma Storm 18/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (attach)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_W}
--search (attach)
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetBenchedPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DECK,0,nil,tp)
	local count=2
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
		local sg1=g:Select(tp,0,1,nil)
		if sg1:GetCount()==0 then break end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.DisableShuffleCheck()
		Duel.Attach(e,sg2:GetFirst(),sg1)
		g:Sub(sg1)
		g:Sub(sg2)
		count=count-1
	until count==0 or g:GetCount()==0
	Duel.ShuffleDeck(tp)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.GetActivePokemon(1-tp):IsPokemonEX() then dam=dam+50 end
	Duel.AttackDamage(e,dam)
end
