--Choice Helmet (Lost Thunder 169/214)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_GX_EX2_AFTER,-30)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
