--Greedy Dice (Steam Siege 102/114)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--take prize
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_PRE_PRIZE_TAKE)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
--take prize
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetPrize(tp):Filter(Card.IsAbleToHand,e:GetHandler())
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	c:SetStatus(STATUS_ACTIVATED,true)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.TakePrize(tp,1,1,REASON_EFFECT)
	end
	Duel.SendtoDPile(c,REASON_RULE+REASON_DISCARD)
end
--[[
	Rulings
	Q. If I use Gladion can I choose Greedy Dice from my prizes and play it right then?
	A. Greedy Dice can be played only if it's taken as a face-down Prize card. Gladion doesn’t count as "taking a Prize
	card." (Mar 1, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#571
]]
