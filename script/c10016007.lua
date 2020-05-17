--Gardevoir (Ruby & Sapphire 7/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--poke-power (search - attach, add counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(aux.CheckDeckFunction(PLAYER_SELF))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_KIRLIA
scard.evolution_list1={["Basic"]=CARD_RALTS,["Stage 1"]=CARD_KIRLIA,["Stage 2"]=CARD_GARDEVOIR}
scard.weakness_x2={ENERGY_P}
--poke-power (search - attach, add counter)
function scard.cfilter(c,tp)
	return c:IsEnergy(ENERGY_P) and Duel.GetInPlayPokemon(tp):IsExists(scard.atfilter,1,nil,c)
end
function scard.atfilter(c,tc)
	return tc:CheckAttachedTarget(c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_DECK,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGY)
	local sg1=g:Select(tp,0,1,nil)
	if sg1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACHENERGYTO)
		local sg2=Duel.GetInPlayPokemon(tp):FilterSelect(tp,scard.atfilter,1,1,nil,sg1:GetFirst())
		Duel.HintSelection(sg2)
		Duel.Attach(e,sg2:GetFirst(),sg1)
		sg2:GetFirst():AddCounter(tp,COUNTER_DAMAGE,2,REASON_EFFECT)
	else
		Duel.ShuffleDeck(tp)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g1=e:GetHandler():GetAttachedGroup()
	local g2=Duel.GetActivePokemon(1-tp):GetAttachedGroup()
	local dam=g1:GetSum(Card.GetEnergyCount,nil)+g2:GetSum(Card.GetEnergyCount,nil)
	Duel.AttackDamage(e,10*dam)
end
