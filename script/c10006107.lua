--Celadon City Gym (Gym Heroes 107/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--remove all special conditions
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetCost(scard.cost1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--remove all special conditions
function scard.spcfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(SETNAME_ERIKA)
		and c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and c:IsAffectedBySpecialCondition()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.spcfilter,tp,LOCATION_INPLAY,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARDFROM)
	local g=Duel.SelectMatchingCard(tp,scard.spcfilter,tp,LOCATION_INPLAY,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:GetFirst():GetAttachedGroup():FilterSelect(tp,Card.IsEnergy,1,1,nil)
	Duel.SendtoDPile(sg,REASON_COST+REASON_DISCARD)
	g:KeepAlive()
	e:SetLabelObject(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if e:GetHandler():IsRelateToEffect(e) then
		g:GetFirst():RemoveSpecialCondition(tp,SPC_ALL)
	end
end
