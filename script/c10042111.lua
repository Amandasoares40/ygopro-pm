--Arceus (Arceus AR9)
--BUG: Due to having consecutive ids, this card is treated as Arceus (Arceus AR1)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,10.06)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--gain effect
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.weakness_x2={ENERGY_R}
scard.resistance_20={ENERGY_P}
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,40)
	local c=e:GetHandler()
	--immune to attacks
	aux.AddTempEffectImmune(c,c,DESC_ARCEUS_AR9,scard.val1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
end
function scard.val1(e,te)
	return te:IsHasCategory(CATEGORY_POKEMON_ATTACK) and te:GetHandler():IsPokemonLVX()
end
