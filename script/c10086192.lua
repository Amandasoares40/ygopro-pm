--Great Catcher (Cosmic Eclipse 192/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1,nil,aux.DiscardHandCost(2))
end
scard.trainer_item=true
--switch
function scard.swfilter(c)
	return c:IsPokemonGX() or c:IsPokemonEX()
end
scard.tg1=aux.SwitchTarget(PLAYER_OPPO,nil,scard.swfilter)
scard.op1=aux.SwitchOperation(PLAYER_SELF,PLAYER_OPPO,nil,scard.swfilter)
