--Xatu (Legendary Treasures 56/113)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--draw, discard deck
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_P)
	--confused
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_P,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.height=4.11
scard.evolves_from=CARD_NATU
scard.evolution_list1={["Basic"]=CARD_NATU,["Stage 1"]=CARD_XATU}
scard.weakness_x2={ENERGY_P}
--draw, discard deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RockPaperScissors()==tp then
		Duel.Draw(tp,3,REASON_ATTACK)
		Duel.DiscardDeck(1-tp,3,REASON_ATTACK)
	else
		Duel.Draw(1-tp,3,REASON_ATTACK)
		Duel.DiscardDeck(tp,3,REASON_ATTACK)
	end
end
--confused
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,60)
	if tc:IsInPlay() and Duel.TossCoin(tp,1)==RESULT_HEADS then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
