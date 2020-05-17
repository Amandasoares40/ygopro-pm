--Energy Link (Stormfront 83/100)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--move energy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_ENERGY_LINK_SF83,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--move energy
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttachedGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.cfilter(c,tp)
	return c:IsEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return c:GetAttachedGroup():IsExists(Card.IsCode,1,nil,sid) --and tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetAttachedGroup()
	if chk==0 then return g:IsExists(Card.IsCode,1,nil,sid) and g:IsExists(scard.cfilter,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,tc:GetAttachedTarget(),tc)
	Duel.HintSelection(sg)
	Duel.MoveEnergy(sg:GetFirst(),tc)
end
