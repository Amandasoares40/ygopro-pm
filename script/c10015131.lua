--Miracle Sphere Gamma (Skyridge 131/144)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--technical machine
	aux.EnableTechnicalMachineAttribute(c,scard.techfilter,1)
	--gain attack (add special condition, add counter)
	local e1=aux.AddTrainerAttack(c,0,nil,scard.op1,nil,scard.con1)
	e1:SetAttackCost(ENERGY_L,ENERGY_C,ENERGY_C)
	aux.AddAttachedDescription(c,aux.Stringid(sid,1),scard.con1)
end
scard.trainer_item=TYPE_TECHNICAL_MACHINE
--technical machine
function scard.techfilter(c)
	return c:IsEvolved() and c:IsEnergyType(ENERGY_G+ENERGY_W+ENERGY_L)
end
--gain attack (add special condition, add counter)
function scard.con1(e)
	return scard.techfilter(e:GetHandler())
end
function scard.cfilter(c,energy_type)
	return c:IsBasicEnergy() and c:IsEnergy(energy_type)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=30
	local asleep=false
	local poisoned=false
	local add_damage=false
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_G)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_L) then
		asleep=true
		poisoned=true
	end
	if c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_W)
		and c:GetAttachedGroup():IsExists(scard.cfilter,1,nil,ENERGY_L) then
		dam=dam+10
		add_damage=true
	end
	local tc=Duel.GetActivePokemon(1-tp)
	Duel.AttackDamage(e,dam)
	if tc:IsInPlay() and asleep then tc:ApplySpecialCondition(tp,SPC_ASLEEP) end
	if tc:IsInPlay() and poisoned then tc:ApplySpecialCondition(tp,SPC_POISONED) end
	if add_damage then
		local g=Duel.GetBenchedPokemon(1-tp)
		for tc in aux.Next(g) do
			tc:AddCounter(tp,COUNTER_DAMAGE,1,REASON_ATTACK)
		end
	end
end
