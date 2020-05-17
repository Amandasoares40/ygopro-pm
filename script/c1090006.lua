--Ancient Mew (The Power of One promo)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(40))
	e1:SetAttackCost(ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_P}
