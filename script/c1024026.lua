--Snorlax (Kalos Starter Set 26/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,6.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(70))
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 end
	Duel.AttackDamage(e,dam)
end
