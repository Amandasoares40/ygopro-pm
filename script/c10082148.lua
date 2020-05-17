--Metal Goggles (Team Up 148/181)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_AFTER,-30,aux.SelfEnergyTypeCondition(ENERGY_M))
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,aux.SelfEnergyTypeCondition(ENERGY_M))
	--cannot add counter
	aux.AddSingleAttachedEffect(c,EFFECT_METAL_GOGGLES,nil,aux.SelfEnergyTypeCondition(ENERGY_M))
	aux.AddAttachedDescription(c,DESC_METAL_GOGGLES_TEU148,aux.SelfEnergyTypeCondition(ENERGY_M))
end
scard.trainer_item=TYPE_POKEMON_TOOL
