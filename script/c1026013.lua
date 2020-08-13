--Team Magma's Lairon (Double Crisis 13/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	aux.AddHeight(c,2.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TEAM_MAGMAS_ARON
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_ARON,["Stage 1"]=CARD_TEAM_MAGMAS_LAIRON,["Stage 2"]=CARD_TEAM_MAGMAS_AGGRON}
scard.weakness_x2={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	Duel.AttackDamage(e,10,e:GetHandler())
end
