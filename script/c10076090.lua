--Silvally-GX (Crimson Invasion 90/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (0 retreat cost)
	local e1=aux.EnableChangeRetreatCost(c,0,LOCATION_INPLAY,LOCATION_INPLAY,0,aux.TargetBoolFunction(Card.IsBasicPokemon))
	e1:SetCategory(CATEGORY_ABILITY)
	--attach
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--gx attack (damage)
	local e3=aux.AddPokemonAttack(c,1,CATEGORY_GX_ATTACK,scard.op2)
	e3:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_gx=true
scard.evolves_from=CARD_TYPE_NULL
scard.evolution_list2={["Basic"]=CARD_TYPE_NULL,["Stage 1"]=CARD_SILVALLY_GX}
scard.weakness_x2={ENERGY_F}
--attach
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetBenchedPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DPILE,0,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
	local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.Attach(e,sg2:GetFirst(),sg1)
end
--gx attack (damage)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,50*Duel.GetBenchedPokemon(1-tp):GetCount())
end
