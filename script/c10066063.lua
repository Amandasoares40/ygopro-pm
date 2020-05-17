--M Mewtwo-EX (BREAKthrough 63/162)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P,ENERGY_F,ENERGY_F,ENERGY_C)
end
scard.pokemon_evolution=TYPE_MEGA
scard.pokemon_ex=true
scard.evolves_from=CARD_MEWTWO_EX
scard.mega_evolution_list={CARD_MEWTWO_EX,CARD_M_MEWTWO_EX}
scard.weakness_x2={ENERGY_P}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=150
	local apply_resist=true
	local apply_effect=true
	if Duel.GetStadiumCard() then
		dam=dam+50
		apply_resist=false
		apply_effect=false
	end
	Duel.AttackDamage(e,dam,Duel.GetActivePokemon(1-tp),true,apply_resist,apply_effect)
end
