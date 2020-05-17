--Thunder Mountain Prism Star (Lost Thunder 191/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce attack cost
	aux.EnableEffectCustom(c,EFFECT_ATTACK_COST_REDUCE_L,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	--immune to effects
	aux.EnableEffectImmune(c,scard.val1,LOCATION_STADIUM)
end
--reduce attack cost
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_L)
--immune to effects
function scard.val1(e,te)
	local tc=te:GetHandler()
	return te:IsActivated() and (tc:IsItem() or tc:IsSupporter())
end
