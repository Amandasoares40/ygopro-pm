--Dimension Valley (Phantom Forces 93/119)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--reduce attack cost
	aux.EnableEffectCustom(c,EFFECT_ATTACK_COST_REDUCE_C,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
end
--reduce attack cost
scard.tg1=aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_P)
--[[
	Rulings
	Q. When Dimension Valley is in play, if Mew EX uses its "Versatile" Ability to copy an attack from another Pokemon,
	will the attack's Energy cost be reduced by (C)?
	A. Yes. (Nov 13, 2014 TPCi Rules Team)

	Q. When Dimension Valley is in play, if Mew EX uses its "Versatile" Ability to copy an attack from another Psychic
	Pokemon, will the attack's Energy cost be reduced by (CC)?
	A. No. When Versatile copies the attack it uses the original attack cost regardless of the opponent's Pokemon's type,
	and then Dimension Valley reduces the cost by (C) since Mew EX is Psychic. (Nov 20, 2014 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#364
]]
