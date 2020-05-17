--Registeel-EX (Dragons Exalted 81/124)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_M,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_ex=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,3,3,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,30,tc)
	end
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	local c=e:GetHandler()
	--reduce damage
	aux.AddTempEffectUpdateDamage(c,c,DESC_TAKE_LESS_DAMAGE,EFFECT_UPDATE_DEFEND_AFTER,-20,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
end
