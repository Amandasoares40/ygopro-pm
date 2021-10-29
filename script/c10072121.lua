--Ilima (Sun & Moon 121/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	local ct1=(Duel.TossCoin(tp,1)==RESULT_HEADS and 6 or 3)
	Duel.Draw(tp,ct1,REASON_EFFECT)
	local ct2=(Duel.TossCoin(1-tp,1)==RESULT_HEADS and 6 or 3)
	Duel.Draw(1-tp,ct2,REASON_EFFECT)
end
--[[
	Rulings
	Q. If I use Sylveon's "Wink Wink" attack to have my opponent discard Ilima, can I use Victini's "Victory Star" Ability
	to force my opponent to re-flip their coins?
	A. Yes, you can. If your opponent flips a coin as part of your Pokemon's attack, you can use "Victory Star" to force
	them to re-flip those coins; but keep in mind you will have to re-flip your coins for Ilima too.
	(Nov 15, 2018 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#629
]]
