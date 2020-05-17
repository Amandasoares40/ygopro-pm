--Plasma Frigate (Plasma Storm 124/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--stadium
	aux.EnableStadiumAttribute(c)
	--no weakness
	aux.EnableEffectCustom(c,EFFECT_NO_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--no weakness
function scard.tg1(e,c)
	return c:GetAttachedGroup():IsExists(Card.IsCode,1,nil,CARD_PLASMA_ENERGY)
end
