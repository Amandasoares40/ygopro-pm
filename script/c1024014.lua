--Greninja (Kalos Starter Set 14/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,4.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(80))
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_FROGADIER
scard.evolution_list1={["Basic"]=CARD_FROAKIE,["Stage 1"]=CARD_FROGADIER,["Stage 2"]=CARD_GRENINJA}
scard.break_evolution_list={CARD_GRENINJA,CARD_GRENINJA_BREAK}
scard.weakness_x2={ENERGY_G}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,40)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
