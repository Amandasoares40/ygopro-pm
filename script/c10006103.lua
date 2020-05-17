--No Removal Gym (Gym Heroes 103/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ACTIVATE_COST)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(1,1)
	e1:SetCost(scard.cost1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add cost
function scard.cost1(e,te_or_c,tp)
	return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,te_or_c:GetHandler())
end
function scard.tg1(e,te,tp)
	e:SetLabelObject(te:GetHandler())
	return te:GetHandler():IsCode(CARD_ENERGY_REMOVAL,CARD_SUPER_ENERGY_REMOVAL,CARD_ENERGY_REMOVAL_2,CARD_SUPER_ENERGY_REMOVAL_2)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD,e:GetLabelObject())
end
