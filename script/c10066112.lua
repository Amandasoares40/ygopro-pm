--Noivern (BREAKthrough 112/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--to deck, draw
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_D,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=4.11
scard.evolves_from=CARD_NOIBAT
scard.evolution_list1={["Basic"]=CARD_NOIBAT,["Stage 1"]=CARD_NOIVERN}
scard.break_evolution_list={CARD_NOIVERN,CARD_NOIVERN_BREAK}
scard.weakness_x2={ENERGY_Y}
--to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_ATTACK)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	Duel.Draw(tp,ct,REASON_ATTACK)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
