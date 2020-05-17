--Mudkip Star (Team Rocket Returns 107/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W)
	--asleep
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_W,ENERGY_W)
end
scard.pokemon_basic=true
scard.pokemon_star=true
scard.evolution_list1={["Basic"]=CARD_MUDKIP,["Stage 1"]=CARD_MARSHTOMP,["Stage 2"]=CARD_SWAMPERT}
scard.weakness_x2={ENERGY_L}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() and tc:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil) and Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.DiscardAttached(tp,tc,Card.IsEnergy,1,1,REASON_ATTACK)
	end
end
--asleep
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeCount(1-tp)==1 then dam=dam+50 end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and Duel.GetPrizeCount(1-tp)==1 then
		tc:ApplySpecialCondition(tp,SPC_ASLEEP)
	end
end
