--Protective Orb (Unseen Forces 90/115)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,scard.toolfilter)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS,nil,scard.con1)
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--pokemon tool
function scard.toolfilter(c)
	return c:IsEvolved() and not c:IsPokemonex()
end
--no weakness
function scard.con1(e)
	return scard.toolfilter(e:GetHandler())
end
