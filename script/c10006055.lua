--Misty's Seaking (Gym Heroes 55/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_MISTY,SETNAME_OWNER)
	aux.AddLength(c,4.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_W)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_W,ENERGY_W)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_MISTYS_GOLDEEN
scard.evolution_list1={["Basic"]=CARD_MISTYS_GOLDEEN,["Stage 1"]=CARD_MISTYS_SEAKING}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.AttackDamage(e,10,g:GetFirst())
	end
end
