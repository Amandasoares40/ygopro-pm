--Torchic Star (Team Rocket Returns 108/109)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--discard energy
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_R)
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_R,ENERGY_R)
end
scard.pokemon_basic=true
scard.pokemon_star=true
scard.evolution_list1={["Basic"]=CARD_TORCHIC,["Stage 1"]=CARD_COMBUSKEN,["Stage 2"]=CARD_BLAZIKEN}
scard.weakness_x2={ENERGY_W}
--discard energy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(e,20)
	if c:GetAttachedGroup():IsExists(Card.IsEnergy,1,nil,ENERGY_R) and Duel.TossCoin(tp,1)==RESULT_TAILS then
		Duel.DiscardAttached(tp,c,Card.IsEnergy,1,1,REASON_ATTACK,nil,ENERGY_R)
	end
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeCount(1-tp)==1 then dam=dam+50 end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and Duel.GetPrizeCount(1-tp)==1 then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
