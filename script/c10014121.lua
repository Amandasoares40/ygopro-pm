--Fighting Cube 01 (Aquapolis 121/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_F),1)
	--gain attack (damage)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfEnergyTypeCondition(ENERGY_F))
	e1:SetAttackCost(ENERGY_F)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfEnergyTypeCondition(ENERGY_F))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetCounter(COUNTER_DAMAGE)
	local dam=0
	for i=1,ct do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
	end
	Duel.AttackDamage(e,10*dam)
end
