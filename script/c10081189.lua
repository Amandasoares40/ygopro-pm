--Sightseer (Lost Thunder 189/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,c)
		or Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,c)==0 end
	local ct=Duel.GetMatchingGroupCount(Card.IsDiscardable,tp,LOCATION_HAND,0,c)
	if ct==0 then return end
	if ct>4 then
		Duel.DiscardHand(tp,Card.IsDiscardable,ct-4,ct,REASON_COST+REASON_DISCARD)
	elseif Duel.SelectYesNo(tp,YESNOMSG_DISCARDHAND) then
		Duel.DiscardHand(tp,Card.IsDiscardable,1,ct,REASON_COST+REASON_DISCARD)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=5-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
--[[
	Rullings
	Q. When I have seven cards in my hand, can I discard only one with "Sightseer"?
	A. No, you cannot. You must discard until your hand has 4 or fewer cards when using Sightseer.
	(Dec 6, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#631
]]
