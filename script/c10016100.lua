--Magmar ex (Ruby & Sapphire 100/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--get effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R)
	--burned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex_old=true
scard.weakness_x2={ENERGY_W}
--get effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if not tc:IsInPlay() then return end
	local c=e:GetHandler()
	--reduce damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetLabelObject(c)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op3)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
	tc:RegisterEffect(e1)
	tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,2,0,DESC_FLIP_TO_ATTACK)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetLabelObject():GetOriginalCode())
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.NegatePokemonAttack(ev)
	end
end
--burned
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,40)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_BURNED)
	end
end
