--Suicune & Entei LEGEND (Unleashed 94/95)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--legend
	aux.EnablePokemonLEGENDAttribute(c)
	--return
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W,ENERGY_W,ENERGY_C)
	--burned
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
end
scard.pokemon_legend=true
scard.legend_top_half=CARD_SUICUNE_ENTEI_LEGEND
scard.weakness_x2={ENERGY_W,ENERGY_L}
--return
function scard.thfilter(c)
	return c:IsEnergy(ENERGY_W) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=e:GetHandler():GetAttachedGroup():FilterSelect(tp,scard.thfilter,2,2,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,PLAYER_OWNER,REASON_ATTACK)
		Duel.ConfirmCards(1-tp,g1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g2=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.AttackDamage(e,100,g2:GetFirst())
	end
end
--burned
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,80)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_BURNED)
	end
end
