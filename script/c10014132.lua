--Psychic Cube 01 (Aquapolis 132/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,aux.FilterBoolFunction(Card.IsEnergyType,ENERGY_P),1)
	--gain attack (confused)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,aux.SelfEnergyTypeCondition(ENERGY_P))
	e1:SetAttackCost(ENERGY_P)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),aux.SelfEnergyTypeCondition(ENERGY_P))
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--gain attack (confused)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,0)
	if tc:IsInPlay() then
		tc:ApplySpecialCondition(tp,SPC_CONFUSED)
	end
end
