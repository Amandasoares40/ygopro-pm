--Blaine's Quiz #1 (Gym Heroes 97/132)
--Note: Duel.SelectLength gets rounded down
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--guess length (draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_HAND,0),scard.op1)
end
scard.trainer_item=true
--guess length (draw)
function scard.cfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsHasLength()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PUTFACEDOWN)
	local tc=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.PutFacedown(tc)
	Duel.Hint(HINT_CODE,0,tc:GetOriginalCode())
	local end_time=0
	local start_time=os.time()
	local length=Duel.SelectLength(1-tp)
	end_time=os.time()-start_time
	local guessed_right=end_time<=10 and length==math.floor(tc:GetLength())
	if guessed_right then
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.HintSelection(Group.FromCards(tc))
		Duel.Draw(1-tp,2,REASON_EFFECT)
	else
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.Draw(tp,2,REASON_EFFECT)
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
