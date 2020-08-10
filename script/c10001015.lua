--Venusaur (Base Set 15/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(60))
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_G,ENERGY_G)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.length=6.70
scard.evolves_from=CARD_IVYSAUR
scard.evolution_list1={["Basic"]=CARD_BULBASAUR,["Stage 1"]=CARD_IVYSAUR,["Stage 2"]=CARD_VENUSAUR}
scard.weakness_x2={ENERGY_R}
--pokemon power (attach)
function scard.cfilter1(c,tp)
	return c:GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsEnergy(ENERGY_G) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,c:GetAttachedTarget(),c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter1,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp):Filter(scard.cfilter1,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.cfilter2,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
	local sg3=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,sg1,sg2:GetFirst())
	Duel.HintSelection(sg3)
	Duel.Attach(e,sg3:GetFirst(),sg2)
end
--[[
	References
	* Tailor of the Fickle
	https://github.com/Fluorohydride/ygopro-scripts/blob/master/c43641473.lua
]]
