--Ampharos (Neo Genesis 1/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--paralyzed, damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_L)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.length=4.70
scard.evolves_from=CARD_FLAAFFY
scard.evolution_list1={["Basic"]=CARD_MAREEP,["Stage 1"]=CARD_FLAAFFY,["Stage 2"]=CARD_AMPHAROS}
scard.weakness_x2={ENERGY_F}
--paralyzed, damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,40)
	if not tc:IsInPlay() or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	local g=Duel.GetBenchedPokemon(1-tp)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,10,tc)
	end
end
