--Tyranitar ex (Dragon Frontiers 99/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--add marker
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
	--knock out
	local e3=aux.AddPokemonAttack(c,2,nil,scard.op3)
	e3:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.pokemon_ex_old=true
scard.evolves_from=CARD_PUPITAR
scard.evolution_list2={["Basic"]=CARD_LARVITAR,["Stage 1"]=CARD_PUPITAR,["Stage 2"]=CARD_TYRANITAR_EX_OLD}
scard.weakness_x2={ENERGY_G}
--add marker
function scard.markfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDMARKER)
	local g=Duel.SelectMatchingCard(tp,scard.markfilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():AddMarker(tp,MARKER_SHOCKWAVE,1,REASON_ATTACK)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=70
	local tc=Duel.GetActivePokemon(1-tp)
	if tc and tc:IsStage2() and tc:IsEvolved() then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
--knock out
function scard.kofilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetMarker(MARKER_SHOCKWAVE)>0
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KNOCKOUT)
	local g=Duel.SelectMatchingCard(tp,scard.kofilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.KnockOut(g,REASON_ATTACK)
end
