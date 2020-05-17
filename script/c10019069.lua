--Team Aqua Schemer (Team Magma vs Team Aqua 69/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.cost1)
end
scard.trainer_supporter=true
--draw
function scard.costfilter(c)
	return c:IsPokemon() and c:IsDiscardable()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,scard.costfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
	e:SetLabelObject(g:GetFirst())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=(e:GetLabelObject():IsSetCard(SETNAME_TEAM_AQUA) and 4 or 3)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
