--Magikarp & Wailord-GX (Black Star Promo SM166)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(180))
	e1:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_W,ENERGY_W,ENERGY_W)
	--gx attack (damage)
	local e2=aux.AddPokemonAttack(c,1,CATEGORY_GX_ATTACK,scard.op1)
	e2:SetAttackCost(ENERGY_W)
end
scard.pokemon_basic=true
scard.pokemon_gx=true
scard.tag_team=true
scard.weakness_x2={ENERGY_G}
--gx attack (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	if not e:GetHandler():GetAttachedGroup():IsExists(Card.IsEnergy,8,nil,ENERGY_W) then return end
	local g=Duel.GetBenchedPokemon(1-tp)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,100,tc)
	end
end
