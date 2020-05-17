--Rocket's Hideout (Neo Revelation 63/64)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ROCKETS)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain hp
	aux.EnableUpdateHP(c,20,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--gain hp
scard.tg1=aux.TargetBoolFunction(Card.IsSetCard,SETNAME_DARK,SETNAME_ROCKETS)
