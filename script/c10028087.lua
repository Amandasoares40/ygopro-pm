--Holon Lake (Holon Phantoms 87/110)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA,SETNAME_HOLON)
	--stadium
	aux.EnableStadiumAttribute(c)
	--gain attack (search - to hand)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_ATTACK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetAttackCost(ENERGY_C)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_STADIUM)
	e2:SetTargetRange(LOCATION_INPLAY,LOCATION_INPLAY)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,SETNAME_DELTA))
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--gain attack (search - to hand)
function scard.thfilter(c)
	return c:IsPokemon() and c:IsSetCard(SETNAME_DELTA) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.ShuffleDeck(tp)
	end
end
