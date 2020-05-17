--Virbank City Gym (Plasma Storm 126/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPoisoned()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.ctfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	for tc in aux.Next(g) do
		tc:AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
--[[
	Rulings
		Q. If a Pokemon has a poison condition that places more than one damage counter per turn, like from Crobat's
		"Ultra-Toxic Fang" attack, does Virbank City Gym work or not?
		A. Yes, it works. You place 4 damage counters for Crobat's "Ultra-Toxic Fang", then you place 2 more for Virbank
		City Gym making a total of 6 counters placed. (Feb 28, 2013 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#295
]]
