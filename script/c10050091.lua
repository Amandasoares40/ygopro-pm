--Eviolite (Noble Victories 91/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_AFTER,-20,aux.SelfBasicPokemonCondition)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,aux.SelfBasicPokemonCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
