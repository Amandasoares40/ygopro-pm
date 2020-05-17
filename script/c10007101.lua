--Brock's Protection (Gym Challenge 101/132)
--Not fully implemented: Prevents both players from removing Energy, instead of only the opponent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_BROCK)
	--attach trainer
	aux.EnableAttachTrainer(c,aux.FilterBoolFunction(Card.IsSetCard,SETNAME_BROCK))
	--cannot remove energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ATTACHED)
	e1:SetCode(sid)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_BROCKS_PROTECTION_G2101)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_TO_HAND)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg1)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EFFECT_CANNOT_TO_DECK)
		Duel.RegisterEffect(ge2,0)
		local ge3=ge1:Clone()
		ge3:SetCode(EFFECT_CANNOT_TO_DPILE)
		Duel.RegisterEffect(ge3,0)
		local ge4=ge1:Clone()
		ge4:SetCode(EFFECT_CANNOT_TO_LZONE)
		Duel.RegisterEffect(ge4,0)
		local ge5=ge1:Clone()
		ge5:SetCode(EFFECT_BROCKS_PROTECTION)
		Duel.RegisterEffect(ge5,0)
	end
end
scard.trainer_item=true
--cannot remove energy
function scard.tg1(e,c)
	return c:IsEnergy() and c:GetAttachedTarget():IsHasEffect(sid)
end
