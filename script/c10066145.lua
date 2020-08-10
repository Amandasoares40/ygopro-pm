--Parallel City (BREAKthrough 145/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (limit bench or gain effect)
	aux.EnableStadiumAttribute(c,true,scard.op1,scard.op2)
end
--choose one (limit bench or gain effect)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	scard.play(c,tp,tp)
	scard.disable_zone(e,c,tp)
	scard.reduce_damage(c,1-tp)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	scard.play(c,tp,1-tp)
	scard.disable_zone(e,c,1-tp)
	scard.reduce_damage(c,tp)
end
function scard.play(c,tp,player)
	local sc=Duel.GetStadiumCard(player)
	if sc then
		Duel.SendtoDPile(sc,REASON_EFFECT+REASON_DISCARD)
		Duel.BreakEffect()
	end
	Duel.MoveToField(c,tp,player,LOCATION_SZONE,POS_FACEUP,true)
end
function scard.disable_zone(e,c,player)
	local g=Duel.GetBenchedPokemon(player)
	local ct=g:GetCount()-3
	if g:GetCount()>3 then
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
		local sg=g:Select(player,ct,ct,nil)
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	end
	local dis=Duel.SelectDisableBenchZone(player,3)
	e:SetLabel(dis)
	--limit bench
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetOperation(scard.op3)
	e1:SetLabel(dis)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function scard.op3(e,tp)
	return e:GetLabel()
end
function scard.reduce_damage(c,player)
	local s_range=(player==1-player and 0 or LOCATION_INPLAY)
	local o_range=(player==1-player and LOCATION_INPLAY or 0)
	--reduce damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK_BEFORE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(s_range,o_range)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsEnergyType,ENERGY_G+ENERGY_R+ENERGY_W))
	e1:SetValue(-20)
	Duel.RegisterEffect(e1,player)
end
