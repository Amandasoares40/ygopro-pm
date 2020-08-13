--Erika's Tangela (Gym Heroes 79/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_ERIKA,SETNAME_OWNER)
	aux.AddLength(c,3.30)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_G)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_R}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst())
end
