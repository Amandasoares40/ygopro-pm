--Magnezone (Plasma Storm 46/135)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddSetcode(c,SETNAME_TEAM_PLASMA)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--evolution
	aux.EnableEvolutionAttribute(c)
	--ability (double supporter)
	local e1=aux.EnablePlayerEffectCustom(c,EFFECT_DOUBLE_SUPPORTER,LOCATION_INPLAY,1,0,nil,aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetCategory(CATEGORY_ABILITY)
	--switch
	local e2=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e2:SetAttackCost(ENERGY_L,ENERGY_L,ENERGY_C)
end
scard.pokemon_evolution=TYPE_STAGE_2
scard.height=3.11
scard.evolves_from=CARD_MAGNETON
scard.evolution_list1={["Basic"]=CARD_MAGNEMITE,["Stage 1"]=CARD_MAGNETON,["Stage 2"]=CARD_MAGNEZONE}
scard.weakness_x2={ENERGY_F}
--switch
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,80)
	Duel.SwitchPokemon(tp,tp)
	Duel.BreakEffect()
	Duel.SwitchPokemon(1-tp,1-tp)
end
--[[
	Rulings
	Q. If I have two Magnezones in play with the "Dual Brains" Ability, does that mean I can play 4 Supporters during my
	turn?
	A. No, you cannot. Dual Brains says you may play 2 Supporters, period; it doesn't say "an extra supporter" for each
	Magnezone. (Plasma Storm FAQ; Feb 7, 2013 TPCi Rules Team)
	https://compendium.pokegym.net/compendium-bw.html#288
]]
