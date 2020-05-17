--Metal Cube 01 (Aquapolis 129/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_M),1)
	--gain attack (switch)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfEnergyTypeCondition(ENERGY_M))
	e1:SetAttackCost(ENERGY_M)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfEnergyTypeCondition(ENERGY_M))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (switch)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetActivePokemon(1-tp) and Duel.GetBenchedPokemon(1-tp):GetCount()>0
		and Duel.SelectYesNo(tp,YESNOMSG_SWITCH) then
		Duel.SwitchPokemon(tp,1-tp)
	end
	Duel.AttackDamage(e,10)
end
