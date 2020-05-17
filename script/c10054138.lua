--Crystal Edge (Boundaries Crossed 138/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,50,aux.SelfCardCodeCondition(CARD_WHITE_KYUREM_EX))
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfCardCodeCondition(CARD_WHITE_KYUREM_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
