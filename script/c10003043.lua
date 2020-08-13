--Slowbro (Fossil 43/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,5.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--pokemon power (move counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEMON_POWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.NotAffectedBySpecialCondition)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--paralyzed
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_P)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_SLOWPOKE
scard.evolution_list1={["Basic"]=CARD_SLOWPOKE,["Stage 1"]=CARD_SLOWBRO}
scard.weakness_x2={ENERGY_P}
--pokemon power (move counter)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDamaged,tp,LOCATION_INPLAY,0,1,c)
		and c:GetRemainingHP()>10 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsDamaged,tp,LOCATION_INPLAY,0,c)
	if g:GetCount()==0 or c:GetRemainingHP()<=10 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVECOUNTERFROM)
	local sg=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg)
	sg:GetFirst():RemoveCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
	c:AddCounter(tp,COUNTER_DAMAGE,1,REASON_EFFECT)
end
--paralyzed
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,20)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
