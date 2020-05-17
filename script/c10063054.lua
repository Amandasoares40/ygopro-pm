--Kyogre-EX (Primal Clash 54/160)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--asleep
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
	--return
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_KYOGRE_EX,CARD_PRIMAL_KYOGRE_EX}
scard.weakness_x2={ENERGY_G}
--asleep
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
--return
function scard.retfilter(c)
	return c:IsEnergy(ENERGY_W) and c:IsAbleToHand()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,140)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=e:GetHandler():GetAttachedGroup():FilterSelect(tp,scard.retfilter,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
	Duel.ConfirmCards(1-tp,g)
end
