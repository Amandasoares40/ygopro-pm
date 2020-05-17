--Energy Root (Unseen Forces 83/115)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,scard.toolfilter)
	--gain hp
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_MAX_HP,20,scard.con1)
	aux.AddAttachedDescription(c,DESC_MAX_HP_UP,scard.con1)
	--disable poke-power
	aux.AddSingleAttachedEffect(c,EFFECT_DISABLE_POKEPOWER,nil,scard.con2)
	aux.AddAttachedDescription(c,DESC_CANNOT_USE_POKEPOWER,scard.con2)
	--disable poke-body
	aux.AddSingleAttachedEffect(c,EFFECT_DISABLE_POKEBODY,nil,scard.con3)
	aux.AddAttachedDescription(c,DESC_CANNOT_USE_POKEBODY,scard.con3)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--pokemon tool
function scard.toolfilter(c)
	return not c:IsPokemonex() and not c:IsSetCard(SETNAME_DARK) and not c:IsOwnersPokemon()
end
--gain hp
function scard.con1(e)
	return scard.toolfilter(e:GetHandler())
end
--disable poke-power
function scard.con2(e)
	return scard.toolfilter(e:GetHandler()) and e:GetHandler():IsHasPokePower()
end
--disable poke-body
function scard.con3(e)
	return scard.toolfilter(e:GetHandler()) and e:GetHandler():IsHasPokeBody()
end
