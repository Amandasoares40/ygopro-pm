--Team Aqua's Carvanha (Double Crisis 20/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_D)
end
scard.pokemon_basic=true
scard.height=2.07
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_CARVANHA,["Stage 1"]=CARD_TEAM_AQUAS_SHARPEDO}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,10*dam)
end
