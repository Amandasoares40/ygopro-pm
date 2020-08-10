--Tickling Machine (Gym Heroes 119/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--destroy hand or end turn
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1)
end
scard.trainer_rockets_secret_machine=true
--destroy hand or end turn
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
		if g:GetCount()==0 or Duel.SetAside(g,REASON_EFFECT)==0 then return end
		for tc in aux.Next(g) do
			tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
		end
		g:KeepAlive()
		--to hand
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabel(0)
		e1:SetLabelObject(g)
		e1:SetCondition(scard.con1)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	else Duel.EndTurn() end
end
--to hand
function scard.thfilter(c)
	return c:GetFlagEffect(sid)>0
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	return g:IsExists(scard.thfilter,1,nil) and Duel.GetTurnPlayer()~=tp and Duel.GetTurnCount()~=e:GetLabel()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	local g=e:GetLabelObject():Filter(scard.thfilter,nil)
	Duel.SendtoHand(g,1-tp,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can the card Tickling Machine (Gym Heroes) be involved where effects make use of Rocket's Secret Machine cards
	(such as Rocket's Meowth's first attack), even though Tickling Machine is labeled as a "Rocket's Secret Robot"?
	A. Tickling Machine is considered a "Rocket's Secret Machine" for the purposes of Rocket's Meowth and Rocket's
	Wobbuffet. (Feb 24, 2005 PUI Rules Team)
	https://compendium.pokegym.net/compendium-ex.html#trainers
]]
