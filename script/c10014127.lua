--Lightning Cube 01 (Aquapolis 127/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_L),1)
	--gain attack (discard energy, damage)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfEnergyTypeCondition(ENERGY_L))
	e1:SetAttackCost(ENERGY_L)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfEnergyTypeCondition(ENERGY_L))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (discard energy, damage)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAttachedGroup():Filter(Card.IsEnergy,nil,ENERGY_L)
	local ct=Duel.SendtoDPile(g,REASON_ATTACK+REASON_DISCARD)
	Duel.BreakEffect()
	local dam=0
	for i=1,ct do
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
	end
	Duel.AttackDamage(e,40*dam)
end
