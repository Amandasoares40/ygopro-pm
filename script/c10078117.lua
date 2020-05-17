--Beast Energy Prism Star (Forbidden Light 117/131)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_PRISM_STAR)
	--energy
	aux.EnableEnergyAttribute(c)
	--provide energy
	aux.EnableProvideEnergy(c,scard.val1)
	--increase damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE,30,aux.SelfUltraBeastCondition)
	aux.AddAttachedDescription(c,DESC_DO_MORE_DAMAGE,aux.SelfUltraBeastCondition)
end
scard.energy_special=true
--provide energy
function scard.val1(e,c)
	local tc=c:GetAttachedTarget()
	if tc and tc:IsUltraBeast() then
		return ENERGY_ALL
	else
		return ENERGY_C
	end
end
