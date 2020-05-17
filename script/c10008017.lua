--Typhlosion (Neo Genesis 17/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R,ENERGY_R,ENERGY_R)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.length=5.70
scard.evolves_from=CARD_QUILAVA
scard.evolution_list1={["Basic"]=CARD_CYNDAQUIL,["Stage 1"]=CARD_QUILAVA,["Stage 2"]=CARD_TYPHLOSION}
scard.weakness_x2={ENERGY_W}
--pokemon power (attach)
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_R) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return c:IsEnergyType(ENERGY_R) and tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_DPILE,0,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DPILE,0,nil,tp)
	if g:GetCount()==0 or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
	local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.Attach(e,sg2:GetFirst(),sg1)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local self_damage=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		dam=dam+20
		self_damage=true
	end
	Duel.AttackDamage(e,dam)
	if self_damage then Duel.AttackDamage(e,20,e:GetHandler()) end
end
