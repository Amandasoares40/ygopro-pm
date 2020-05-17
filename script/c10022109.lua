--Treecko Star (Team Rocket Returns 109/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--poisoned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_G,ENERGY_G)
end
scard.pokemon_basic=true
scard.pokemon_star=true
scard.evolution_list1={["Basic"]=CARD_TREECKO,["Stage 1"]=CARD_GROVYLE,["Stage 2"]=CARD_SCEPTILE}
scard.weakness_x2={ENERGY_R}
scard.resistance_30={ENERGY_W}
--poisoned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeCount(1-tp)==1 then dam=dam+50 end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and Duel.GetPrizeCount(1-tp)==1 then
		tc:ApplySpecialCondition(tp,SPC_POISONED)
	end
end
