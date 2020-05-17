--Kirlia (Ruby & Sapphire 34/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(50))
	e2:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_RALTS
scard.evolution_list1={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR}
scard.evolution_list2={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR_EX_OLD}
scard.weakness_x2={ENERGY_P}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
