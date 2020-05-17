--Weakness Guard (Aquapolis 141/147)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach trainer
	aux.EnableAttachTrainer(c,nil,2)
	--no weakness
	aux.AddSingleAttachedEffect(c,EFFECT_NO_WEAKNESS)
	aux.AddAttachedDescription(c,DESC_NO_WEAKNESS)
end
scard.trainer_item=true
