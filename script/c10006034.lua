--Sabrina's Venomoth (Gym Heroes 34/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_SABRINA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--remove counter
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=4.11
scard.evolves_from=CARD_SABRINAS_VENONAT
scard.evolution_list1={["Basic"]=CARD_SABRINAS_VENONAT,["Stage 1"]=CARD_SABRINAS_VENOMOTH}
scard.weakness_x2={ENERGY_R}
scard.resistance_30={ENERGY_F}
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()==0 then return end
	local c1,c2,c3=Duel.TossCoin(tp,3)
	local ct=c1+c2+c3
	if ct==RESULT_TAILS then return end
	for tc in aux.Next(g) do
		tc:RemoveCounter(tp,COUNTER_DAMAGE,ct,REASON_ATTACK)
	end
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	if tc:IsInPlay() and ct~=RESULT_TAILS then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
