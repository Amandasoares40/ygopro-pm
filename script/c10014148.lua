--Kingdra (Aquapolis 148/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-body (get effect)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEBODY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACH)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_L)
	--discard energy
	local e3=aux.AddPokemonAttack(c,2,nil,scard.op3)
	e3:SetAttackCost(ENERGY_P,ENERGY_P,ENERGY_L,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.length=5.11
scard.evolves_from=CARD_SEADRA
scard.evolution_list1={["Basic"]=CARD_HORSEA,["Stage 1"]=CARD_SEADRA,["Stage 2"]=CARD_KINGDRA}
scard.weakness_x2={ENERGY_L}
--poke-body (get effect)
function scard.cfilter(c)
	return c:IsBasicEnergy() and c:IsPlayedFromHand()
		and c:IsEnergy(ENERGY_W+ENERGY_L+ENERGY_P)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()==1
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=e:GetLabelObject()
	local energy_type=g:GetFirst():GetEnergyType()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	--change energy type
	aux.AddTempEffectChangeEnergyType(c,c,energy_type,RESET_PHASE+PHASE_END)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,40)
	Duel.AttackDamage(e,10,e:GetHandler(),false,false)
end
--discard energy
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=0
	if c1~=RESULT_HEADS then ct=ct+1 end
	if c2~=RESULT_HEADS then ct=ct+1 end
	if ct~=RESULT_TAILS then
		Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,ct,ct,REASON_ATTACK)
	end
end
