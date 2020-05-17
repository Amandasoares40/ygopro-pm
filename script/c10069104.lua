--Mega Catcher (Fates Collide 104/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--switch
	aux.PlayTrainerFunction(c,scard.tg1,scard.op1)
end
scard.trainer_item=true
--switch
scard.tg1=aux.SwitchTarget(PLAYER_OPPO,nil,Card.IsMegaEvolution)
scard.op1=aux.SwitchOperation(PLAYER_SELF,PLAYER_OPPO,nil,Card.IsMegaEvolution)
