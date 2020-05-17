--Arceus LV.X (Arceus 95/99)
--WORK IN PROGRESS: Not fully tested
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--level up
	aux.EnableLevelUpAttribute(c)
	--poke-body (change energy type)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
	e2:SetRange(LOCATION_INPLAY)
	c:RegisterEffect(e2)
	--damage
	local e3=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e3:SetAttackCost(ENERGY_G,ENERGY_R,ENERGY_C)
end
scard.pokemon_lvx=true
scard.levels_up_from=CARD_ARCEUS
scard.level_up_list={CARD_ARCEUS,CARD_ARCEUS_LV_X}
--poke-body (change energy type)
function scard.val1(e,c)
	local tc=c:GetMaterial():GetFirst()
	return tc and tc:GetEnergyType()
end
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=100
	if Duel.TossCoin(tp,1)==RESULT_TAILS then dam=50 end
	Duel.AttackDamage(e,dam)
end
