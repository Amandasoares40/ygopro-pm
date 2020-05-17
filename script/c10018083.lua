--Buffer Piece (Dragon 83/97)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,nil,2)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_AFTER,-20)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE)
end
scard.trainer_item=TYPE_POKEMON_TOOL
