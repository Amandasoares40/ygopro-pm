--Cessation Crystal (Crystal Guardians 74/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,aux.NOT(aux.FilterBoolFunction(Card.IsPokemonex)))
	--disable poke-power
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_POKEPOWER)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsPokemon))
	c:RegisterEffect(e1)
	--disable poke-body
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DISABLE_POKEBODY)
	e2:SetCondition(scard.con2)
	c:RegisterEffect(e2)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--disable poke-power
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsActive() and not c:IsPokemonex() and c:IsHasPokePower()
end
--disable poke-body
function scard.con2(e)
	local c=e:GetHandler()
	return c:IsActive() and not c:IsPokemonex() and c:IsHasPokeBody()
end
