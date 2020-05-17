--Weedle (Kalos Starter Set 1/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--paralyzed
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G)
end
scard.pokemon_basic=true
scard.height=1.00
scard.evolution_list1={["Basic"]=CARD_WEEDLE,["Stage 1"]=CARD_KAKUNA,["Stage 2"]=CARD_BEEDRIL}
scard.weakness_x2={ENERGY_R}
--paralyzed
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
