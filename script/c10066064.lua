--M Mewtwo-EX (BREAKthrough 64/162)
--BUG: Due to having consecutive ids, this card is treated as M Mewtwo-EX (BREAKthrough 63/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_MEGA
scard.pokemon_ex=true
scard.evolves_from=CARD_MEWTWO_EX
scard.mega_evolution_list={CARD_MEWTWO_EX,CARD_M_MEWTWO_EX}
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=e:GetHandler():GetAttachedGroup()
	local g2=Duel.GetActivePokemon(1-tp):GetAttachedGroup()
	local dam=(g1:GetSum(Card.GetEnergyCount,nil)+g2:GetSum(Card.GetEnergyCount,nil))*30
	Duel.AttackDamage(e,dam+10,Duel.GetActivePokemon(1-tp),false)
end
