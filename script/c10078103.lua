--Bonnie (Forbidden Light 103/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard stadium, gain effect
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.dtfilter,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_supporter=true
--discard stadium, gain effect
function scard.dtfilter(c)
	return c:IsFaceup() and c:IsStadium()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(Duel.GetStadiumCard(),REASON_EFFECT+REASON_DISCARD)
	local c=e:GetHandler()
	--ignore used gx attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BONNIE_FLI103)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IGNORE_USED_GX_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_ACTIVE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,CARD_ZYGARDE_GX))
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
--[[
	Rulings
	Q. If my opponent used Latios GX's "Clear Vision GX" attack on me, could I use Bonnie to allow my Zygarde-GX to use
	its GX attack?
	A. No, you cannot. Although Bonnie would normally let Zygarde-GX re-use its GX attack, the effect of Clear Vision GX
	is on Zygarde-GX and that still prevents using *ANY* GX attacks. (Sep 5, 2019 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#726
]]
