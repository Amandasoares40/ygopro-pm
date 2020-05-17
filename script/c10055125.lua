--Team Plasma Grunt (Plasma Storm 125/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--draw
	aux.PlayTrainerFunction(c,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,4),nil,aux.DiscardHandCost(1,1,Card.IsSetCard,SETNAME_TEAM_PLASMA))
end
scard.trainer_supporter=true
