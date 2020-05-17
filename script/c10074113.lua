--Bodybuilding Dumbbells (Burning Shadows 113/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,40,aux.SelfStage1Condition)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP,aux.SelfStage1Condition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
