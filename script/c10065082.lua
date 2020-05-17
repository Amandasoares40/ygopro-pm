--Dangerous Energy (Ancient Origins 82/98)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--energy
	aux.EnableEnergyAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_D))
	--provide energy
	aux.EnableProvideEnergy(c,ENERGY_D,1,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_D))
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_RETALIATE_DAMAGE,scard.con2)
end
scard.energy_special=true
--add counter
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsActive() and c:IsEnergyType(ENERGY_D) and rp==1-tp and Duel.GetActivePokemon(1-tp):IsPokemonEX()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	if tc:IsPokemonEX() then
		tc:AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	end
end
function scard.con2(e)
	local c=e:GetHandler()
	return c:IsActive() and c:IsEnergyType(ENERGY_D) and Duel.GetActivePokemon(1-c:GetControler()):IsPokemonEX()
end
