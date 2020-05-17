--Scramble Switch (Plasma Storm 129/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch, move energy
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_SELF),scard.op1)
end
scard.trainer_item=true
scard.trainer_ace_spec=true
--switch, move energy
function scard.mefilter(c,tc)
	return c:IsEnergy() --and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetActivePokemon(tp):GetAttachedGroup()
	if not Duel.SwitchPokemon(tp,tp) then return end
	local tc=Duel.GetActivePokemon(tp)
	g=g:Filter(scard.mefilter,nil,tc)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_REMOVEENERGY) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg=g:Select(tp,1,g:GetCount(),nil)
	Duel.BreakEffect()
	Duel.MoveEnergy(tc,sg)
end
