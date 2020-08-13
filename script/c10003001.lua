--Aerodactyl (Fossil 1/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,5.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (cannot play evolution)
	local e1=aux.EnablePlayerEffectCustom(c,EFFECT_CANNOT_PLAY_POKEMON,LOCATION_INPLAY,1,1,scard.tg1,scard.con1)
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	--damage
	local e2=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_restored=true
scard.evolves_from=CARD_MYSTERIOUS_FOSSIL
scard.evolution_list1={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_AERODACTYL}
scard.weakness_x2={ENERGY_G}
scard.resistance_30={ENERGY_F}
--pokemon power (cannot play evolution)
scard.con1=aux.NotAffectedBySpecialCondition
function scard.tg1(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_EVOLVE)==SUMMON_TYPE_EVOLVE
end
