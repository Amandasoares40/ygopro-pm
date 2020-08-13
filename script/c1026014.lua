--Team Magma's Aggron (Double Crisis 14/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_MAGMA,SETNAME_OWNER)
	aux.AddHeight(c,6.11)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_F,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_F,ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.evolves_from=CARD_TEAM_MAGMAS_LAIRON
scard.evolution_list1={["Basic"]=CARD_TEAM_MAGMAS_ARON,["Stage 1"]=CARD_TEAM_MAGMAS_LAIRON,["Stage 2"]=CARD_TEAM_MAGMAS_AGGRON}
scard.weakness_x2={ENERGY_G}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=0
	local g=Duel.GetAttachedGroup(tp,1,0):Filter(Card.IsEnergy,nil,ENERGY_F)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,YESNOMSG_DISCARDENERGY) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=g:Select(tp,1,g:GetCount(),nil)
		if Duel.SendtoDPile(sg,REASON_ATTACK+REASON_DISCARD)>0 then
			dam=dam+sg:GetSum(Card.GetEnergyCount,nil)
		end
	end
	Duel.AttackDamage(e,40*dam)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,120)
	local g=Duel.GetBenchedPokemon(1-tp):Filter(Card.IsDamaged,nil)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,20,tc)
	end
end
