--Misty's Goldeen (Gym Heroes 30/132)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_MISTY,SETNAME_OWNER)
	aux.AddLength(c,2.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_W)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_MISTYS_GOLDEEN,["Stage 1"]=CARD_MISTYS_SEAKING}
scard.weakness_x2={ENERGY_L}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	Duel.AttackDamage(e,30)
end
