--Exeggcute (Jungle 52/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,1.40)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--remove counter
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_G,ENERGY_G)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_EXEGGCUTE,["Stage 1"]=CARD_EXEGGUTOR}
scard.weakness_x2={ENERGY_R}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
--remove counter
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.AttackDamage(e,20) and c:IsDamaged() and Duel.SelectYesNo(tp,YESNOMSG_REMOVECOUNTER) then
		c:RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_ATTACK)
	end
end
