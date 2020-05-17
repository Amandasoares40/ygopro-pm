--Lucario GL (Rising Rivals 8/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poke-body (set weakness count)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_WEAKNESS_COUNT)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsHasWeakness))
	e1:SetValue(2)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetActivePokemon(1-tp):GetAttachedGroup()
	local dam=g:GetSum(Card.GetEnergyCount,nil)*10
	Duel.AttackDamage(e,30+dam)
end
