--Braixen (Kalos Starter Set 9/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,3.03)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(60))
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_FENNEKIN
scard.evolution_list1={["Basic"]=CARD_FENNEKIN,["Stage 1"]=CARD_BRAIXEN,["Stage 2"]=CARD_DELPHOX}
scard.break_evolution_list={CARD_DELPHOX,CARD_DELPHOX_BREAK}
scard.weakness_x2={ENERGY_W}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
