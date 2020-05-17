--Radio Tower (Neo Destiny 95/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--confirm deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckDeckFunction(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--confirm deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,2)
	if e:GetHandler():IsRelateToEffect(e) and g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
