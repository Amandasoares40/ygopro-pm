--Quilladin (Kalos Starter Set 4/39)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,2.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--heal
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,aux.AttackDamageOperation(50))
	e2:SetAttackCost(ENERGY_G,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_CHESPIN
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--heal
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	Duel.HealDamage(tp,e:GetHandler(),10,REASON_ATTACK)
end
