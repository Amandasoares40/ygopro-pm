--Wide Lens (Roaring Skies 95/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--apply benched weakness
	aux.AddSingleAttachedEffect(c,EFFECT_ATTACK_WEAKNESS_BENCH)
	--apply benched resistance
	aux.AddSingleAttachedEffect(c,EFFECT_ATTACK_RESISTANCE_BENCH)
	aux.AddAttachedDescription(c,DESC_WIDE_LENS_ROS95)
end
scard.trainer_item=TYPE_POKEMON_TOOL
