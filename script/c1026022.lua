--Team Magma's Zangoose (Double Crisis 22/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--search (to bench)
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=4.03
scard.weakness_x2={ENERGY_F}
--search (to bench)
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsSetCard(SETNAME_TEAM_MAGMA) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.IsBenchFull(tp) then return end
	local ct=Duel.GetFreeBenchCount(tp)
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,ct,nil,e,tp)
	if g:GetCount()>0 then
		Duel.PlayPokemon(g,0,tp,tp,true,false,POS_FACEUP_UPSIDE)
	else
		Duel.ShuffleDeck(tp)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetBenchedPokemon(tp):FilterCount(Card.IsSetCard,nil,SETNAME_TEAM_MAGMA)
	Duel.AttackDamage(e,20*dam)
end
