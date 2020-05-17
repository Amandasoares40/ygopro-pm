--Cedric Juniper (Legendary Treasures 110/113)
--Note: Duel.SelectHeight gets rounded down
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--guess height (draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_HAND,0),scard.op1)
end
scard.trainer_supporter=true
--guess height (draw)
function scard.cfilter(c)
	return c:IsPokemon() and c:IsHasHeight()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PUTFACEDOWN)
	local tc=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.PutFacedown(tc)
	Duel.Hint(HINT_CODE,0,tc:GetOriginalCode())
	local end_time=0
	local start_time=os.time()
	local height=Duel.SelectHeight(1-tp)
	end_time=os.time()-start_time
	local guessed_right=end_time<=10 and height==math.floor(tc:GetHeight())
	if guessed_right then
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.HintSelection(Group.FromCards(tc))
		Duel.Draw(1-tp,3,REASON_EFFECT)
	else
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.Draw(tp,3,REASON_EFFECT)
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
