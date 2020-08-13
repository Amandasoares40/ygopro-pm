--Vulpix (Base Set 68/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--confused
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_R)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_VULPIX,["Stage 1"]=CARD_NINETALES}
scard.break_evolution_list={CARD_NINETALES,CARD_NINETALES_BREAK}
scard.weakness_x2={ENERGY_W}
--confused
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
