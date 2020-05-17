--Chesnaught (BREAKthrough 11/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_G,ENERGY_C,ENERGY_C)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.height=5.03
scard.evolves_from=CARD_QUILLADIN
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	if Duel.GetActivePokemon(1-tp):IsDamaged() then dam=dam+60 end
	Duel.AttackDamage(e,dam)
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,100)
	local c=e:GetHandler()
	--reduce damage
	aux.AddTempEffectUpdateDamage(c,c,DESC_TAKE_LESS_DAMAGE,EFFECT_UPDATE_DEFEND_AFTER,-20,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
end
