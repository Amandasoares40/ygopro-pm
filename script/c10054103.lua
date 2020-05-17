--White Kyurem-EX (Boundaries Crossed 103/149)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
	--discard energy, burned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_W,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_N}
--attach
function scard.atfilter(c,tc)
	return c:IsBasicEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	local g=Duel.GetMatchingGroup(scard.atfilter,tp,LOCATION_DPILE,0,nil,e:GetHandler())
	if g:GetCount()==0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg=g:Select(tp,1,1,nil)
	Duel.Attach(e,e:GetHandler(),sg)
end
--discard energy, burned
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,150)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,2,2,REASON_ATTACK,nil,ENERGY_R)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_BURNED)
	end
end
