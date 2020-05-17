--Holon Adventurer (Holon Phantoms 85/110)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
	e:SetLabelObject(g:GetFirst())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=3
	local tc=e:GetLabelObject()
	if tc:IsPokemon() and tc:IsSetCard(SETNAME_DELTA) then ct=4 end
	Duel.Draw(tp,ct,REASON_EFFECT)
end
