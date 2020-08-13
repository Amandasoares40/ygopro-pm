--Chespin (Black Star Promo XY88)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddHeight(c,1.04)
	--pokemon
	aux.EnablePokemonAttribute(c)
	--damage
	local e1=aux.AddPokemonAttack(c,0,nil,aux.AttackDamageOperation(30))
	e1:SetAttackCost(ENERGY_G,ENERGY_C)
end
scard.pokemon_basic=true
scard.evolution_list1={["Basic"]=CARD_CHESPIN,["Stage 1"]=CARD_QUILLADIN,["Stage 2"]=CARD_CHESNAUGHT}
scard.break_evolution_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2={ENERGY_R}
