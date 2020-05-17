--Cinnabar City Gym (Gym Challenge 113/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--ignore weakness
	aux.EnableEffectCustom(c,EFFECT_IGNORE_WEAKNESS,LOCATION_STADIUM,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1,scard.con1)
end
--ignore weakness
function scard.con1(e)
	local tc=Duel.GetActivePokemon(Duel.GetTurnPlayer())
	return tc and tc:IsEnergyType(ENERGY_W)
end
function scard.tg1(e,c)
	return c:IsSetCard(SETNAME_BLAINE) and c:IsWeaknessType(ENERGY_W)
end
