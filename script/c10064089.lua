--Sky Field (Roaring Skies 89/108)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--extend bench
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTEND_BENCH)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTargetRange(1,1)
	e1:SetValue(8)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op1)
	e2:SetLabel(8)
	Duel.RegisterEffect(e2,0)
	local e3=e2:Clone()
	e3:SetLabel(12)
	Duel.RegisterEffect(e3,0)
	--discard pokemon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(sid,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(scard.op2)
	c:RegisterEffect(e4)
end
--extend bench
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_STADIUM) and c:IsFaceup()
end
function scard.op1(e)
	return bit.lshift(0x1,e:GetLabel())
end
--discard pokemon
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	scard.discard(c:GetOwner())
	scard.discard(1-c:GetOwner())
end
function scard.discard(tp)
	local ct=Duel.GetBenchedPokemon():GetCount()
	if ct<=5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.GetBenchedPokemon(tp):Select(tp,ct-5,ct-5,nil)
	if g:GetCount()>0 then
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	end
end
