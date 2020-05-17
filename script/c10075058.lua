--Damage Mover (Shining Legends 58/73)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--move counter
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--move counter
function scard.cfilter(c,tp)
	return c:IsDamaged() and Duel.GetInPlayPokemon(tp):IsExists(aux.TRUE,1,c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp)
	if g:FilterCount(scard.cfilter,nil,tp)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local sg1=g:FilterSelect(tp,Card.IsDamaged,1,1,nil)
	Duel.HintSelection(sg1)
	local tc=sg1:GetFirst()
	local ct=tc:GetCounter(COUNTER_DAMAGE)
	if ct>3 then ct=3 end
	tc:RemoveCounter(tp,COUNTER_DAMAGE,ct,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVECOUNTERTO)
	local sg2=g:Select(tp,1,1,tc)
	Duel.HintSelection(sg2)
	sg2:GetFirst():AddCounter(tp,COUNTER_DAMAGE,ct,REASON_EFFECT)
end
