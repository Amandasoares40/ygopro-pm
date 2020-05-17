--Kyogre & Groudon LEGEND (Undaunted 87/90)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--discard deck
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C,ENERGY_C)
	--discard deck
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_KYOGRE_GROUDON_LEGEND
scard.weakness_x2={ENERGY_G,ENERGY_L}
--discard deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,5,REASON_ATTACK)
	local dam=Duel.GetOperatedGroup():FilterCount(Card.IsEnergy,nil)
	if dam==0 then return end
	local g=Duel.GetBenchedPokemon(1-tp)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,30*dam,tc)
	end
end
--discard deck
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,5,REASON_ATTACK)
	local dam=Duel.GetOperatedGroup():FilterCount(Card.IsEnergy,nil)
	Duel.AttackDamage(e,100*dam)
end
