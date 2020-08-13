--Clauncher (Kalos Starter Set 15/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.08)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_G}
