--Misty's Duel (Gym Heroes 123/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_MISTY)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(sid,0)) then
		if Duel.RockPaperScissors()==tp then
			scard.shuffle_draw(tp)
		else
			scard.shuffle_draw(1-tp)
		end
	else
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_COIN)
		local res=Duel.SelectOption(1-tp,OPTION_HEADS,OPTION_TAILS)
		if res~=Duel.TossCoin(tp,1) then
			scard.shuffle_draw(tp)
		else
			scard.shuffle_draw(1-tp)
		end
	end
end
function scard.shuffle_draw(tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
end
--[[
	Rulings
	Q. Can I just flip a coin with Misty's Duel instead of playing Rock, Paper and Scissors (R.P.S.) since R.P.S. is an
	easy target for cheaters?
	A. It's up to the person playing Misty's Duel. (August 17, 2000 WotC Chat Q175)
	https://compendium.pokegym.net/compendium.html#trainers
]]
