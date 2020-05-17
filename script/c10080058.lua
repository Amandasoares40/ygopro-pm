--Blaine's Last Stand (Dragon Majesty 58/70)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BLAINE)
	--draw
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,scard.con1)
end
scard.trainer_supporter=true
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==1
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetInPlayPokemon(tp):IsExists(Card.IsEnergyType,1,nil,ENERGY_R) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetInPlayPokemon(tp):FilterCount(Card.IsEnergyType,nil,ENERGY_R)
	if ct>0 then
		Duel.Draw(tp,2*ct,REASON_EFFECT)
	end
end
