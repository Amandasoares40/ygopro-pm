--Rainbow Energy (Team Rocket 17/82)
--Note: EVENT_BECOME_ATTACHED won't be raised if SetType is EFFECT_TYPE_TRIGGER
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BECOME_ATTACHED)
	e1:SetCondition(aux.PlayedFromHandCondition())
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	if c:GetAttachedTarget() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
--add counter
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetAttachedTarget()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	tc:AddCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
end
--[[
	Rulings
	* Most Special Energy cards that provide a particular energy type do not provide that type when it is in the deck, the
	discard pile, or in your hand. Please read the text of the Special Energy card for clarification.
	(Jul 6, 2017 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#c7

	Q. If I have an attack that says to discard a Fire Energy and a Water Energy, may I discard a single Rainbow Energy
	card or Multi Energy card to satisfy that requirement?
	A. No, even though Rainbow and Multi provide all energy types simultaneously, they only provide one unit of energy.
	You can discard it for either the Fire or the Water, but you would still need to discard at least one additional card
	of the required type. (Dec 11, 2008 PUI Rules Team)

	Q. Can you Rain Dance Rainbow Energy?
	A. No. Because it does not count as any type while in your hand. (June 22, 2000 WotC Chat, Q247)
	https://compendium.pokegym.net/compendium-bw.html#175
]]
