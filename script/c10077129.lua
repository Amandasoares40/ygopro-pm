--Missing Clover (Ultra Prism 129/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--play multiple copies (sort deck or take prize)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--play multiple copies (sort deck or take prize)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.GetPrize(tp):IsExists(Card.IsAbleToHand,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,3,c,c:GetOriginalCode())
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
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
		local g=Duel.GetDecktopGroup(tp,1)
		Duel.ConfirmCards(tp,g)
	elseif opt==2 then
		Duel.TakePrize(tp,1,1,REASON_EFFECT)
		for i=1,3 do
			local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,e:GetHandler():GetOriginalCode())
			Duel.SendtoDPile(g:GetFirst(),REASON_RULE+REASON_DISCARD)
		end
	end
end
