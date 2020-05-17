--Switch (Celestial Storm 147/168) (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,aux.SwitchTarget(PLAYER_SELF),aux.SwitchOperation(PLAYER_SELF,PLAYER_SELF))
end
scard.trainer_item=true
