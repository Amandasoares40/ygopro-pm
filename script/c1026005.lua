--Team Aqua's Walrein (Double Crisis 5/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_AQUA,SETNAME_OWNER)
	aux.AddHeight(c,4.07)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--discard energy
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_W,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_TEAM_AQUAS_SEALEO
scard.evolution_list1={["Basic"]=CARD_TEAM_AQUAS_SPHEAL,["Stage 1"]=CARD_TEAM_AQUAS_SEALEO,["Stage 2"]=CARD_TEAM_AQUAS_WALREIN}
scard.weakness_x2={ENERGY_M}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup()
	local dam=g:GetSum(Card.GetEnergyCount,nil)
	Duel.AttackDamage(e,30*dam)
end
--discard energy
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,2,2,REASON_ATTACK,nil,ENERGY_W)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,80,tc)
	end
end
