--Surprise! Time Machine (Team Rocket Returns 91/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--devolve (to deck), search (evolve)
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.devfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_rockets_secret_machine=true
--devolve (to deck), search (evolve)
function scard.devfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsEvolved() and c:IsAbleToDeck()
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEVOLVE)
	local g1=Duel.SelectMatchingCard(tp,scard.devfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Devolve(g1,LOCATION_DECK,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local tc=Duel.GetDevolvedPokemon()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g2=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,tc:GetCode())
	if g2:GetCount()>0 then
		Duel.Evolve(g2:GetFirst(),tc,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. If I use "Surprise Time Machine", can I search for the same Evolution card that I shuffled into my deck?
	A. Yes, that is permitted. (Nov 18, 2004 PUI Rules Team)

	Q. If I use "Surprise Time Machine" and choose the same Evolution card that I shuffled into my deck, can I use that
	card's Pokémon powers even if I've already used it up for the turn (i.e. Blaziken's "Firestarter")?
	A. Unless it's a power that specifically says you may only use one of that power (overall) per turn, then yes that is
	permissible. (Nov 18, 2004 PUI Rules Team)

	Q. If you play Surprise! Time Machine on a Wobbuffet that was evovled from a Wynaut via "Baby Evolution", what happens
	after you shuffle the Wobbuffet back into your deck?
	A. Since there is not a normal evolution path from Wynaut to Wobbuffet (without using "Baby Evolution"), you cannot
	take a Wobbuffet from your deck to evolve it again.

	Q. Lets say I have like a Kirlia active with a DRE [Double Rainbow Energy] on it, and then use "Suprise! Time Machine"
	for a different Kirlia. Would the DRE get discarded because it is devolved back into Ralts?
	A. Yes, once it becomes a Ralts, it is discarded. It doesn't matter that it will evolve again.
	(Jan 13, 2005 PUI Rules Team)

	Q. If I use "Surprise! Time Machine" and remove a Stage 2 Pokémon that was evolved from a Basic using Rare Candy, do I
	search for a Stage 2 Pokémon card or a Stage 1 card?
	A. You can only search for a Stage 1 card, because when you remove the Stage 2 what you have in play is Basic Pokémon.
	(Feb 10, 2005 PUI Rules Team)

	Q. If I use "Surprise! Time Machine" and remove a Stage 2 Pokémon that was evolved from a Basic using Rare Candy, can
	I search for a Stage 1 Pokémon card and then evolve it using Wally's Training or Rare Candy?
	A. You could use the Wally's Training afterwards, but you cannot use Rare Candy on a Stage 1 Pokémon.
	(Feb 17, 2005 PUI Rules Team)

	Q. Say I use "Surprise! Time Machine" and remove a Stage 2 Pokémon that was evolved from a Basic using Rare Candy.
	What happens if I do not have a corresponding Stage 1 card in my deck for the Pokémon that devolved?
	A. Sorry, but the Pokémon would have to remain a Basic at that point. (Apr 14, 2005 PUI Rules Team)
	https://compendium.pokegym.net/compendium-ex.html#trainers
]]
