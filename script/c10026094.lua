--Holon Research Tower (Delta Species 94/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add energy type
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(sid)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetTarget(scard.tg1)
	c:RegisterEffect(e1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_ADD_ENERGY_TYPE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg2)
		ge1:SetValue(ENERGY_M)
		Duel.RegisterEffect(ge1,0)
	end
end
--add energy type
function scard.tg1(e,c)
	return c:IsSetCard(SETNAME_DELTA) and c:GetAttachedGroup():IsExists(Card.IsBasicEnergy,1,nil)
end
function scard.tg2(e,c)
	return c:IsBasicEnergy() and c:GetAttachedTarget():IsHasEffect(sid)
end
