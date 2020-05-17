--Alolan Ninetales-GX (Guardians Rising 22/145)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ALOLAN)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
	--gx attack (move counter)
	local e3=aux.AddPokemonAttack(c,2,CATEGORY_GX_ATTACK,scard.op3)
	e3:SetAttackCost(ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_gx=true
scard.evolves_from=CARD_ALOLAN_VULPIX
scard.evolution_list2={["Basic"]=CARD_ALOLAN_VULPIX,["Stage 1"]=CARD_ALOLAN_NINETALES_GX}
scard.weakness_x2={ENERGY_M}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,50,g:GetFirst())
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,160)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,2,2,REASON_ATTACK)
end
--gx attack (move counter)
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	local ct=c:GetCounter(COUNTER_DAMAGE)
	c:RemoveCounter(tp,COUNTER_DAMAGE,ct,REASON_ATTACK)
	Duel.GetActivePokemon(1-tp):AddCounter(tp,COUNTER_DAMAGE,ct,REASON_ATTACK)
end
