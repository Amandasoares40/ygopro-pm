--Noivern BREAK (BREAKthrough 113/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P,ENERGY_D,ENERGY_C)
end
scard.pokemon_evolution=TYPE_BREAK
scard.evolves_from=CARD_NOIVERN
scard.evolution_list1={["Basic"]=CARD_NOIBAT,["Stage 1"]=CARD_NOIVERN}
scard.break_evolution_list={CARD_NOIVERN,CARD_NOIVERN_BREAK}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=70
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==Duel.GetFieldGroupCount(tp,0,LOCATION_HAND) then dam=dam+80 end
	Duel.AttackDamage(e,dam)
end
