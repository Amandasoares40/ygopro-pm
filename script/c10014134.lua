--Super Energy Removal 2 (Aquapolis 134/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard energy
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.defilter,0,LOCATION_INPLAY),scard.op1)
end
scard.trainer_item=true
--discard energy
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetActivePokemon(1-tp)
	if chk==0 then return tc and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		local tc=Duel.GetActivePokemon(1-tp)
		local g=tc:GetAttachedGroup():Filter(Card.IsEnergy,nil)
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	elseif c1+c2==RESULT_TAILS then
		local tc=Duel.GetActivePokemon(tp)
		local g=tc:GetAttachedGroup():Filter(Card.IsEnergy,nil)
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	end
end
