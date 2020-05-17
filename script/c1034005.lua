--Meowth VMAX (Black Star Promo SWSH005)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--draw
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_VMAX
scard.pokemon_v=true
scard.evolves_from=CARD_MEOWTH_V
scard.vmax_evolution_list={CARD_MEOWTH_V,CARD_MEOWTH_VMAX}
scard.weakness_x2={ENERGY_F}
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,200)
	Duel.Draw(tp,3,REASON_ATTACK)
end
