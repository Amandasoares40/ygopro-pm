--U-Turn Board (Unified Minds 211/236)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce retreat cost
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_RETREAT_COST,-1)
	aux.AddAttachedDescription(c,DESC_RETREAT_COST_CHANGED)
	if not scard.global_check then
		scard.global_check=true
		--redirect (return)
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_TO_DPILE_REDIRECT)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(aux.TargetBoolFunction(Card.IsCode,sid))
		ge1:SetValue(LOCATION_HAND)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.trainer_item=TYPE_POKEMON_TOOL
