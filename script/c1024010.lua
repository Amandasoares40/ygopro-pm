--Delphox (Kalos Starter Set 10/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,4.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_BRAIXEN
scard.evolution_list1={["Basic"]=CARD_FENNEKIN,["Stage 1"]=CARD_BRAIXEN,["Stage 2"]=CARD_DELPHOX}
scard.break_evolution_list={CARD_DELPHOX,CARD_DELPHOX_BREAK}
scard.weakness_x2={ENERGY_W}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK)
end
