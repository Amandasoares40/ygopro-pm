--Giovanni (Gym Challenge 18/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_GIOVANNI)
	--get effect
	aux.PlayTrainerFunction(c,aux.CheckCardFunction(scard.cfilter,LOCATION_INPLAY,0),scard.op1)
end
scard.trainer_item=true
--get effect
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(SETNAME_GIOVANNI)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_APPLYEFFECTTO)
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	--evolve turn played
	aux.AddTempEffectCustom(c,tc,DESC_EVOLVE_TURN,EFFECT_EVOLVE_PLAY_TURN,RESET_PHASE+PHASE_END)
	--evolve first turn
	aux.AddTempEffectCustom(c,tc,DESC_EVOLVE_FIRST_TURN,EFFECT_EVOLVE_FIRST_TURN,RESET_PHASE+PHASE_END)
end
