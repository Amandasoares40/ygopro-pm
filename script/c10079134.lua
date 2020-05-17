--Hustle Belt (Celestial Storm 134/168)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,60,scard.con1)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--increase damage
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsRemainingHPBelow(30) and c:IsDamaged()
end
