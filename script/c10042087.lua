--Expert Belt (Arceus 87/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,20)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,20)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE)
	--increase prize
	aux.AddSingleAttachedEffect(c,EFFECT_DEFEND_UPDATE_PRIZE,1)
	aux.AddAttachedDescription(c,DESC_REDUCE_PRIZE_FROM_KO)
end
scard.trainer_item=TYPE_POKEMON_TOOL
