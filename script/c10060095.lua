--Protection Cube (Flashfire 95/106)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to attack damage
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_ATTACK_DAMAGE_SELF)
	aux.AddAttachedDescription(c,DESC_PROTECTION_CUBE_FLF95)
end
scard.trainer_item=TYPE_POKEMON_TOOL
