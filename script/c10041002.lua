--Blaziken FB (Supreme Victors 2/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--switch, burned
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_sp=true
scard.weakness_x2={ENERGY_W}
--switch, burned
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		Duel.SwitchPokemon(tp,1-tp)
	end
	Duel.GetActivePokemon(1-tp):ApplySpecialCondition(tp,SPC_BURNED)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=30
	if Duel.GetInPlayPokemon(1-tp):IsExists(Card.IsEnergyType,1,nil,ENERGY_W) then dam=dam+30 end
	Duel.AttackDamage(e,dam)
end
