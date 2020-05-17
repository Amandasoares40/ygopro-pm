--Fairy Charm UB (Team Up 142/181)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_FAIRY_CHARM)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c)
	--immune to attack damage
	aux.AddSingleAttachedEffect(c,EFFECT_IMMUNE_ATTACK_DAMAGE,nil,scard.con1)
	aux.AddAttachedDescription(c,DESC_FAIRY_CHARM_UB_TEU142,scard.con1)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--immune to attack damage
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	local tc=(Duel.GetTurnPlayer()==tp and Duel.GetActivePokemon(tp) or Duel.GetActivePokemon(1-tp))
	return e:GetHandler():IsEnergyType(ENERGY_Y)
		and (tc:IsPokemonGX() or tc:IsPokemonEX()) and tc:IsUltraBeast()
end
