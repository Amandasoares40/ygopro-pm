--Omanyte (Neo Discovery 60/75)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (search - to bench)
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
	--paralyzed
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_restored=true
scard.length=1.40
scard.evolves_from=CARD_MYSTERIOUS_FOSSIL
scard.evolution_list4={["Basic"]=CARD_MYSTERIOUS_FOSSIL,["Stage 1"]=CARD_OMANYTE,["Stage 2"]=CARD_OMASTAR}
scard.break_evolution_list={CARD_OMASTAR,CARD_OMASTAR_BREAK}
scard.weakness_x2={ENERGY_G}
--pokemon power (search - to bench)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsNotBenchFull(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.tbfilter(c,e,tp)
	return aux.IsEvolutionChain(c,CARD_MYSTERIOUS_FOSSIL)
		and not c:IsCode(CARD_MYSTERIOUS_FOSSIL) and c:IsCanBePlayed(e,0,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.IsBenchFull(tp) or Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBENCH)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp):GetFirst()
	if tc and Duel.PlayPokemonStep(tc,0,tp,tp,true,false,POS_FACEUP_UPSIDE) then
		--treat as basic pokemon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_BASIC_POKEMON)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(TYPE_BASIC_POKEMON)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		tc:RegisterEffect(e1,true)
		Duel.PlayPokemonComplete()
	else
		Duel.ShuffleDeck(tp)
	end
end
--paralyzed
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,10)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
