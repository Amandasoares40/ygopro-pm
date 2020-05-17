--Darkrai-EX (BREAKpoint 74/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_D,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttachedGroup(tp,1,0):Filter(Card.IsEnergy,nil,ENERGY_D)
	local dam=g:GetSum(Card.GetEnergyCount,nil)*20
	Duel.AttackDamage(e,20+dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=80
	if Duel.GetActivePokemon(1-tp):IsAsleep() then dam=dam+80 end
	Duel.AttackDamage(e,dam)
end
--[[
	Rulings
		This card's Japanese name doesn't contain わるい (Dark).
]]
