--Trick Shovel (Flashfire 98/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm deck, discard deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--confirm deck, discard deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,LOCATION_DECK)>0 end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,OPTION_CONFIRMSDECK)
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,OPTION_CONFIRMODECK)
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local p=(opt==1 and tp) or (opt==2 and 1-tp)
	local g=Duel.GetDecktopGroup(p,1)
	Duel.ConfirmCards(p,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:Select(tp,0,1,nil)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	end
end
