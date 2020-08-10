--Computer Error (Black Star Promo Wizards of the Coast 16)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, end turn
	aux.PlayTrainerFunction(c,nil,scard.op1)
end
scard.trainer_rockets_secret_machine=true
--draw, end turn
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DrawUpTo(tp,5,REASON_EFFECT)
	Duel.DrawUpTo(1-tp,5,REASON_EFFECT)
	Duel.EndTurn()
end
--[[
	Rulings
	Q. With Computer Error, do you have to announce up front how many cards you're going to draw? Or can you draw one at a
	time & stop at your own choosing?
	A. You must announce up front how many you will draw and then draw that many. (Jul 6, 2000 WotC Chat, Q19)

	Q. On May 18 2000 you said when asked about drawing zero cards using Computer Error, "Nope you must declare from 1 to
	5 cards, and then draw that many". I just wanted to clarify if this is still correct or if zero cards is an option.
	Thanks.
	A. 0 is an acceptable amount to call. That's one of those ones where we just answered as though the player wouldn't
	have played the card unless they wanted to at least draw one card. Certainly they can draw zero cards if they want.
	(Aug 9, 2001 WotC Chat, Q279)
	https://compendium.pokegym.net/compendium.html#trainers
]]
