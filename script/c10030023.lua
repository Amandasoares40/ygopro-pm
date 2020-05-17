--Tropius (Dragon Frontiers 23/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_DELTA)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poke-power (remove all special conditions and marker)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PLAY)
	e1:SetCondition(aux.PlayedFromHandCondition())
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_R}
--poke-power (remove all special conditions and marker)
function scard.spcfilter(c)
	return c:IsFaceup() and c:IsPokemon()
		and (c:IsAffectedBySpecialCondition() or c:GetMarker(MARKER_IMPRISON)>0 or c:GetMarker(MARKER_SHOCKWAVE)>0)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.spcfilter,tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_REMOVESPC) then return end
	for tc in aux.Next(g) do
		tc:RemoveSpecialCondition(tp,SPC_ALL)
		local ct1=tc:GetMarker(MARKER_IMPRISON)
		local ct2=tc:GetMarker(MARKER_SHOCKWAVE)
		tc:RemoveMarker(tp,MARKER_IMPRISON,ct1,REASON_EFFECT)
		tc:RemoveMarker(tp,MARKER_SHOCKWAVE,ct2,REASON_EFFECT)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup()
	local dam=g:GetSum(Card.GetEnergyCount,nil)
	Duel.AttackDamage(e,10*dam)
end
