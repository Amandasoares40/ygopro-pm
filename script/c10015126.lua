--Friend Ball (Skyridge 126/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BALL)
	--search (to hand)
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--search (to hand)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetInPlayPokemon(1-tp):GetCount()>0 end
end
function scard.cfilter(c,g)
	return g:IsExists(scard.thfilter,1,nil,c:GetEnergyType())
end
function scard.thfilter(c,typ)
	return c:IsPokemon() and c:IsEnergyType(typ) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetInPlayPokemon(1-tp)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_DECK,0,0,1,nil,g1)
	if g2:GetCount()>0 then
		Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
	else
		Duel.ShuffleDeck(tp)
	end
end
