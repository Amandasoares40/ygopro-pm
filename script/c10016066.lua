--Ralts (Ruby & Sapphire 66/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confused
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR}
scard.evolution_list2={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR_EX_OLD}
scard.weakness_x2={ENERGY_P}
--confused
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
