--Looker Whistle (Ultra Prism 127/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--search (to hand)
	aux.PlayTrainerFunction(c,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
--search (to hand)
function scard.thfilter(c)
	return c:IsCode(CARD_LOOKER) and c:IsAbleToHand()
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
		Q. Can I use Looker Whistle to search my deck for another Looker Whistle since "Looker" is part of its name?
		A. No, you cannot. You can only search for the card named "Looker".
		(Ultra Prism FAQ; Feb 1, 2018 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#564
]]
