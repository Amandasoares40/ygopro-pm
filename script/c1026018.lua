--Team Aqua's Mightyena (Double Crisis 18/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	aux.AddHeight(c,3.03)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TEAM_AQUAS_POOCHYENA
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_POOCHYENA,["Stage 1"]=CARD_TEAM_AQUAS_MIGHTYENA}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetInPlayPokemon(tp):FilterCount(Card.IsSetCard,nil,SETNAME_TEAM_AQUA)
	local dam=0
	for i=1,ct do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
	end
	Duel.AttackDamage(e,30*dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,80)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
