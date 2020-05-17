--Teammates (Primal Clash 141/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,scard.con1)
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
		if ec:IsPokemon() and Duel.GetTurnPlayer()==1 then
			if ec:GetPreviousControler()==0 then p1=true else p2=true end
		end
	end
	if p1 then Duel.RegisterFlagEffect(0,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
	if p2 then Duel.RegisterFlagEffect(1,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
end
--search (to hand)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,sid)>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	else
		Duel.ShuffleDeck(tp)
	end
end
