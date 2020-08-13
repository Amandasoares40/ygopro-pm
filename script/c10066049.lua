--Raichu (BREAKthrough 49/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.07)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_PIKACHU
scard.evolution_list1={["Baby"]=CARD_PICHU,["Basic"]=CARD_PIKACHU,["Stage 1"]=CARD_RAICHU}
scard.break_evolution_list={CARD_RAICHU,CARD_RAICHU_BREAK}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_M}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(1-tp):Filter(Card.IsPokemonEX,nil)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,50,tc)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=70
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
