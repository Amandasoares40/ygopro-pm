--Victory Piece (Plasma Storm 130/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--ignore energy
	aux.AddSingleAttachedEffect(c,EFFECT_IGNORE_ENERGY,nil,aux.SelfCardCodeCondition(CARD_VICTINI_EX))
	aux.AddAttachedDescription(c,DESC_IGNORE_ENERGY,aux.SelfCardCodeCondition(CARD_VICTINI_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
