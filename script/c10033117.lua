--Skull Fossil (Mysterious Treasures 117/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FOSSIL)
	--play trainer as pokemon
	aux.PlayTrainerFunction(c,aux.PlayTrainerPokemonTarget(50,SETNAME_FOSSIL),aux.PlayTrainerPokemonOperation(50,SETNAME_FOSSIL,true,true,false))
	--poke-body (add counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_KNOCKED_OUT)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.trainer_item=true
scard.evolution_list1={["Basic"]=CARD_SKULL_FOSSIL,["Stage 1"]=CARD_CRANIDOS,["Stage 2"]=CARD_RAMPARDOS}
--poke-body (add counter)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsReason(REASON_ATTACK+REASON_DAMAGE)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then ct=ct+1 end
	until res==RESULT_TAILS
	if ct>0 then
		Duel.GetActivePokemon(1-tp):AddCounter(tp,COUNTER_DAMAGE,ct,REASON_EFFECT)
	end
end
