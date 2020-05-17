--Fire Cube 01 (Aquapolis 122/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_R),1)
	--gain attack (burned)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfEnergyTypeCondition(ENERGY_R))
	e1:SetAttackCost(ENERGY_R)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfEnergyTypeCondition(ENERGY_R))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (burned)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_BURNED)
	end
end
