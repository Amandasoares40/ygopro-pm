--Flaaffy (Neo Genesis 34/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,2.70)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1,scard.cost1)
	e1:SetAttackCost(ENERGY_L)
	--attach
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_MAREEP
scard.evolution_list1={["Basic"]=CARD_MAREEP,["Stage 1"]=CARD_FLAAFFY,["Stage 2"]=CARD_AMPHAROS}
scard.weakness_x2={ENERGY_F}
--damage
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetAttachedGroup()
	if chk==0 then return g:IsExists(Card.IsEnergy,1,nil,ENERGY_L) end
	local sg=g:Filter(Card.IsEnergy,nil,ENERGY_L)
	local ct=Duel.SendtoDPile(sg,REASON_ATTACK+REASON_DISCARD)
	e:SetLabel(ct)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=0
	for i=1,e:GetLabel() do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
	end
	Duel.AttackDamage(e,30*dam)
end
--attach
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_L) and Duel.GetBenchedPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	local g1=e:GetHandler():GetAttachedGroup():Filter(scard.cfilter,nil,tp)
	local g2=Duel.GetBenchedPokemon(tp)
	if g1:GetCount()==0 and g2:GetCount()>0 then return end
	if g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
		local sg1=g1:FilterSelect(tp,Card.IsEnergy,1,1,nil,ENERGY_L)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
		local sg2=g2:FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg1=g1:FilterSelect(tp,Card.IsEnergy,1,1,nil,ENERGY_L)
		Duel.SendtoDPile(sg1,REASON_ATTACK+REASON_DISCARD)
	end
end
