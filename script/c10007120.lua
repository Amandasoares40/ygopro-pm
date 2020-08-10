--Rocket's Secret Experiment (Gym Challenge 120/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--search (to hand) or gain effect
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--search (to hand) or gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		else
			Duel.ShuffleDeck(tp)
		end
	else
		--cannot play trainer
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(DESC_PLAYER_CANNOT_PLAY_TRAINER)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e1:SetTargetRange(1,0)
		e1:SetValue(scard.val1)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		Duel.RegisterEffect(e1,tp)
	end
end
--cannot play trainer
function scard.val1(e,re,tp)
	return re:IsActiveType(TYPE_TRAINER)
end
