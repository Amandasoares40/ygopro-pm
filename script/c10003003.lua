--Ditto (Fossil 3/62)
--WORK IN PROGRESS: The wrong descriptions are shown for the gained attacks/effects
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--pokemon power (copy pokemon)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ACTIVE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	if not scard.global_check then
		scard.global_check=true
		--change attached energy
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg1)
		ge1:SetValue(ENERGY_ALL-ENERGY_C)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_F}
scard.resistance_30={ENERGY_P}
--pokemon power (copy pokemon)
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsActive() and not c:IsAffectedBySpecialCondition()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetActivePokemon(1-tp)
	local code=tc:GetOriginalCode()
	if not tc or c:GetFlagEffect(code)>0 then return end
	--copy name
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(code)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	--copy type
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
	e2:SetValue(tc:GetEnergyType())
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--copy hp
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SET_MAX_HP)
	e3:SetValue(tc:GetMaxHP())
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--copy retreat cost
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RETREAT_COST)
	e4:SetValue(tc:GetRetreatCost())
	e4:SetLabelObject(e3)
	tc:RegisterEffect(e4)
	--copy weakness
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_WEAKNESS_TYPE)
	e5:SetValue(tc:GetWeaknessType())
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
	local e6=e1:Clone()
	e6:SetCode(EFFECT_SET_WEAKNESS_COUNT)
	e6:SetValue(tc:GetWeaknessType())
	e6:SetLabelObject(e5)
	c:RegisterEffect(e6)
	--copy resistance
	local e7=e1:Clone()
	e7:SetCode(EFFECT_CHANGE_RESISTANCE_TYPE)
	e7:SetValue(tc:GetResistanceType())
	e7:SetLabelObject(e6)
	c:RegisterEffect(e7)
	local e8=e1:Clone()
	e8:SetCode(EFFECT_SET_RESISTANCE_COUNT)
	e8:SetValue(tc:GetResistanceCount())
	e8:SetLabelObject(e7)
	c:RegisterEffect(e8)
	--cannot evolve
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_EVOLVE)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e9:SetLabelObject(e8)
	e9:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e9)
	--copy attack & ability
	local cid=c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD,1)
	--change attached energy
	local g=c:GetAttachedGroup():Filter(scard.cefilter,nil)
	for ac in aux.Next(g) do
		ac:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
		c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_ENERGY_CHANGED)
	end
	--end effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_ADJUST)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetLabel(cid)
	e10:SetLabelObject(e9)
	e10:SetCondition(scard.rstcon(tc))
	e10:SetOperation(scard.rstop)
	Duel.RegisterEffect(e10,tp)
	c:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_COPIED_POKEMON)
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--end effect
function scard.rstcon(tc)
	return	function(e)
				local c=e:GetHandler()
				return not c:IsActive() or not tc:IsActive() or c:IsAffectedBySpecialCondition() or c:IsFacedown() or c:IsDisabled()
			end
end
function scard.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	local e9=e:GetLabelObject()
	local e8=e9:GetLabelObject()
	local e7=e8:GetLabelObject()
	local e6=e7:GetLabelObject()
	local e5=e6:GetLabelObject()
	local e4=e5:GetLabelObject()
	local e3=e4:GetLabelObject()
	local e2=e3:GetLabelObject()
	e2:Reset()
	e3:Reset()
	e4:Reset()
	e5:Reset()
	e6:Reset()
	e7:Reset()
	e8:Reset()
	e9:Reset()
	e:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,DESC_END_POKEMON_POWER)
end
--change attached energy
function scard.cefilter(c)
	return c:IsEnergy() and c:GetFlagEffect(sid)==0
end
function scard.tg1(e,c)
	return c:GetFlagEffect(sid)>0
end
