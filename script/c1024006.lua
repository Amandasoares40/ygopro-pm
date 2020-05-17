--Slugma (Kalos Starter Set 6/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.04
scard.weakness_x2={ENERGY_W}
