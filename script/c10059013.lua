--Quilladin (XY 13/146)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=2.04
scard.evolves_from=CARD_CHESPIN
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,0)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		--immune to attack damage
		aux.AddTempEffectCustom(c,c,DESC_IMMUNE_ATTACK_DAMAGE,EFFECT_IMMUNE_ATTACK_DAMAGE,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,70)
	Duel.AttackDamage(e,10,e:GetHandler())
end
