--Card-Flip Game (Neo Genesis 92/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--turn prize, guess card type (draw)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(aux.PrizeFilter(Card.IsFacedown),0,LOCATION_PRIZE),scard.op1)
end
scard.trainer_item=true
scard.trainer_goldenrod_game_corner=true
--turn prize, guess card type (draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TURNPRIZEUP)
	local tc=Duel.SelectMatchingCard(tp,aux.PrizeFilter(Card.IsFacedown),tp,0,LOCATION_PRIZE,1,1,nil):GetFirst()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local opt=Duel.SelectOption(tp,OPTION_POKEMON,OPTION_TRAINER,OPTION_ENERGY)
	Duel.TurnPrize(tc,POS_FACEUP)
	local guessed_right=(opt==0 and tc:IsPokemon()) or (opt==1 and tc:IsTrainer()) or (opt==2 and tc:IsEnergy())
	if guessed_right then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
