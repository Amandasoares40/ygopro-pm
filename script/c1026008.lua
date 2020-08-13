--Team Aqua's Muk (Double Crisis 8/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	aux.AddHeight(c,3.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (increase retreat cost)
	local e1=aux.EnableUpdateRetreatCost(c,1,LOCATION_INPLAY,LOCATION_INPLAY,LOCATION_INPLAY,scard.tg1)
	e1:SetCategory(CATEGORY_ABILITY)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TEAM_AQUAS_GRIMER
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_GRIMER,["Stage 1"]=CARD_TEAM_AQUAS_MUK}
scard.weakness_x2={ENERGY_P}
--ability (increase retreat cost)
scard.tg1=aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SETNAME_TEAM_AQUA))
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	if Duel.GetActivePokemon(1-tp):IsAffectedBySpecialCondition() then dam=dam+60 end
	Duel.AttackDamage(e,dam)
end
