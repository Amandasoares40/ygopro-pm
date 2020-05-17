--Pokemon Personality Test (Neo Destiny 102/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--guess card name (draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsEvolution,LOCATION_HAND,0),scard.op1)
end
scard.trainer_item=true
--guess card name (draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PUTFACEDOWN)
	local tc=Duel.SelectMatchingCard(tp,Card.IsEvolution,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.PutFacedown(tc)
	local b1=tc:IsSetCard(SETNAME_LIGHT)
	local b2=tc:IsSetCard(SETNAME_DARK)
	local opt=Duel.SelectOption(1-tp,aux.Stringid(sid,0),aux.Stringid(sid,1),aux.Stringid(sid,2))
	Duel.ChangePosition(tc,POS_FACEUP)
	local guessed_right=(opt==0 and b1) or (opt==1 and b2) or (opt==2 and not b1 and not b2)
	if guessed_right then
		Duel.HintSelection(Group.FromCards(tc))
		Duel.Draw(1-tp,3,REASON_EFFECT)
	else
		Duel.Draw(tp,3,REASON_EFFECT)
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
