--Battle Tower (Supreme Victors 134/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--remove counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCondition(scard.con1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--remove counter
function scard.cfilter(c)
	return c:IsPlayedFromHand() and c:GetPlayType()==SUMMON_TYPE_LEVEL_UP and c:IsDamaged()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()==1
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if e:GetHandler():IsRelateToEffect(e) then
		g:GetFirst():RemoveCounter(tp,COUNTER_DAMAGE,4,REASON_EFFECT)
	end
end
--[[
	Rulings
		Q. If you play Level Max to level up one of your benched Pokemon while the Battle Tower stadium is in play, do you
		get to remove 4 damage counters from that Pokemon or not?
		A. No, you cannot remove any damage counters. Level Max has you search your deck for the Lv.X Pokemon, but Battle
		Tower only works when you play the Lv.X card from your hand. (Sep 24, 2009 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#425
]]
