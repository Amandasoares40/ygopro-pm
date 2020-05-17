--Arceus LV.X (Arceus 94/99)
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
	--poke-body (gain attack)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POKEBODY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_INPLAY)
	e3:SetOperation(scard.op1)
	c:RegisterEffect(e3)
end
scard.pokemon_lvx=true
scard.levels_up_from=CARD_ARCEUS
scard.level_up_list={CARD_ARCEUS,CARD_ARCEUS_LV_X}
--poke-body (change energy type)
function scard.val1(e,c)
	local tc=c:GetMaterial():GetFirst()
	return tc and tc:GetEnergyType()
end
--poke-body (gain attack)
function scard.copyfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_ARCEUS) and c:GetFlagEffect(sid)==0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(scard.copyfilter,tp,LOCATION_INPLAY,0,c)
	if not c:IsFaceup() then return end
	for tc in aux.Next(g) do
		c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD,1)
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
