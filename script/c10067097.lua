--Bursting Balloon (BREAKpoint 97/122)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--pokemon tool
	aux.EnablePokemonToolAttribute(c,nil,2)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_ATTACHED+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	aux.AddAttachedDescription(c,DESC_RETALIATE_DAMAGE,aux.SelfActiveCondition)
end
scard.trainer_item=TYPE_POKEMON_TOOL
--add counter
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and rp==1-tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetActivePokemon(1-tp):AddCounter(tp,COUNTER_DAMAGE,6,REASON_EFFECT)
end
--[[
	Rulings
		Q. If a Pokemon with Bursting Balloon tool attached is attacked by an Yveltal with the "Fright Night" Ability no
		damage is placed on the attacker, but is the tool discarded at the end of the turn as its text indicates?
		A. The Bursting Balloon damage placement effect is turned off, but the discard text is also an effect, so the tool
		is not discarded at the end of the turn. (Mar 24, 2016 TPCi Rules Team)

		Q. Say I have a Yveltal with "Fright Night" Ability as my Active Pokemon with Bursting Balloon attached, then I
		play Hex Maniac. What happens at the end of my opponent's turn, when they attack and do damage to Yveltal?
		A. Hex Maniac works until the end of your opponent's turn. At the end of your opponent's turn, you check to see if
		Bursting Balloon gets discarded. So Bursting Balloon places the 6 damage counters, Hex Maniac's effect wears off,
		and then Fright Night is reactivated preventing Bursting Balloon from being discarded.
		(Sep 8, 2016 TPCi Rules Team)

		Q. If you use Umbreon's "Shadow Drain" attack against a Pokemon with {D} weakness and a Bursting Balloon attached,
		what are the correct order of operations for placing and healing damage?
		A. Umbreon's healing effect takes place within the context of the attack, so healing has to be completed before
		the attack is finished. Since Bursting Balloon is triggered by damage and you can't interrupt the attack's other
		effect (healing) to place those damage counters, you would heal Umbreon first and then place the damage counters
		for Bursting Balloon. (Jun 9, 2016 TPCi Rules Team)
		https://compendium.pokegym.net/compendium-bw.html#459
	Note: This card's effect is almost identical to that of "Rock Guard".
]]
