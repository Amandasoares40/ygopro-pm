--Zygarde-GX (Forbidden Light 73/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--attach
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(130))
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C,ENERGY_C)
	--gx attack (get effect)
	local e3=aux.AddPokemonAttack(c,2,CATEGORY_GX_ATTACK,scard.op2)
	e3:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_gx=true
scard.weakness_x2={ENERGY_G}
--attach
function scard.atfilter(c,tc)
	return c:IsEnergy(ENERGY_F) and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,50)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DPILE,0,2,2,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	end
end
--gx attack (get effect)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	local c=e:GetHandler()
	--immune to attack damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_IMMUNE_ATTACK_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_ATTACK_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCondition(scard.con1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	c:RegisterEffect(e1)
end
--immune to attack damage
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	local tc=(Duel.GetTurnPlayer()==tp and Duel.GetActivePokemon(tp) or Duel.GetActivePokemon(1-tp))
	return tc:IsPokemonGX() or tc:IsPokemonEX()
end
