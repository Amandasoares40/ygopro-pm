--Charon's Choice (Rising Rivals RT6/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (switch), to deck
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--search (switch), to deck
function scard.tdfilter(c)
	return c:IsFaceup() and c:IsSetCard(SETNAME_ROTOM) and c:IsAbleToDeck()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.IsExistingMatchingCard(scard.tdfilter,tp,LOCATION_INPLAY,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PROMOTE)
	local sg1=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,0,1,nil,SETNAME_ROTOM)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg2=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.SwitchPokemonOffField(tp,sg2,sg1,LOCATION_DECK,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
		Q. If I shuffle Rotom into my deck using "Charon's Choice", but I don't find any other Rotom, can I choose the
		same one and put it back?
		A. Actually, you search your deck first, then when you find a Rotom you put your original Rotom on the deck to be
		shuffled. If you don't take a Rotom from your deck, your original Rotom stays in play, including any effects or
		Special Conditions it may have. (PL:Rising Rivals FAQ; May 21, 2009 PUI Rules Team)

		Q. If I use "Charon's Choice", can I get the same type of Rotom as I currently have in play, or does it have to be
		different?
		A. Yes, it can be the same type. For example, if you have a Mow Rotom in play, using Charon's Choice you may
		choose any Rotom from your deck, even another Mow Rotom. When you switch, remove effects and Special Conditions
		from the new Rotom, but keep all damage counters and cards attached.
		(PL:Rising Rivals FAQ; May 21, 2009 PUI Rules Team)

		Q. If I use Sableye's "Impersonate" attack to search for a supporter and I find "Charon's Choice" and use its
		effect, does Charon's Choice go back into my hand at the end of my turn or do I discard it per Sableye's attack?
		A. When using Impersonate, the Charon's Choice card goes to the discard pile rather than next to the Active
		Pokemon. Since it is already in the discard pile, you cannot bring the Charon's Choice card back into your hand.
		(Jun 11, 2009 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#398
]]
