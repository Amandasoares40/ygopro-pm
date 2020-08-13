--Quilava (Neo Genesis 47/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_R)
	--add counter
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_CYNDAQUIL
scard.evolution_list1={["Basic"]=CARD_CYNDAQUIL,["Stage 1"]=CARD_QUILAVA,["Stage 2"]=CARD_TYPHLOSION}
scard.weakness_x2={ENERGY_W}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	local tc=Duel.GetActivePokemon(1-tp)
	if not tc then return end
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
--reduce damage
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetLabelObject():GetOriginalCode())
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.NegatePokemonAttack(ev)
	end
end
--add counter
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,30)
	if not tc:IsInPlay() or tc:GetCounter(COUNTER_CHAR)>0 then return end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:AddCounter(tp,COUNTER_CHAR,1,REASON_ATTACK)
	end
	--char check
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,3))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabelObject(tc)
	e1:SetCondition(scard.con2)
	e1:SetOperation(scard.op4)
	Duel.RegisterEffect(e1,tp)
end
--char check
function scard.con2(e)
	local tc=e:GetLabelObject()
	if tc:GetCounter(COUNTER_CHAR)>0 then
		return true
	else
		e:Reset()
		return false
	end
end
function scard.op4(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then
		e:GetLabelObject():AddCounter(tp,COUNTER_DAMAGE,2,REASON_ATTACK)
	end
end
