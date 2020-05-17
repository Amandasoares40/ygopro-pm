--Multi Technical Machine 01 (Expedition 144/165)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,nil,1)
	--gain attack (paralyzed)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (paralyzed)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_PARALYZED)
	end
end
