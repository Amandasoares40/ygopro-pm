--Giovanni's Scheme (BREAKthrough 138/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_GIOVANNI)
	--choose one (draw or get effect)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--choose one (draw or get effect)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=5-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	local b1=ct>0 and Duel.IsPlayerCanDraw(tp,1)
	local b2=true
	if chk==0 then return b1 or b2 end
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,0))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		local ct=5-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if ct>0 then
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	elseif opt==2 then
		local c=e:GetHandler()
		--increase damage
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_DO_MORE_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(20)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
		e2:SetTargetRange(LOCATION_ACTIVE,0)
		e2:SetTarget(aux.TargetBoolFunction(Card.IsActive))
		e2:SetLabelObject(e1)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
