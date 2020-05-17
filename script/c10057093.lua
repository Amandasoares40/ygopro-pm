--G Scope (Plasma Blast 93/101)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain attack (damage)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfCardCodeCondition(CARD_GENESECT_EX))
	e1:SetAttackCost(ENERGY_G,ENERGY_G,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfCardCodeCondition(CARD_GENESECT_EX))
end
scard.trainer_item=TYPE_POKEMON_TOOL
scard.trainer_ace_spec=true
--gain attack (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetBenchedPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,100,g:GetFirst(),false,false)
end
