--Looker's Investigation (Platinum 109/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to deck, draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--confirm hand, to deck, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler())
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g1:GetCount()>0 then
		Duel.ConfirmCards(tp,g1)
		Duel.ShuffleHand(1-tp)
	end
	local b1=Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil) or Duel.IsPlayerCanDraw(tp,1)
	local b2=Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil) or Duel.IsPlayerCanDraw(1-tp,1)
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,0))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local p=(opt==1 and tp) or (opt==2 and 1-tp)
	local g2=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	Duel.SendtoDeck(g2,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
	Duel.DrawUpTo(p,5,REASON_EFFECT,true)
end
--[[
	Rulings
	Q. If player a uses Looker's Investigation and decides that they want to draw the cards, can they choose zero as their
	up to amount?
	A. No, the player must draw at least one card if they are able to. (Feb 19, 2009 PUI Rules Team)
	https://compendium.pokegym.net/compendium-lvx.html#352
]]
