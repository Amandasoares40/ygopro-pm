--Lt. Surge's Treaty (Gym Heroes 112/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_LT_SURGE)
	--choose one (take prize or draw)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--choose one (take prize or draw)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetPrize():IsExists(Card.IsAbleToHand,1,nil)
	local b2=Duel.IsPlayerCanDraw(tp,1)
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
		Duel.TakePrize(tp,1,1,REASON_EFFECT)
		Duel.TakePrize(1-tp,1,1,REASON_EFFECT)
	elseif opt==2 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
