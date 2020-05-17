--Team Plasma Badge (Plasma Freeze 104/116)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--add setcode
	aux.AddSingleAttachedEffect(c,EFFECT_ADD_SETCODE,SETNAME_TEAM_PLASMA,scard.con1)
	aux.AddAttachedDescription(c,DESC_TEAM_PLASMA_BADGE_PLF104,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--add setcode
function scard.con1(e)
	return not e:GetHandler():IsOriginalSetCard(SETNAME_TEAM_PLASMA)
end
