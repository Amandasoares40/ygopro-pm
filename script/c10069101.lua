--Fossil Excavation Kit (Fates Collide 101/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--to hand
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.thfilter,LOCATION_DPILE,0),scard.op1)
end
scard.trainer_item=true
--to hand
function scard.thfilter(c)
	return c:IsCode(CARD_HELIX_FOSSIL_OMANYTE,CARD_DOME_FOSSIL_KABUTO,CARD_OLD_AMBER_AERODACTYL) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
