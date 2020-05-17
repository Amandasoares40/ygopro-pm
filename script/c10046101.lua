--Palkia & Dialga LEGEND (Triumphant 101/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--return
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_C,ENERGY_C)
	--discard energy, to prize
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_M,ENERGY_M,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_PALKIA_DIALGA_LEGEND
scard.weakness_x2={ENERGY_R,ENERGY_L}
--return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.GetBenchedPokemon(1-tp):FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:Merge(g:GetFirst():GetAttachedGroup())
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_ATTACK)
end
--discard energy, to prize
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g1=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_M)
	Duel.SendtoDPile(g1,REASON_ATTACK+REASON_DISCARD)
	local g2=Duel.GetDecktopGroup(1-tp,2)
	Duel.SendtoPrize(g2,REASON_ATTACK)
end
