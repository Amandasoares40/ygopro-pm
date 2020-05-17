--Mime Jr. (Diamond & Pearl 90/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poke-power (evolve)
	aux.EnablePokePowerBabyEvolution(c,0,CARD_MR_MIME)
	--to deck, draw
	local e1=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
end
scard.pokemon_basic=true
scard.pokemon_baby=true
scard.height=2.00
scard.evolution_list1={["Baby"]=CARD_MIME_JR,["Basic"]=CARD_MR_MIME}
scard.weakness_10={ENERGY_P}
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
