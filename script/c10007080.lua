--Koga's Pidgey (Gym Challenge 80/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_KOGA,SETNAME_OWNER)
	aux.AddLength(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--gain effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_L}
scard.resistance_30={ENERGY_F}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
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
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
	tc:RegisterEffect(e1)
	tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,2,0,DESC_FLIP_TO_ATTACK)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetLabelObject():GetOriginalCode())
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.NegatePokemonAttack(ev)
	end
end
