--Granbull (Kalos Starter Set 23/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,4.07)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_Y,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_Y,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_SNUBBULL
scard.evolution_list1={["Basic"]=CARD_SNUBBULL,["Stage 1"]=CARD_GRANBULL}
scard.weakness_x2={ENERGY_M}
scard.resistance_20={ENERGY_D}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=(c1+c2)*20
	Duel.AttackDamage(e,50+dam)
end
