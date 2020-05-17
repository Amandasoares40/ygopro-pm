--Cranidos (Mysterious Treasures 43/123)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_F,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.pokemon_restored=true
scard.evolves_from=CARD_SKULL_FOSSIL
scard.evolution_list1={["Basic"]=CARD_SKULL_FOSSIL,["Stage 1"]=CARD_CRANIDOS,["Stage 2"]=CARD_RAMPARDOS}
scard.weakness_20={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,30)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst())
end
