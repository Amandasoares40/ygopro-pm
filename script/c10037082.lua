--Unown ? (Legends Awakened 82/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_UNOWN)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--poke-power (guess energy type - draw)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_POKEPOWER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_BENCH)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.SelfBenchedCondition)
	e1:SetTarget(aux.CheckCardFunction(Card.IsPokemon,LOCATION_HAND,0))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--discard hand, draw
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost()
end
scard.pokemon_basic=true
scard.weakness_10={ENERGY_P}
--poke-power (guess energy type - draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PUTFACEDOWN)
	local tc=Duel.SelectMatchingCard(tp,Card.IsPokemon,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.PutFacedown(tc)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ENERGYTYPE)
	local energy_type=Duel.SelectEnergyType(tp,true)
	Duel.ChangePosition(tc,POS_FACEUP)
	local guessed_wrong=not tc:IsEnergyType(energy_type)
	if guessed_wrong then
		Duel.Draw(tp,1,REASON_EFFECT)
	else
		Duel.HintSelection(Group.FromCards(tc))
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
--discard hand, draw
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.BreakEffect()
	local ct=Duel.DiscardHand(tp,nil,1,2,REASON_ATTACK+REASON_DISCARD)
	Duel.Draw(tp,ct,REASON_ATTACK)
end
