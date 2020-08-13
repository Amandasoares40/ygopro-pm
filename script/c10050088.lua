--Haxorus (Noble Victories 88/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,5.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_FRAXURE
scard.evolution_list1={["Basic"]=CARD_AXEW,["Stage 1"]=CARD_FRAXURE,["Stage 2"]=CARD_HAXORUS}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,50*dam)
end
--gain effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	local c=e:GetHandler()
	--cannot attack
	aux.AddTempEffectCustom(c,c,DESC_CANNOT_ATTACK,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
