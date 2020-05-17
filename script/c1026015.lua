--Team Magma's Groudon-EX (Double Crisis 15/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ability (cannot attack)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetCondition(scard.con1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_G}
--ability (cannot attack)
function scard.con1(e)
	return Duel.GetInPlayPokemon():FilterCount(Card.IsSetCard,nil,SETNAME_TEAM_MAGMA)<=4
end
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	if Duel.GetActivePokemon(1-tp):IsDamaged() then dam=dam+80 end
	Duel.AttackDamage(e,dam)
end
