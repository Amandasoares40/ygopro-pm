--Charizard (Base Set 4/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,5.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (change attached energy)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CHANGE_ENERGY_TYPE)
		ge1:SetTargetRange(LOCATION_ATTACHED,LOCATION_ATTACHED)
		ge1:SetTarget(scard.tg2)
		ge1:SetValue(ENERGY_R)
		Duel.RegisterEffect(ge1,0)
	end
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(100),aux.DiscardAttachedCost(Card.IsEnergy,2))
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_CHARMELEON
scard.evolution_list1={["Basic"]=CARD_CHARMANDER,["Stage 1"]=CARD_CHARMELEON,["Stage 2"]=CARD_CHARIZARD}
scard.weakness_x2={ENERGY_W}
scard.resistance_30={ENERGY_F}
--pokemon power (change attached energy)
function scard.cefilter(c)
	return c:IsEnergy() and not c:IsEnergy(ENERGY_R)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetAttachedGroup():IsExists(scard.cefilter,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=c:GetAttachedGroup():Filter(scard.cefilter,nil)
	for tc in aux.Next(g) do
		local reset_flag=RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END
		tc:RegisterFlagEffect(sid,reset_flag,0,1)
		c:RegisterFlagEffect(sid,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_ENERGY_CHANGED)
	end
end
function scard.tg2(e,c)
	return c:GetFlagEffect(sid)>0
end
