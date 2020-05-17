--Crystal Beach (Crystal Guardians 75/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--change attached energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(sid)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsPokemon))
	c:RegisterEffect(e1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg1)
		ge1:SetValue(ENERGY_C)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EFFECT_CHANGE_ENERGY_COUNT)
		ge2:SetValue(1)
		Duel.RegisterEffect(ge2,0)
	end
end
--change attached energy
function scard.tg1(e,c)
	return c:IsSpecialEnergy() and c:GetAttachedTarget():IsHasEffect(sid)
end
