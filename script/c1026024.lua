--Magma Pointer (Double Crisis 24/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain attack (damage)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfSetCardCondition(SETNAME_TEAM_MAGMA))
	e1:SetAttackCost(ENERGY_F)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfSetCardCondition(SETNAME_TEAM_MAGMA))
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain attack (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
	local g=Duel.GetInPlayPokemon(1-tp):Select(tp,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(e,20,g:GetFirst())
end
