--Shaymin-EX (Next Destinies 5/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (attach)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_G,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_F}
--search (attach)
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_G) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DECK,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,0,1,nil)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
	else
		Duel.ShuffleDeck(tp)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetTakenPrizeCount(1-tp)*30
	Duel.AttackDamage(e,30+dam)
end
