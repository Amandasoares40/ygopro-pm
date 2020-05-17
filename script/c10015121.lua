--Apricorn Maker (Skyridge 121/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_supporter=true
--search (to hand)
function scard.thfilter(c)
	return c:IsItem() and c:IsSetCard(SETNAME_BALL) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
--[[
	Rulings
		Q. Can Apricorn Maker be used to search for the Trainer "Bursting Balloon"? Taking the card literally, Bursting
		*BALL*oon contains the exact same "Ball" as given on Apricorn Maker.
		A. Of course not, don't be silly! You can only search for cards like Poke Ball, Ultra Ball, Beast Ball, etc.
		(Celestial Storm FAQ; Aug 2, 2018 TPCi Rules Team)

		Q. Can Apricorn Maker be used to search for "Maxie's Hidden Ball Trick" since it has the word "Ball" in its name?
		A. Nope, Maxie's Hidden Ball Trick is a Supporter, not an Item card.
		(Celestial Storm FAQ; Aug 2, 2018 TPCi Rules Team)
		http://compendium.pokegym.net/compendium-bw.html#608
]]
