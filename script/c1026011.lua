--Team Magma's Claydol (Double Crisis 11/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (move energy)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(70))
	e2:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=4.11
scard.evolves_from=CARD_TEAM_MAGMAS_BALTOY
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_BALTOY,["Stage 1"]=CARD_TEAM_MAGMAS_CLAYDOL}
scard.weakness_x2={ENERGY_P}
--ability (move energy)
function scard.cfilter1(c,tp)
	return c:GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsBasicEnergy() and Duel.GetInPlayPokemon(tp):IsExists(scard.mefilter,1,c:GetAttachedTarget(),c)
end
function scard.mefilter(c,tc)
	return c:IsSetCard(SETNAME_TEAM_MAGMA) --and tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter1,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(tp):Filter(scard.cfilter1,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.cfilter2,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg3=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,sg1,sg2:GetFirst())
	Duel.HintSelection(sg3)
	Duel.MoveEnergy(sg3:GetFirst(),sg2)
end
