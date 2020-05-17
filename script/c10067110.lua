--Reverse Valley (BREAKpoint 110/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (reduce damage or increase damage)
	aux.EnableStadiumAttribute(c,true,scard.op1,scard.op2)
end
--choose one (reduce damage or increase damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	scard.play(c,tp,tp)
	scard.reduce_damage(c,tp)
	scard.increase_damage(c,1-tp)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	scard.play(c,tp,1-tp)
	scard.reduce_damage(c,1-tp)
	scard.increase_damage(c,tp)
end
function scard.play(c,tp,player)
	local sc=Duel.GetStadiumCard(player)
	if sc then
		Duel.SendtoDPile(sc,REASON_EFFECT+REASON_DISCARD)
		Duel.BreakEffect()
	end
	Duel.MoveToField(c,tp,player,LOCATION_SZONE,POS_FACEUP,true)
end
function scard.reduce_damage(c,player)
	local s_range=(player==1-player and 0 or LOCATION_INPLAY)
	local o_range=(player==1-player and LOCATION_INPLAY or 0)
	--reduce damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_DEFEND_OPPO_AFTER)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(s_range,o_range)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_M))
	e1:SetValue(-10)
	Duel.RegisterEffect(e1,player)
end
function scard.increase_damage(c,player)
	local s_range=(player==1-player and 0 or LOCATION_INPLAY)
	local o_range=(player==1-player and LOCATION_INPLAY or 0)
	--increase damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(s_range,o_range)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_D))
	e1:SetValue(10)
	Duel.RegisterEffect(e1,player)
end
