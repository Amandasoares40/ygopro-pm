--Team Aqua's Grimer (Double Crisis 7/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_P)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(30))
	e2:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.11
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_GRIMER,["Stage 1"]=CARD_TEAM_AQUAS_MUK}
scard.weakness_x2={ENERGY_P}
