--Mysterious Shard (Crystal Guardians 81/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.NOT(aux.FilterBoolFunction(Card.IsPokemonex)),2)
	--immune to attacks
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT,scard.val1,aux.NOT(aux.SelfPokemonexCondition))
	aux.AddAttachedDescription(c,DESC_MYSTERIOUS_SHARD_CG81,aux.NOT(aux.SelfPokemonexCondition))
end
scard.trainer_item=TYPE_POKEMON_TOOL
--immune to attacks
function scard.val1(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK)
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetHandler():IsPokemonex()
end
