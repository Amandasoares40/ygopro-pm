--Evosoda (XY 116/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (evolve)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (evolve)
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanEvolve(e,tp,false,false)
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
	Q. If a Basic Pokemon was put into play last turn, can I use Evosoda on it twice to bring it all the way to a Stage 2?
	A. No, you cannot. When you evolve a Pokemon it is a new Pokemon, and since it was put into play this turn you cannot
	use Evosoda on it until next turn. (XY FAQ; Feb 6, 2014 TPCi Rules Team)

	Q. Can I use Evosoda to search for a Mega Pokemon?
	A. As long as it evolves from the Pokemon you choose, yes. (XY FAQ; Feb 6, 2014 TPCi Rules Team)

	Q. Can I use Wally or Evosoda on a Snorlax to search my deck, even though there is {currently} no evolution of
	Snorlax?
	A. No, there has to at least be the possibility of a valid evolution in order to use this card. Sorry.
	(Jul 26, 2018 TPCi Rules Team)

	Q. Can I use Wally or Evosoda to search my deck for a card that is not in the current tournament format? For example,
	could I use it on Raichu to search for a Raichu BREAK after it rotates out?
	A. Yes, you can. Even though a card may not be in the tournament format it still exists and can be searched for even
	though it is known to fail. (Jul 26, 2018 TPCi Rules Team)

	Q. Can I use Evosoda on a Caterpie the first turn of the game or the turn that Caterpie is played since "Adaptive
	Evolution" says it can evolve in those cases?
	A. No, you can't use Evosoda to evolve in either of those conditions because the text on Evosoda specifically
	prevents it. (May 29, 2014 TPCi Rules Team)

	Q. If I use Evosoda to evolve my Basic Pokemon into a Stage 1, can I then use Wally to further evolve it into a
	Stage 2 on that same turn.
	A. Yes, but be careful of the order in which you play the cards. Wally says you can use it on a Pokemon that was put
	into play this turn, but Evosoda says you cannot use it on a Pokemon that was put into play this turn. So you can play
	Evosoda first then Wally, but you cannot play Wally then Evosoda (on the same Pokemon, of course).
	(Mar 16, 2017 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#340
]]
