--Dialga G (Platinum 7/127)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	--cannot play trainer
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(DESC_PLAYER_CANNOT_PLAY_TRAINER)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetCondition(scard.con1)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
--cannot play trainer
function scard.con1(e)
	return e:GetLabel()~=Duel.GetTurnCount()
end
function scard.val1(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAINER)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.GetActivePokemon(1-tp):GetCounter(COUNTER_DAMAGE)>=2 then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
