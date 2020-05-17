--Burning Energy (BREAKthrough 151/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_R))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_R,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_R))
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_DPILE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.energy_special=true
--attach
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if re then e:SetLabelObject(re:GetHandler()) end
	return c:IsReason(REASON_ATTACK) and c:IsPreviousLocation(LOCATION_ATTACHED)
		and re and not re:GetHandler():IsStatus(STATUS_KNOCK_OUT_CONFIRMED)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	if tc then
		Duel.Attach(e,tc,c)
	end
end
