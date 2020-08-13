--Natu (Neo Genesis 67/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,0.80)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(10))
	e1:SetAttackCost(ENERGY_C)
	--damage
	local e2=aux.AddPokemonAttack(c,1,nil,scard.op1)
	e2:SetAttackCost(ENERGY_P,ENERGY_P)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_NATU,["Stage 1"]=CARD_XATU}
scard.weakness_x2={ENERGY_P}
scard.resistance_30={ENERGY_F}
--damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst(),false,false)
end
