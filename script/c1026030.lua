--Team Magma Grunt (Double Crisis 30/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA)
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
	Duel.Draw(tp,3,REASON_EFFECT)
	local tc=e:GetLabelObject()
	if tc:IsPokemon() and tc:IsSetCard(SETNAME_TEAM_MAGMA) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[
	Note: This card's effect is similar to that of "Team Aqua Grunt".
]]
