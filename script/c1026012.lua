--Team Magma's Aron (Double Crisis 12/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_F)
end
scard.pokemon_basic=true
scard.height=1.04
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_ARON,["Stage 1"]=CARD_TEAM_MAGMAS_LAIRON,["Stage 2"]=CARD_TEAM_MAGMAS_AGGRON}
scard.weakness_x2={ENERGY_G}
