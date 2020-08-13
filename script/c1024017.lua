--Mightyena (Kalos Starter Set 17/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,3.03)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_D,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_POOCHYENA
scard.evolution_list1={["Basic"]=CARD_POOCHYENA,["Stage 1"]=CARD_MIGHTYENA}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=40
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
