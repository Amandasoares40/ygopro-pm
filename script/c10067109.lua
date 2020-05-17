--Puzzle of Time (BREAKpoint 109/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play multiple copies (sort deck or to hand)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--play multiple copies (sort deck or to hand)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DPILE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,c,c:GetOriginalCode())
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
		Duel.SortDecktop(tp,tp,3)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DPILE,0,2,2,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
		local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,e:GetHandler():GetOriginalCode())
		Duel.SendtoDPile(tc,REASON_RULE+REASON_DISCARD)
	end
end
