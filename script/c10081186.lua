--Morty (Lost Thunder 186/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to deck
	aux.PlayTrainerFunction(c,aux.CheckHandFunction(PLAYER_OPPO),scard.op1,scard.con1)
	if not scard.global_check then
		scard.global_check=true
		--check for knocked out pokemon
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_KNOCKED_OUT)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.trainer_supporter=true
--check for knocked out pokemon
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local p1=false
	local p2=false
	for ec in aux.Next(eg) do
		if ec:IsPokemon() and ec:IsEnergyType(ENERGY_P) and Duel.GetTurnPlayer()==1 then
			if ec:GetPreviousControler()==0 then p1=true else p2=true end
		end
	end
	if p1 then Duel.RegisterFlagEffect(0,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
	if p2 then Duel.RegisterFlagEffect(1,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
end
--confirm hand, to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:FilterSelect(tp,Card.IsAbleToDeck,2,2,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
end
