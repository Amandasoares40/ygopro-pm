--Rare Candy (Sandstorm 88/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--evolve
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--evolve
function scard.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsBasicPokemon() and c:IsCanEvolve(e,tp,false,false)
		and Duel.IsExistingMatchingCard(scard.evofilter,tp,LOCATION_HAND,0,1,nil,e,tp,c)
end
function scard.evofilter(c,e,tp,tc)
	return c:IsStage2() and aux.IsEvolutionChain(c,tc:GetCode())
		and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFreeBenchCount(tp)>-1
		and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_INPLAY,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local g1=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil,e,tp)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g2=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,g1:GetFirst())
	if g2:GetCount()>0 then
		Duel.Evolve(g2:GetFirst(),g1,tp)
	end
end
--[[
	Rulings
		Q. Could you Rare Candy a Pokémon and NOT play an evolution on it just to get rid of the Rare Candy?
		A. No, you cannot discard a card for free. You must be able to attach the Stage 2 card, or you cannot use the Rare
		Candy. (Oct 30, 2003 PUI Rules Team; Dec 4, 2003 PUI Rules Team)

		Q. Can I use Rare Candy on a Pokémon that has already evolved normally that turn?
		A. No you cannot, because Rare Candy can only evolve Basic Pokémon If you evolved a Pokémon already this turn, it
		would not be a Basic any more. (Oct 23, 2003 PUI Rules Team)

		Q. Say I use my Pichu's "Baby Evolution" power to evolve Pichu into Pikachu, which is now an "evolved Basic
		Pokémon". Can I then play Rare Candy on my Pikachu to evolve it into Raichu or Raichu-EX during the same turn?
		A. Since Pikachu would be considered an "Evolved Pokémon" at that point, Rare Candy cannot be used on that
		Pikachu. Rare Candy can only be used on "non-Evolved" Pokémon. (Apr 14, 2005 PUI Rules Team)

		Q. If you use Rare Candy to evolve a Pokémon, and the evo card has a "Coming into Play" Pokémon Power (such as
		Dark Crobat), does that coming into play power get activated?
		A. Using Powers, Attacks, or Trainers that let you put a Pokémon in the game from your hand will allow coming into
		play Powers to activate. This is a reversal from previous rulings.
		(Oct 23, 2003 PUI Rules Team; Apr 14, 2005 PUI Rules Team)

		Q. Can you use Rare Candy to evolve a Mysterious Fossil into an Omastar or Kabutops, or use it on a Root/Claw
		Fossil to evolve into Cradily/Armaldo?
		A. It can. It counts as a basic Pokémon while in play. Omastar, Kabutops, Cradily, and Armaldo are Stage 2
		Pokémon; you could use Rare Candy on the Fossil trainer to skip to them. (Oct 16, 2003 PUI Rules Team)

		Q. Can I use Rare Candy to evolve a Baby Pokémon into its next stage? What about the newer forms of babies that
		are considered "Basic Pokémon" but have the "Baby Evolution" Poké-POWER?
		A. Rare Candy states if you have a card that "Evolves From" your Pokémon There are currently no cards with text
		saying "evolves from" its baby form, so Rare Candy will not work on any form of baby Pokémon
		(Oct 23, 2003 PUI Rules Team)

		Q. Can I evolve Dratini in play to Dark Dragonite by using Rare Candy?
		A. Yes. (This is true as long as there is a normal evolutionary path between the basic and the Stage 2 "Dark"
		Pokémon.) (Feb 10, 2005 PUI Rules Team)

		Q. If I use Rare Candy to put an Empoleon on my Piplup, can I then immediately put Empoleon LV.X on top of that?
		A. No, you may not. Just like you cannot use Rare Candy to attach a Stage 1 then evolve it into a Stage 2 on the
		same turn, you cannot place a LV.X Pokémon on top of a Pokémon that used Rare Candy on that same turn.
		(May 31, 2007 PUI Rules Team)
		http://compendium.pokegym.net/compendium-lvx.html#567
]]
