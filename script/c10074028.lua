--Alolan Ninetales (Burning Shadows 28/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ALOLAN)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (immune to attacks)
	local e1=aux.EnableEffectImmune(c,scard.val1,LOCATION_INPLAY)
	e1:SetCategory(CATEGORY_ABILITY)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(80))
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=3.07
scard.evolves_from=CARD_ALOLAN_VULPIX
scard.evolution_list1={["Basic"]=CARD_ALOLAN_VULPIX,["Stage 1"]=CARD_ALOLAN_NINETALES}
scard.weakness_x2={ENERGY_M}
--ability (immune to attacks)
function scard.val1(e,te)
	local tc=te:GetHandler()
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK)
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer() and (tc:IsPokemonGX() or tc:IsPokemonEX())
end
