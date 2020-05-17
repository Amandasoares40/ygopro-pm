--Ninetales BREAK (Evolutions 16/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_evolution=TYPE_BREAK
scard.evolves_from=CARD_NINETALES
scard.evolution_list1={["Basic"]=CARD_VULPIX,["Stage 1"]=CARD_NINETALES}
scard.break_evolution_list={CARD_NINETALES,CARD_NINETALES_BREAK}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_R)
	local dam=60*Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
	Duel.AttackDamage(e,10+dam)
end
