--Magikarp (Crimson Invasion 17/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--ability (immune to attack damage)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ABILITY)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_ATTACK_DAMAGE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.SelfBenchedCondition)
	c:RegisterEffect(e1)
	--search (evolve)
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_MAGIKARP,["Stage 1"]=CARD_GYARADOS}
scard.weakness_x2={ENERGY_L}
--search (evolve)
function scard.evofilter(c,e,tp,code)
	return c.evolves_from==code and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,true,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVETO)
	local g=Duel.SelectMatchingCard(tp,scard.evofilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,c:GetCode())
	if g:GetCount()>0 then
		Duel.Evolve(g:GetFirst(),c,tp)
	else
		Duel.ShuffleDeck(tp)
	end
end
