--Light Slowbro (Neo Destiny 51/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_LIGHT)
	aux.AddLength(c,5.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--to deck
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_SLOWPOKE
scard.evolution_list2={["Basic"]=CARD_SLOWPOKE,["Stage 1"]=CARD_LIGHT_SLOWBRO}
scard.weakness_x2={ENERGY_P}
--to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	scard.todeck(1-tp)
	scard.todeck(tp)
end
function scard.tdfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToDeck()
end
function scard.todeck(tp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_DPILE,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,1,3,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_ATTACK)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	local ct1=Duel.GetActivePokemon(1-tp):GetAttachedGroup():FilterCount(Card.IsEnergy,nil)
	local ct2=Duel.GetActivePokemon(tp):GetAttachedGroup():FilterCount(Card.IsEnergy,nil)
	if ct1>ct2 then dam=dam+20 end
	Duel.AttackDamage(e,dam)
end
