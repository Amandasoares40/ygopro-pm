--Crystal Wall (Boundaries Crossed 139/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--set max hp
	aux.AddSingleAttachedEffect(c,EFFECT_SET_MAX_HP,300,aux.SelfCardCodeCondition(CARD_BLACK_KYUREM_EX))
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP,aux.SelfCardCodeCondition(CARD_BLACK_KYUREM_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
--[[
	Rulings
		Q. If Crystal Wall is attached to Black Kyurem-EX, can anything raise its maximum HP beyond 300 (ike if it were
		somehow made Colorless and Aspertia City Gym is in play)?
		A. Crystal Wall essentially replaces Black Kyurem-EX's printed HP with 300, and anything to add or reduce HP would
		work accordingly. (Boundaries Crossed FAQ; Nov 8, 2012 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#278
]]
