--Magnifier (Neo Destiny 101/105)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach trainer
	aux.EnableAttachTrainer(c,nil,1)
	--ignore resistance
	aux.AddSingleAttachedEffect(c,EFFECT_IGNORE_RESISTANCE)
	aux.AddAttachedDescription(c,DESC_IGNORE_RESISTANCE)
end
scard.trainer_item=true
