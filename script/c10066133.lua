--Assault Vest (BREAKthrough 133/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_SPENERGY_AFTER,-40)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
