--Cleffa (Neo Genesis 20/111)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddLength(c,1.00)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--baby pokemon ability
	aux.EnableBabyPokemonAbility(c)
	--to deck, draw
	local e1=aux.AddPokemonAttack(c,0,nil,scard.op1)
	e1:SetAttackCost(ENERGY_C)
end
scard.pokemon_basic=true
scard.pokemon_baby=true
scard.evolution_list1={["Baby"]=CARD_CLEFFA,["Basic"]=CARD_CLEFAIRY,["Stage 1"]=CARD_CLEFABLE}
--to deck, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,0)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECKSHUFFLE,REASON_ATTACK)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,7,REASON_ATTACK)
end
--[[
	Rulings
	Q. With Cleffa, do you have to have at least one card in order to use it's attack?
	A. Nope, you can shuffle in a hand of zero cards. (Dec 14, 2000 WotC Chat, Q116)
	https://compendium.pokegym.net/compendium.html#pattacks
]]
