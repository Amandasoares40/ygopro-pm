--Quilladin (BREAKthrough 10/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(20))
	e1:SetAttackCost(ENERGY_G,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=2.04
scard.evolves_from=CARD_CHESPIN
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3,c4=Duel.TossCoin(tp,4)
	local dam=c1+c2+c3+c4
	Duel.AttackDamage(e,40*dam)
end
