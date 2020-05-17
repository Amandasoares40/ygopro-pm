--Probopass G (Black Star Promo DP43)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_M,ENERGY_C)
	--get effect
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_W}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetInPlayPokemon(1-tp):Filter(Card.IsHasPokeBody,nil)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,20,tc)
	end
end
--get effect
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,70)
	local c=e:GetHandler()
	--0 retreat cost
	aux.AddTempEffectChangeRetreatCost(c,c,0,RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
