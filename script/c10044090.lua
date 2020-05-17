--Entei & Raikou LEGEND (Unleashed 90/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_ENTEI_RAIKOU_LEGEND
scard.weakness_x2={ENERGY_W,ENERGY_F}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,90)
	Duel.DiscardAttached(tp,e:GetHandler(),Card.IsEnergy,1,1,REASON_ATTACK,nil,ENERGY_R)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g1=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g1,REASON_ATTACK+REASON_DISCARD)
	local g2=Duel.GetInPlayPokemon():Filter(Card.IsHasPokePower,nil)
	for tc in aux.Next(g2) do
		Duel.AttackDamage(e,80,tc,false,false)
	end
end
