--Ampharos (Dragon Frontiers 1/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-body (add setcode)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetTargetRange(LOCATION_DECK+LOCATION_DPILE+LOCATION_HAND+LOCATION_INPLAY,0)
	e1:SetTarget(scard.tg1)
	e1:SetValue(SETNAME_DELTA)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_FLAAFFY
scard.evolution_list1={["Baby"]=CARD_MAREEP,["Basic"]=CARD_FLAAFFY,["Stage 1"]=CARD_AMPHAROS}
scard.weakness_x2={ENERGY_F}
--poke-body (add setcode)
function scard.tg1(e,c)
	return c:IsBasicPokemon() or c:IsEvolution()
end
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetInPlayPokemon(tp):FilterCount(Card.IsSetCard,nil,SETNAME_DELTA)*10
	Duel.AttackDamage(e,20+dam)
end
