--Bulbasaur (Base Set 44/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.40)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--remove counter
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G,ENERGY_G)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_BULBASAUR,["Stage 1"]=CARD_IVYSAUR,["Stage 2"]=CARD_VENUSAUR}
scard.weakness_x2={ENERGY_R}
--remove counter
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.AttackDamage(e,20) and c:IsDamaged() and Duel.SelectYesNo(tp,YESNOMSG_REMOVECOUNTER) then
		c:RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_ATTACK)
	end
end
