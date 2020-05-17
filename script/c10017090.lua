--Claw Fossil (Sandstorm 90/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(40,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(40,SETNAME_FOSSIL,true,true,false))
	--poke-body (add counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_DAMAGE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_CLAW_FOSSIL,["Stage 1"]=CARD_ANORITH,["Stage 2"]=CARD_ARMALDO}
--poke-body (add counter)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and rp==1-tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(1-tp):AddCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
end
