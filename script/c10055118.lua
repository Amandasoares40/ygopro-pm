--Colress (Plasma Storm 118/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	local ct=Duel.GetBenchedPokemon():GetCount()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
--[[
	Rulings
		Q. If my opponent has no cards in their hand, and I only have 1 Colress in my hand, and neither player has any
		Benched Pokemon, am I allowed to play Colress or not?
		A. Yes, you can. You would shuffle your "hand of zero cards" into your deck and draw nothing.
		(Mar 7, 2013 TPCi Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#296
]]
