--Team Aqua's Spheal (Double Crisis 3/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_W)
end
scard.pokemon_basic=true
scard.height=2.07
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_SPHEAL,["Stage 1"]=CARD_TEAM_AQUAS_SEALEO,["Stage 2"]=CARD_TEAM_AQUAS_WALREIN}
scard.weakness_x2={ENERGY_M}
