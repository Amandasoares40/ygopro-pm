--Bounce Energy (Skyridge 142/144)
--Note: EVENT_BECOME_ATTACHED won't be raised if SetType is EFFECT_TYPE_TRIGGER
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,scard.energyfilter)
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_C,2)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BECOME_ATTACHED)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.energy_special=true
--energy
function scard.energyfilter(c)
	return c:GetAttachedGroup():IsExists(Card.IsBasicEnergy,1,nil)
end
--return
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetAttachedTarget()
	return c:IsPlayedFromHand() and tc and tc:GetAttachedGroup():IsExists(Card.IsBasicEnergy,1,nil)
end
function scard.retfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetAttachedTarget():GetAttachedGroup():Filter(scard.retfilter,nil)
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.Hint(HINT_SELECTMSG,ep,HINTMSG_RTOHAND)
	local sg=g:Select(ep,1,1,nil)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-ep,sg)
end
--[[
	Rulings
		Q. Should the second sentence of Bounce Energy include the word 'ONLY'...saying 'you can ONLY attach this card..."
		A. Right-o. (May 8, 2003 WotC Chat, Q1483)
		http://compendium.pokegym.net/compendium.html#trainers
]]
