--Team Magma's Mightyena (Double Crisis 19/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=3.03
scard.evolves_from=CARD_TEAM_MAGMAS_POOCHYENA
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_POOCHYENA,["Stage 1"]=CARD_TEAM_MAGMAS_MIGHTYENA}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=80
	if Duel.GetActivePokemon(1-tp):IsSetCard(SETNAME_TEAM_AQUA) then dam=dam+40 end
	Duel.AttackDamage(e,dam)
end
