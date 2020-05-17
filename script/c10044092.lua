--Raikou & Suicune LEGEND (Unleashed 92/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
	--remove counter
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_RAIKOU_SUICUNE_LEGEND
scard.weakness_x2={ENERGY_F,ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,150)
	Duel.AttackDamage(e,50,e:GetHandler(),false)
end
--remove counter
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,50)
	e:GetHandler():RemoveCounter(tp,COUNTER_DAMAGE,5,REASON_ATTACK)
end
