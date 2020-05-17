--Team Aqua's Poochyena (Double Crisis 16/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--switch
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(20))
	e2:SetAttackCost(ENERGY_W,ENERGY_C)
end
scard.pokemon_basic=true
scard.height=1.08
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_POOCHYENA,["Stage 1"]=CARD_TEAM_AQUAS_MIGHTYENA}
scard.weakness_x2={ENERGY_F}
scard.resistance_20={ENERGY_P}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.SwitchPokemon(1-tp,1-tp)
end
