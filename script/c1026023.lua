--Aqua Diffuser (Double Crisis 23/34)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--gain attack (confused, poisoned)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfSetCardCondition(SETNAME_TEAM_AQUA))
	e1:SetAttackCost(ENERGY_W)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfSetCardCondition(SETNAME_TEAM_AQUA))
end
scard.trainer_item=TYPE_POKEMON_TOOL
--gain attack (confused, poisoned)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED+SPC_POISONED)
	end
end
