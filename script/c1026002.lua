--Team Magma's Camerupt (Double Crisis 2/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(aux.CheckCardFunction(scard.atfilter,LOCATION_DPILE,0,1,nil,c))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--move energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=6.03
scard.evolves_from=CARD_TEAM_MAGMAS_NUMEL
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_NUMEL,["Stage 1"]=CARD_TEAM_MAGMAS_CAMERUPT}
scard.weakness_x2={ENERGY_W}
--ability (attach)
function scard.atfilter(c,tc)
	return c:IsEnergy(ENERGY_F+ENERGY_R) and c:CheckAttachedTarget(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,LOCATION_DPILE,0,1,1,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Attach(e,e:GetHandler(),g)
	end
end
--move energy
function scard.cfilter(c,tp)
	return c:IsBasicEnergy() and Duel.GetBenchedPokemon(tp):IsExists(scard.mefilter,1,nil,c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,60)
	local g=e:GetHandler():GetAttachedGroup():Filter(scard.cfilter,nil,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg1=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local sg2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,nil,sg1:GetFirst())
	Duel.HintSelection(sg2)
	Duel.MoveEnergy(sg2:GetFirst(),sg1)
end
