--Electabuzz (Black Star Promo Wizards of the Coast 46)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--add marker
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_L)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_L,ENERGY_L)
end
scard.pokemon_basic=true
scard.length=3.70
scard.evolution_list1={["Baby"]=CARD_ELEKID,["Basic"]=CARD_ELECTABUZZ,["Stage 1"]=CARD_ELECTIVIRE}
scard.weakness_x2={ENERGY_F}
--add marker
function scard.markfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsCanAddMarker(MARKER_LIGHTNING_ROD,1)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDMARKER)
	local g=Duel.SelectMatchingCard(tp,scard.markfilter,tp,0,LOCATION_INPLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():AddMarker(tp,MARKER_LIGHTNING_ROD,1,REASON_ATTACK)
end
--damage
function scard.damfilter(c)
	return c:GetMarker(MARKER_LIGHTNING_ROD)>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,10)
	local g=Duel.GetInPlayPokemon():Filter(scard.damfilter,nil)
	for tc in aux.Next(g) do
		Duel.AttackDamage(e,20,tc)
	end
end
