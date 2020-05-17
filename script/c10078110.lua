--Lysandre Prism Star (Forbidden Light 110/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--to lost zone
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(Card.IsAbleToLost,0,LOCATION_DPILE),scard.op1)
end
scard.trainer_supporter=true
--to lost zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetInPlayPokemon(tp):FilterCount(Card.IsEnergyType,nil,ENERGY_R)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOLZONE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToLost,tp,0,LOCATION_DPILE,ct,ct,nil)
	if g:GetCount()>0 then
		Duel.SendtoLost(g,REASON_EFFECT)
	end
end
