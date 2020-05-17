--Mewtwo-EX (Evolutions 52/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--heal
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P)
	--damage
	local e3=aux.AddPokemonAttack(c,2,nil,aux.AttackDamageOperation(110))
	e3:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.mega_evolution_list={CARD_MEWTWO_EX,CARD_M_MEWTWO_EX}
scard.weakness_x2={ENERGY_P}
--attach
function scard.atfilter(c,tc)
	return c:IsEnergy() and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DPILE,0,1,1,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	end
end
--heal
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.HealDamage(tp,e:GetHandler(),60,REASON_ATTACK)
end
