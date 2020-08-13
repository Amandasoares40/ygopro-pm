--Elekid (Neo Genesis 22/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--baby pokemon ability
	aux.EnableBabyPokemonAbility(c)
	--pokemon power (damage, end turn)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.pokemon_basic=true
scard.pokemon_baby=true
scard.evolution_list1={["Baby"]=CARD_ELEKID,["Basic"]=CARD_ELECTABUZZ,["Stage 1"]=CARD_ELECTIVIRE}
--pokemon power (damage, end turn)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.EffectDamage(e,20,e:GetHandler(),Duel.GetActivePokemon(1-tp))
	end
	Duel.EndTurn()
end
