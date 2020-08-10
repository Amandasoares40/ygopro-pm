--Hugh (Boundaries Crossed 130/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw or discard hand
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--draw or discard hand
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct1=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if chk==0 then return (ct1~=5 or ct2~=5)
		and (Duel.IsPlayerCanDraw(tp,1) or Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()))
		and (Duel.IsPlayerCanDraw(1-tp,1) or Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_HAND,1,nil)) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct2>5 then
		Duel.DiscardHand(1-tp,nil,ct2-5,ct2-5,REASON_EFFECT+REASON_DISCARD)
	elseif ct2<5 then
		Duel.Draw(1-tp,5-ct2,REASON_EFFECT)
	end
	if ct1>5 then
		Duel.DiscardHand(tp,nil,ct1-5,ct1-5,REASON_EFFECT+REASON_DISCARD)
	elseif ct1<5 then
		Duel.Draw(tp,5-ct1,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. If I have 6 cards in my hand including a Hugh, and my opponent has 5 cards, can I play Hugh or not?
	A. No, you cannot. After playing Hugh both players would have exactly 5 cards in their hands, and you cannot play a
	Trainer card for no effect. (Jan 3, 2013 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#281
]]
