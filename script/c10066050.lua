--Raichu BREAK (BREAKthrough 50/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_BREAK
scard.evolves_from=CARD_RAICHU
scard.evolution_list1={["Baby"]=CARD_PICHU,["Basic"]=CARD_PIKACHU,["Stage 1"]=CARD_RAICHU}
scard.break_evolution_list={CARD_RAICHU,CARD_RAICHU_BREAK}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,170)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
end
