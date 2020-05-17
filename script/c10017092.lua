--Root Fossil (Sandstorm 92/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(40,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(40,SETNAME_FOSSIL,true,true,false))
	--poke-body (remove counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_ROOT_FOSSIL,["Stage 1"]=CARD_LILEEP,["Stage 2"]=CARD_CRADILY}
--poke-body (remove counter)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDamaged()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
end
