--Wally's Training (Sandstorm 89/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (evolve)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_supporter=true
--search (evolve)
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsActive() and c:IsCanEvolve(e,tp,true,true)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil,e,tp)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g1=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g2=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,g1:GetFirst():GetCode())
	if g2:GetCount()>0 then
		Duel.Evolve(g2:GetFirst(),g1,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
	Q. Can I use Wally's Training on the first turn of a game (when Pokémon are not normally allowed to evolve)?
	A. Yes, this is now permissible. (Jul 22, 2004 PUI Rules Team)

	Q. Can I use Wally's Training on a Pokémon's first turn in play? For example, can I place down a Wurmple, make it
	active, and then use Wally's Training on the same turn to evolve it into Silcoon or Cascoon?
	A. Yes, you may use Wally's Training to evolve a Pokémon the first turn it is in play.
	(Sep 11, 2003 PUI Rules Team; Jul 22, 2004 PUI Rules Team)

	Q. Can I use Wally's Training on a Pokémon that has already evolved normally that turn?
	A. Yes. Wally's Training can break the rules for normal evolution in that case. It also can allow a player to evolve
	a Pokémon the first turn it is in play, except for the very first turn of the game (for each player). In order for
	Wally's Training to break the "first turn of the game" evolution, the card would have to specifically say so.
	(Sep 26, 2003 PUI Rules Team)

	Q. Can I use Wally's Training on a Pokémon I just evolved that turn with Rare Candy?
	A. Yes. Trainer cards that allow an evolution to take place, breaks the standard evolution rule that states you can
	only evolve once in a turn. (Sep 26, 2003 PUI Rules Team)

	Q. Does Wally's Training override evolution-preventing effects such as Fossil Aerodactyl's "Prehistoric Power"?
	A. You can use Wally's Training when Aerodactyl's Prehistoric Power is in play (except for the first turn of the
	game). (Sep 18, 2003 PUI Rules Team)

	Q. If you use Wally's Training to evolve a Pokémon, and the evo card has a "Coming into Play" Pokémon Power (such as
	Dark Crobat), does that coming into play power get activated?
	A. No, because those powers only work "when you play it from your hand". Wally's Training has you search your deck for
	the card. (Oct 23, 2003 PUI Rules Team)

	Q. Can I use Wally's Training to evolve a Baby Pokémon into its next stage? What about the newer forms of babies that
	are considered "Basic Pokémon" but have the "Baby Evolution" Poké-POWER?
	A. Wally's Training states if you have a card that "Evolves From" your Pokémon There are currently no cards with text
	saying "evolves from" its baby form, so Wally's Training will not work on any form of baby Pokémon.
	(Oct 23, 2003 PUI Rules Team)

	Q. I evolved Torchic into Combusken using Wally's Training. Can I then do my "regular" evolution for Combusken into
	Blaziken?
	A. No. "(This counts as evolving that Pokémon)" means that it counts as a normal evolution in this case.
	(Sep 25, 2003 PUI Rules Team)

	Q. Can I use Wally's Training on a Mewtwo to search my deck, even though there is no evolution of Mewtwo?
	A. No, there has to at least be the possibility of a valid evolution in order to use this card. Sorry.
	(Jan 22, 2004 PUI Rules Team)

	Q. Can I use Wally's Training in conjunction with Buried Fossil to search for an Omanyte, Kabuto, or Aerodactyl?
	And how about Aerodactyl-EX too?
	A. Wally's Training states to search for a card that "Evolves From" your active Pokémon Buried Fossil has special text
	on it that says, "You may play a Pokémon card that evolves from Mysterious Fossil on top of Buried Fossil". So Wally's
	Training will work in both of these situations. (Jan 29, 2004 PUI Rules Team)

	Q. What does "This counts as evolving that Pokémon" mean, in game terms?
	A. It counts towards the one evolution per turn for that Pokémon (with exceptions for Trainers and Pokémon Powers that
	break that rule) and removes Special Conditions on that Pokémon. (Sep 26, 2003 PUI Rules Team)
	https://compendium.pokegym.net/compendium-ex.html#trainers
]]
