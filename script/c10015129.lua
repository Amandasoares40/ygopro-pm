--Miracle Sphere Alpha (Skyridge 129/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack (confused, remove counter)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_R,ENERGY_C,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and c:IsEnergyType(ENERGY_R+ENERGY_L+ENERGY_F)
end
--gain attack (confused, remove counter)
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=30
	local confused=false
	local remove_damage=false
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_R)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_L) then confused=true end
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_R)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_F) then
		dam=dam+10
		remove_damage=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and confused then tc:ApplySpecialCondition(tp,SPC_CONFUSED) end
	if remove_damage then c:RemoveCounter(tp,COUNTER_DAMAGE,3,REASON_EFFECT) end
end
