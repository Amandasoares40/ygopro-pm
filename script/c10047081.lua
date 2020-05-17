--Lost World (Call of Legends 81/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--win game
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckCardFunction(aux.LostZoneFilter(Card.IsPokemon),LOCATION_LZONE,0,6))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--win game
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Win(tp,WIN_REASON_LOST_WORLD)
	end
end
