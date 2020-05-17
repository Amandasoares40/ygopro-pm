--Axew (Noble Victories 86/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.height=2.00
scard.evolution_list1={["Basic"]=CARD_AXEW,["Stage 1"]=CARD_FRAXURE,["Stage 2"]=CARD_HAXORUS}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(e,10*dam)
end
