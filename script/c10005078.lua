--Goop Gas Attack (Team Rocket 78/82)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--get effect
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_item=true
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable pokemon power
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_POKEMON_POWER)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsHasPokemonPower))
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
	--add description
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(DESC_CANNOT_USE_POKEMONPOWER)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsHasPokemonPower))
	e3:SetLabelObject(e2)
	e3:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e3,tp)
end
