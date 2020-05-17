--Pokemon Retriever (Team Rocket Returns 84/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand or to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_rockets_secret_machine=true
--to hand or to deck
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.tdfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToDeck()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(scard.thfilter,tp,LOCATION_DPILE,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(scard.tdfilter,tp,LOCATION_DPILE,0,1,nil)
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
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_DPILE,0,3,3,nil)
		if g:GetCount()>0 then
			Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
		end
	end
end
