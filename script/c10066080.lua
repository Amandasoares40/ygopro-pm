--Swinub (BREAKthrough 80/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(40))
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_SWINUB,["Stage 1"]=CARD_PILOSWINE,["Stage 2"]=CARD_MAMOSWINE}
scard.weakness_x2={ENERGY_G}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
