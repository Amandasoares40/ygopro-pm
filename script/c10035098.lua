--Felicity's Drawing (Great Encounters 98/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,1,2,e:GetHandler())
	local ct=Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if e:GetLabel()==1 then ct=3
	elseif e:GetLabel()==2 then ct=4 end
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q. Can I discard 0 cards from my hand when playing Felicity's Drawing?
	A. No. You may either discard 1 or 2 cards; there is not an option to discard 0 cards.
	(DP:Great Encounters FAQ; Feb 21, 2008 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#209
]]
