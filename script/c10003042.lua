--Seadra (Fossil 42/62)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.length=3.10
scard.evolves_from=CARD_HORSEA
scard.evolution_list1={["Basic"]=CARD_HORSEA,["Stage 1"]=CARD_SEADRA,["Stage 2"]=CARD_KINGDRA}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_W)
	local add=g:GetSum(Card.GetEnergyCount,nil)*10-10
	if add>20 then add=20 end
	local dam=20+add
	Duel.AttackDamage(e,dam)
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	local c=e:GetHandler()
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		--immune to attacks
		aux.AddTempEffectImmune(c,c,DESC_IMMUNE_ATTACK,aux.AttackImmuneFilter,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
