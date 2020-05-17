--Ultimate Zone (Arceus 91/99)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--stadium
	aux.EnableStadiumAttribute(c)
	--move energy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(LOCATION_STADIUM)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--move energy
function scard.cfilter(c,tp)
	return c:GetAttachedGroup():IsExists(scard.mefilter,1,nil,tp)
end
function scard.mefilter(c,tp)
	local tc=Duel.GetActivePokemon(tp)
	return c:IsEnergy() and tc and tc:IsCode(CARD_ARCEUS) --and c:CheckAttachedTarget(tc)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetBenchedPokemon(tp):IsExists(scard.cfilter,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetBenchedPokemon(tp):Filter(scard.cfilter,nil,tp)
	if not e:GetHandler():IsRelateToEffect(e) or g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.mefilter,1,1,nil,tp)
	Duel.MoveEnergy(Duel.GetActivePokemon(tp),sg2)
end
