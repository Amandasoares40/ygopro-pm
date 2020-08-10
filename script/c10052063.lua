--Darkrai-EX (Dark Explorers 63/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ability (0 retreat cost)
	local e1=aux.EnableChangeRetreatCost(c,0,LOCATION_INPLAY,LOCATION_INPLAY,0,scard.tg1)
	e1:SetCategory(CATEGORY_ABILITY)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_D,ENERGY_D,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--ability (0 retreat cost)
function scard.tg1(e,c)
	return c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil,ENERGY_D)
end
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,90)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,30,g:GetFirst())
end
--[[
	Rulings
	* This card's Japanese name doesn't contain わるい (Dark).
]]
