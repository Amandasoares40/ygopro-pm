--Team Aqua's Sealeo (Double Crisis 4/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	aux.AddHeight(c,3.07)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_TEAM_AQUAS_SPHEAL
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_SPHEAL,["Stage 1"]=CARD_TEAM_AQUAS_SEALEO,["Stage 2"]=CARD_TEAM_AQUAS_WALREIN}
scard.weakness_x2={ENERGY_M}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst())
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	if Duel.GetActivePokemon(1-tp):IsSetCard(SETNAME_TEAM_MAGMA) then dam=dam+60 end
	Duel.AttackDamage(e,dam)
end
