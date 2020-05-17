--Tirtouga (Noble Victories 25/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(60))
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_restored=true
scard.weakness_x2={ENERGY_G}
