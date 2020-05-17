--Defender (Base Set 80/102)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--attach trainer
	aux.EnableAttachTrainer(c,nil,2)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_AFTER,-20)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE)
end
scard.trainer_item=true
