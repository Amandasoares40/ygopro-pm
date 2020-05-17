--Blaine's Quiz #2 (Gym Challenge 111/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--guess card type (draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_HAND,0),scard.op1)
end
scard.trainer_item=true
--guess card type (draw)
function scard.cfilter(c)
	return c:IsEnergy() or c:IsTrainer() or c:IsPokemon()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PUTFACEDOWN)
	local tc=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.PutFacedown(tc)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CARDTYPE)
	local opt=Duel.SelectOption(1-tp,OPTION_POKEMON,OPTION_TRAINER,OPTION_ENERGY)
	Duel.ChangePosition(tc,POS_FACEUP)
	local guessed_right=(opt==0 and tc:IsPokemon()) or (opt==1 and tc:IsTrainer()) or (opt==2 and tc:IsEnergy())
	if guessed_right then
		Duel.HintSelection(Group.FromCards(tc))
		Duel.Draw(1-tp,2,REASON_EFFECT)
	else
		Duel.Draw(tp,2,REASON_EFFECT)
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
