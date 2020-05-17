--Heat Factory Prism Star (Lost Thunder 178/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--stadium
	aux.EnableStadiumAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCost(aux.DiscardHandCost(1,1,Card.IsEnergy,ENERGY_R))
	e1:SetTarget(aux.DrawTarget(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--immune to effects
	aux.EnableEffectImmune(c,scard.val1,LOCATION_STADIUM)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Draw(tp,3,REASON_EFFECT)
	end
end
--immune to effects
function scard.val1(e,te)
	local tc=te:GetHandler()
	return te:IsActivated() and (tc:IsItem() or tc:IsSupporter())
end
