--Rampardos (Mysterious Treasures 33/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_F)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_CRANIDOS
scard.evolution_list1={["Basic"]=CARD_SKULL_FOSSIL,["Stage 1"]=CARD_CRANIDOS,["Stage 2"]=CARD_RAMPARDOS}
scard.weakness_30={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetActivePokemon(1-tp):IsRemainingHPBelow(60) and 60 or 30
	Duel.AttackDamage(e,dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,100,false,false,false)
	Duel.AttackDamage(e,20,e:GetHandler())
end
