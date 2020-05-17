--Delinquent (BREAKpoint 98/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard stadium, discard hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(nil,LOCATION_INPLAY,LOCATION_INPLAY),scard.op1)
end
scard.trainer_supporter=true
--discard stadium, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendtoDPile(Duel.GetStadiumCard(),REASON_EFFECT+REASON_DISCARD)>0 then
		Duel.DiscardHand(1-tp,nil,3,3,REASON_EFFECT+REASON_DISCARD)
	end
end
--[[
	Rulings
		Q. Can I use the effect of a Stadium like Rough Seas, then play Delinquent to remove the Stadium, then play
		another Stadium of the same name as the original and use its effect too?
		A. Yes, that is permissible. (Feb 25, 2016 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#455
]]
