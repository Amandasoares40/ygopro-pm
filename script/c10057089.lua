--Silver Mirror (Plasma Blast 89/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to attacks
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_EFFECT,scard.val1,aux.NOT(aux.SelfPokemonEXCondition))
	aux.AddAttachedDescription(c,DESC_SILVER_MIRROR_PLB89,aux.NOT(aux.SelfPokemonEXCondition))
end
scard.trainer_item=TYPE_POKEMON_TOOL
--immune to attacks
function scard.val1(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK)
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetHandler():IsSetCard(SETNAME_TEAM_PLASMA)
end
