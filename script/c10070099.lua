--Captivating Poke Puff (Steam Siege 99/114)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm hand, to bench
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--confirm hand, to bench
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(1-tp) and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if Duel.IsBenchFull(1-tp) or g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	if g:FilterCount(scard.tbfilter,nil,e,tp)>0 and Duel.SelectYesNo(tp,YESNOMSG_TOBENCH) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
		local sg=g:FilterSelect(tp,scard.tbfilter,1,Duel.GetFreeBenchCount(1-tp),nil,e,tp)
		Duel.PlayPokemon(sg,0,tp,1-tp,true,false,POS_FACEUP_UPSIDE)
	end
	Duel.ShuffleHand(1-tp)
end
--[[
	Rulings
	Q. If I use Captivating Poke Puff and put one of my opponent's Basic Pokemon on the bench that has an Ability (like
	Shaymin EX's "Setup"), does the opponent get to use that Ability right away?
	A. No, Captivating Poke Puff does not trigger any coming into play Abilities.
	(Steam Siege FAQ; Aug 4, 2016 TPCi Rules Team)

	Q. If I play Captivating Poke Puff and find a Pokemon with the Omega Barrier Ancient Trait in my opponent's hand, can
	I choose that Pokemon to be benched or does Omega Barrier block the Captivating Poke Puff?
	A. Yes, you can put that Pokemon onto the Bench. Ancient Traits are only active when that Pokemon is in play.
	(Mar 30, 2017 TPCi Rules Team)

	Q. Captivating Poke Puff says to put any number of Basic Pokemon you find in your opponent's hand onto their Bench.
	Does this allow you to put more than 5 Pokemon on the bench?
	A. No, Captivating Poke Puff does not allow you to exceed the normal limits of the game. You can put any number of
	Basic Pokemon onto your opponent's Bench up to the maximum size of the Bench.
	(Steam Siege FAQ; Aug 4, 2016 TPCi Rules Team)

	Q. When using Captivating Poke Puff can I choose to NOT put any Basic Pokemon onto my opponent's bench, or do I have
	to put at least one down if I'm able to?
	A. No, you don't have to put any Basic Pokemon onto your opponent's bench if you don't want to.
	(Aug 11, 2016 TPCi Rules Team)

	Q. Can you play Captivating Poke Puff if your opponent's Bench is full?
	A. No. It’s public knowledge that you can’t put down any additional Basic Pokemon on your opponent’s Bench, so you
	cannot play the card. (Aug 11, 2016 TPCi Rules Team; Aug 3, 2017 TPCi Rules Team)

	Q. Can you play Captivating Poke Puff if your opponent has no cards in their hand?
	A. No, you cannot. You cannot play a Trainer card for no net effect. (Aug 11, 2016 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#476
]]
