--Juggler (Aquapolis 126/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.costfilter(c)
	return c:IsBasicEnergy() and c:IsDiscardable()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,scard.costfilter,tp,LOCATION_HAND,0,1,2,e:GetHandler())
	local ct=Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if e:GetLabel()==1 then ct=3
	elseif e:GetLabel()==2 then ct=5 end
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
