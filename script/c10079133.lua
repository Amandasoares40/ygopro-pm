--Hiker (Celestial Storm 133/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confirm deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0
	if chk==0 then return b1 or b2 end
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
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local p=(opt==1 and tp) or (opt==2 and 1-tp)
	local g=Duel.GetDecktopGroup(p,5)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
	local sg=g:Select(tp,1,1,nil)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
	Duel.MoveSequence(sg:GetFirst(),SEQ_DECK_TOP)
end
