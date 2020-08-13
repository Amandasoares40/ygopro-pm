--Slowbro (BREAKpoint 20/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,5.03)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W)
	--win game
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op2)
	e2:SetAttackCost(ENERGY_C,ENERGY_C,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_1
scard.evolves_from=CARD_SLOWPOKE
scard.evolution_list1={["Basic"]=CARD_SLOWPOKE,["Stage 1"]=CARD_SLOWBRO}
scard.weakness_x2={ENERGY_G}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+50 end
	Duel.AttackDamage(e,dam)
end
--win game
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	if Duel.GetPrizeCount(tp)==1 then
		Duel.Win(tp,WIN_REASON_SLOWBRO)
	end
end
