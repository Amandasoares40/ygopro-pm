--Kingdra (Aquapolis 19/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
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
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_SEADRA
scard.evolution_list1={["Basic"]=CARD_HORSEA,["Stage 1"]=CARD_SEADRA,["Stage 2"]=CARD_KINGDRA}
scard.weakness_x2={ENERGY_L}
--poke-power (move energy)
function scard.cfilter1(c,tp)
	return Duel.GetActivePokemon(tp):GetAttachedGroup():IsExists(scard.cfilter2,1,nil,tp)
end
function scard.cfilter2(c,tp)
	return c:IsEnergy(ENERGY_W) and Duel.GetBenchedPokemon(tp):IsExists(scard.mefilter,1,nil,c)
end
function scard.mefilter(c,tc)
	return true--tc:CheckAttachedTarget(c)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter1,1,nil,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetInPlayPokemon(tp):IsExists(scard.cfilter1,1,nil,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGY)
	local g1=Duel.GetActivePokemon(tp):GetAttachedGroup():FilterSelect(tp,scard.cfilter2,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_MOVEENERGYTO)
	local g2=Duel.GetBenchedPokemon(tp):FilterSelect(tp,scard.mefilter,1,1,nil,g1:GetFirst())
	Duel.HintSelection(g2)
	Duel.MoveEnergy(g2:GetFirst(),g1)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,50)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
