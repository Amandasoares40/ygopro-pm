--Fighting Fury Belt (BREAKpoint 99/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,40,aux.SelfBasicPokemonCondition)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP,aux.SelfBasicPokemonCondition)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,10,aux.SelfBasicPokemonCondition)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfBasicPokemonCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
