--Electivire (Diamond & Pearl 3/130)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,5.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-power (move energy)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(scard.con1)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_L,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_ELECTABUZZ
scard.evolution_list1={["Baby"]=CARD_ELEKID,["Basic"]=CARD_ELECTABUZZ,["Stage 1"]=CARD_ELECTIVIRE}
scard.weakness_20={ENERGY_F}
scard.resistance_20={ENERGY_M}
--poke-power (move energy)
function scard.con1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetAttachedGroup()
	return g:IsExists(Card.IsCode,1,nil,CARD_ELEKID) and aux.NotAffectedBySpecialCondition(e,tp,eg,ep,ev,re,r,rp)
end
function scard.cfilter(c,tc)
	return c:GetAttachedGroup():IsExists(scard.mefilter,1,nil,tc)
end
function scard.mefilter(c,tc)
	return c:IsEnergy(ENERGY_L) --and c:CheckAttachedTarget(tc)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter,1,c,c) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetInPlayPokemon(tp):Filter(scard.cfilter,c,c)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEENERGYFROM)
	local sg1=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local sg2=sg1:GetFirst():GetAttachedGroup():FilterSelect(tp,scard.mefilter,1,1,nil,c)
	Duel.MoveEnergy(c,sg2)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_L)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,YESNOMSG_DISCARDENERGY) then
		if Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)>0 then dam=120 end
	end
	Duel.AttackDamage(e,dam)
end
