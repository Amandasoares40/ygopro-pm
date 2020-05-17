--New Effect functions
--set the attack cost for an attack
function Effect.SetAttackCost(e,...)
	--...: the energy required for the attack
	if e:GetCondition() then
		return e:SetCondition(aux.AND(e:GetCondition(),aux.AttackCostCondition(...)))
	else
		return e:SetCondition(aux.AttackCostCondition(...))
	end
end
