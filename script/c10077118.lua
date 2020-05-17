--Ancient Crystal (Ultra Prism 118/156)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--reduce damage
	aux.AddSingleAttachedEffect(c,EFFECT_UPDATE_DEFEND_OPPO_AFTER,-30,scard.con1)
	aux.AddAttachedDescription(c,DESC_TAKE_LESS_DAMAGE,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--reduce damage
scard.con1=aux.SelfCardCodeCondition(CARD_REGIROCK,CARD_REGICE,CARD_REGISTEEL,CARD_REGIGIGAS)
