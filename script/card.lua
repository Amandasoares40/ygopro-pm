--Temporary Card functions
--check if a card has a particular setname
local card_is_set_card=Card.IsSetCard
function Card.IsSetCard(c,...)
	local setname_list={...}
	for _,setname in ipairs(setname_list) do
		if card_is_set_card(c,setname,...) then return true end
	end
	return false
end
--check if a card has a particular original setname
function Card.IsOriginalSetCard(c,...)
	local osetname_list=c.setname_list
	if not osetname_list then return false end
	local setname_list={...}
	for _,setname in ipairs(setname_list) do
		for _,osetname in ipairs(osetname_list) do
			if osetname==setname then return true end
		end
	end
	return false
end
--Overwritten Card functions
--get a pokemon's retreat cost
--Note: Overwritten to get level 0
local card_get_level=Card.GetLevel
function Card.GetLevel(c)
	local res=c:GetOriginalLevel()
	local t1={c:IsHasEffect(EFFECT_UPDATE_RETREAT_COST)}
	for _,te1 in pairs(t1) do
		res=res+te1:GetValue()
	end
	local t2={c:IsHasEffect(EFFECT_CHANGE_RETREAT_COST)}
	for _,te2 in pairs(t2) do
		res=res+card_get_level(c)
		if te2:GetValue()==0 then res=0 end
	end
	if res<0 then res=0 end
	return res
end
Card.GetRetreatCost=Card.GetLevel
--add an effect to a card
--Note: Added parameter reset_benched to reset the effect of a pokemon's attack if the pokemon is benched
local card_register_effect=Card.RegisterEffect
function Card.RegisterEffect(c,e,forced,reset_benched)
	--forced: true to not check if the card is immune to the effect
	--reset_benched: true to reset the effect of a pokemon's attack if the pokemon is benched
	if reset_benched then
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_END_ATTACK_EFFECT)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetRange(LOCATION_INPLAY)
		e2:SetCountLimit(1)
		e2:SetLabelObject(e)
		e2:SetCondition(aux.SelfBenchedCondition)
		e2:SetOperation(function(e)
			local e1=e:GetLabelObject()
			e1:Reset()
			Duel.HintSelection(Group.FromCards(e:GetHandler()))
			Duel.Hint(HINT_OPSELECTED,1-e:GetHandlerPlayer(),e:GetDescription())
		end)
		c:RegisterEffect(e2)
	end
	local con=e:GetCondition() or aux.TRUE
	--workaround to disable Pokemon Powers
	if bit.band(e:GetCategory(),CATEGORY_POKEMON_POWER)~=0 then
		e:SetCondition(aux.AND(con,aux.PokemonPowerCondition))
	end
	--workaround to disable Poke-Bodies
	if bit.band(e:GetCategory(),CATEGORY_POKEBODY)~=0 then
		e:SetCondition(aux.AND(con,aux.PokeBodyCondition))
	end
	--workaround to disable Poke-Powers
	if bit.band(e:GetCategory(),CATEGORY_POKEPOWER)~=0 then
		e:SetCondition(aux.AND(con,aux.PokePowerCondition))
	end
	--workaround to disable Abilities
	if bit.band(e:GetCategory(),CATEGORY_ABILITY)~=0 then
		e:SetCondition(aux.AND(con,aux.AbilityCondition))
	end
	--workaround to disable Pokemon Tools
	if c:IsPokemonTool() then
		e:SetCondition(aux.AND(con,aux.UsePokemonToolCondition))
	end
	return card_register_effect(c,e,forced)
end
--put a counter/marker on a pokemon
--Note: Overwritten to implement "Metal Goggles" (Team Up 148/181) and added player and reason parameters
local card_add_counter=Card.AddCounter
function Card.AddCounter(c,player,countertype,count,reason)
	local res=nil
	--check for "Metal Goggles" (Team Up 148/181) effect
	if c:IsHasEffect(EFFECT_METAL_GOGGLES) and player==1-c:GetControler() and countertype==COUNTER_DAMAGE
		and bit.band(reason,REASON_ATTACK+REASON_ABILITY)~=0 and bit.band(reason,REASON_DAMAGE)==0 then
		res=false
	else
		res=card_add_counter(c,countertype,count,reason)
	end
	if res and c:IsRemainingHPBelow(0) then
		--knock out a pokemon that has 0 hp
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ATTACK_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCondition(function(e)
			return c:IsInPlay() and not c:IsStatus(STATUS_KNOCK_OUT_CONFIRMED)
		end)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			Duel.KnockOut(c,reason)
			e:Reset()
		end)
		Duel.RegisterEffect(e1,player)
	end
	return res
end
Card.AddMarker=Card.AddCounter
--remove a counter/marker from a pokemon
--Note: Overwritten to check if a card has less counters/markers than the number of counters/markers they will remove
local card_remove_counter=Card.RemoveCounter
function Card.RemoveCounter(c,player,countertype,count,reason)
	local counter_count=c:GetCounter(countertype)
	if counter_count>0 and count>counter_count then count=counter_count end
	local res=nil
	if count>0 then res=card_remove_counter(c,player,countertype,count,reason) end
	return res
end
Card.RemoveMarker=Card.RemoveCounter
--check if a counter can be put on a pokemon
local card_is_can_add_counter=Card.IsCanAddCounter
function Card.IsCanAddCounter(c,countertype,count,singly)
	return card_is_can_add_counter(c,countertype,count,singly)
end
--New Card functions
--check if a card is a Pokemon card
function Card.IsPokemon(c)
	return c:IsType(TYPE_POKEMON) and not c:IsType(TYPE_TRAP)
end
--check if a card is a Trainer card
function Card.IsTrainer(c)
	return c:IsType(TYPE_TRAINER)
end
--check if a card is an Energy card
function Card.IsEnergy(c,energy)
	--energy: check if the energy card has a particular energy type
	return c:IsType(TYPE_ENERGY) and (not energy or c:IsEnergyType(energy))
end
--check if a card is a Dual-Type Pokemon card
function Card.IsDualType(c)
	return c:IsType(TYPE_DUAL_TYPE)
end
--check if a card is a Prize card
function Card.IsPrize(c)
	return c:GetFlagEffect(EFFECT_PRIZE_CARD)>0
end
--check if a card is a Basic Pokemon card
function Card.IsBasicPokemon(c)
	return c.pokemon_basic or c:IsHasEffect(TYPE_BASIC_POKEMON)
end
--check if a card is an Evolution Pokemon card
function Card.IsEvolution(c)
	return c.pokemon_evolution or c:IsHasEffect(TYPE_EVOLUTION)
end
--check if a card is a Stage 1 Pokemon card
function Card.IsStage1(c)
	return c.pokemon_evolution==TYPE_STAGE_1 or (c:IsHasEffect(TYPE_EVOLUTION) and c:IsHasEffect(TYPE_STAGE_1))
end
--check if a card is a Stage 2 Pokemon card
function Card.IsStage2(c)
	return c.pokemon_evolution==TYPE_STAGE_2 or (c:IsHasEffect(TYPE_EVOLUTION) and c:IsHasEffect(TYPE_STAGE_2))
end
--check if a card is a Baby Pokemon card
function Card.IsBabyPokemon(c)
	return c.pokemon_baby or c:IsHasEffect(TYPE_BABY_POKEMON)
end
--check if a card is a Pokemon-ex card (not to be confused with Pokemon-EX)
function Card.IsPokemonex(c)
	return c.pokemon_ex_old or c:IsHasEffect(TYPE_EX_OLD)
end
--check if a card is a Pokemon Star card
function Card.IsPokemonStar(c)
	return c.pokemon_star or c:IsHasEffect(TYPE_POKEMON_STAR)
end
--check if a card is a Pokemon LV.X (Level-Up) card
function Card.IsPokemonLVX(c)
	return c.pokemon_lvx or c:IsHasEffect(TYPE_LEVEL_UP)
end
--check if a card is a Pokemon SP card
function Card.IsPokemonSP(c)
	return c.pokemon_sp or c:IsHasEffect(TYPE_SP)
end
--check if a card is a Pokemon LEGEND card
function Card.IsPokemonLEGEND(c)
	return c.pokemon_legend or c:IsHasEffect(TYPE_LEGEND)
end
--check if a card is a Pokemon-EX card (not to be confused with Pokemon-ex)
function Card.IsPokemonEX(c)
	return c.pokemon_ex or c:IsHasEffect(TYPE_EX)
end
--check if a card is a Restored Pokemon card
function Card.IsRestoredPokemon(c)
	return c.pokemon_restored or c:IsHasEffect(TYPE_RESTORED)
end
--check if a card is a Mega Evolution Pokemon card
function Card.IsMegaEvolution(c)
	return c.pokemon_evolution==TYPE_MEGA or (c:IsHasEffect(TYPE_EVOLUTION) and c:IsHasEffect(TYPE_MEGA))
end
--check if a card is a Pokemon BREAK card
function Card.IsPokemonBREAK(c)
	return c.pokemon_evolution==TYPE_BREAK or (c:IsHasEffect(TYPE_EVOLUTION) and c:IsHasEffect(TYPE_BREAK))
end
--check if a card is a Pokemon VMAX card
function Card.IsPokemonVMAX(c)
	return c.pokemon_evolution==TYPE_VMAX or (c:IsHasEffect(TYPE_EVOLUTION) and c:IsHasEffect(TYPE_VMAX))
end
--check if a card is a Pokemon-GX card
function Card.IsPokemonGX(c)
	return c.pokemon_gx or c:IsHasEffect(TYPE_GX)
end
--check if a card is an Ultra Beast card
function Card.IsUltraBeast(c)
	return c.pokemon_ultra_beast or c:IsHasEffect(TYPE_ULTRA_BEAST)
end
--check if a card is a TAG TEAM card
function Card.IsTAGTEAM(c)
	return c.tag_team or c:IsHasEffect(TYPE_TAG_TEAM)
end
--check if a card is a Pokemon V card
function Card.IsPokemonV(c)
	return c.pokemon_v or c:IsHasEffect(TYPE_V)
end
--check if a card is a Stadium card
function Card.IsStadium(c)
	return c:IsType(TYPE_STADIUM)
end
--check if a card is an Item card
function Card.IsItem(c)
	return c.trainer_item or c:IsHasEffect(TYPE_ITEM)
end
--check if a card is a Goldenrod Game Corner card
function Card.IsGoldenrodGameCorner(c)
	return c.trainer_goldenrod_game_corner or c:IsHasEffect(TYPE_GOLDENROD_GAME_CORNER)
end
--check if a card is a Pokemon Tool card
function Card.IsPokemonTool(c)
	return c.trainer_item==TYPE_POKEMON_TOOL or c:IsHasEffect(TYPE_POKEMON_TOOL)
end
--check if a card is an ACE SPEC card
function Card.IsACESPEC(c)
	return c.trainer_ace_spec or c:IsHasEffect(TYPE_ACE_SPEC)
end
--check if a card is a Supporter card
function Card.IsSupporter(c)
	return c.trainer_supporter or c:IsHasEffect(TYPE_SUPPORTER)
end
--check if a card is a Technical Machine card
function Card.IsTechnicalMachine(c)
	return c.trainer_item==TYPE_TECHNICAL_MACHINE or c:IsHasEffect(TYPE_TECHNICAL_MACHINE)
end
--check if a card is a Rocket's Secret Machine card
function Card.IsRocketsSecretMachine(c)
	return c.trainer_rockets_secret_machine or c:IsHasEffect(TYPE_ROCKETS_SECRET_MACHINE)
end
--check if a card is a basic Energy card
function Card.IsBasicEnergy(c)
	return c.energy_basic or c:IsHasEffect(TYPE_BASIC_ENERGY)
end
--check if a card is a Special Energy card
function Card.IsSpecialEnergy(c)
	return c.energy_special or c:IsHasEffect(TYPE_SPECIAL_ENERGY)
end
--check if a pokemon has an owner in its name
function Card.IsOwnersPokemon(c)
	return c:IsSetCard(SETNAME_OWNER)
end
--check if a pokemon is evolved
function Card.IsEvolved(c)
	return c:GetFlagEffect(EFFECT_EVOLVED)>0
end
--check if a pokemon is devolved
function Card.IsDevolved(c)
	return c:GetFlagEffect(EFFECT_DEVOLVED)>0
end
--check if a pokemon has a Pokemon Power printed on its card
function Card.IsHasPokemonPower(c)
	return c:IsType(TYPE_POKEMON_POWER)
end
--check if a pokemon has a Poke-Body printed on its card
function Card.IsHasPokeBody(c)
	return c:IsType(TYPE_POKEBODY)
end
--check if a pokemon has a Poke-Power printed on its card
function Card.IsHasPokePower(c)
	return c:IsType(TYPE_POKEPOWER)
end
--check if a pokemon has an Ability printed on its card
function Card.IsHasAbility(c)
	return c:IsType(TYPE_ABILITY)
end
--check if a pokemon has an Ancient Trait printed on its card
function Card.IsHasAncientTrait(c)
	return c:IsType(TYPE_ANCIENT_TRAIT)
end
--get the default number of prizes a pokemon is worth
function Card.GetPrizeValue(c)
	local res=1
	if c:IsPokemonex() or c:IsPokemonLEGEND() or c:IsPokemonEX() or c:IsPokemonGX() or c:IsPokemonV() then res=2 end
	if c:IsTAGTEAM() or c:IsPokemonVMAX() then res=3 end
	return res
end
--get the top card that is attached to a card (required for devolving)
function Card.GetTopAttachedCard(c)
	local g=c:GetAttachedGroup()
	return g:Filter(aux.FilterEqualFunction(Card.GetSequence,g:GetCount()-1),nil):GetFirst()
end
--get the amount of energy a card provides
function Card.GetEnergyCount(c,energy)
	--energy: check if the card provides a particular energy type
	if not c:IsEnergy() or (energy and c:GetEnergyType()~=energy) then return false end
	return c:GetLevel()
end
--check if a pokemon has the energy required for an attack
--Note: Update this function if a new basic Energy card is introduced
function Card.CheckAttackCost(c,...)
	--check for effects that ignore the attack cost
	if c:IsHasEffect(EFFECT_IGNORE_ENERGY) then return true end
	local energy_list={...}
	--check for effects that change the attack cost
	local effct1=c:GetEffectCount(EFFECT_ATTACK_COST_REDUCE_C)
	local effct2=c:GetEffectCount(EFFECT_ATTACK_COST_INCREASE_C)
	local effct3=c:GetEffectCount(EFFECT_ATTACK_COST_REDUCE_L)
	local idx1=table.find(energy_list,ENERGY_C)
	local idx2=table.find(energy_list,ENERGY_L)
	for i=1,effct1 do
		if idx1 then table.remove(energy_list,idx1) end
	end
	for i=1,effct2 do
		table.insert(energy_list,ENERGY_C)
	end
	for i=1,effct3 do
		if idx2 then table.remove(energy_list,idx2) end
	end
	local gct=0
	local rct=0
	local wct=0
	local lct=0
	local pct=0
	local fct=0
	local dct=0
	local mct=0
	local yct=0
	local cct=0
	for _,energy in ipairs(energy_list) do
		if energy==ENERGY_G then gct=gct+1 end
		if energy==ENERGY_R then rct=rct+1 end
		if energy==ENERGY_W then wct=wct+1 end
		if energy==ENERGY_L then lct=lct+1 end
		if energy==ENERGY_P then pct=pct+1 end
		if energy==ENERGY_F then fct=fct+1 end
		if energy==ENERGY_D then dct=dct+1 end
		if energy==ENERGY_M then mct=mct+1 end
		if energy==ENERGY_Y then yct=yct+1 end
		if energy==ENERGY_C then cct=cct+1 end
	end
	--check if the pokemon has the required energy
	local g=c:GetAttachedGroup()
	if g:GetSum(Card.GetEnergyCount,ENERGY_G)<gct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_R)<rct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_W)<wct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_L)<lct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_P)<pct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_F)<fct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_D)<dct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_M)<mct then return false end
	if g:GetSum(Card.GetEnergyCount,ENERGY_Y)<yct then return false end
	if cct>0 and g:GetSum(Card.GetEnergyCount)<#energy_list then return false end
	return true
end
--get a pokemon's weakness energy type
function Card.GetWeaknessType(c)
	local res=0
	if c.weakness_x2 then
		for _,energy_type in pairs(c.weakness_x2) do
			res=res+energy_type
		end
	elseif c.weakness_10 then
		for _,energy_type in pairs(c.weakness_10) do
			res=res+energy_type
		end
	elseif c.weakness_20 then
		for _,energy_type in pairs(c.weakness_20) do
			res=res+energy_type
		end
	elseif c.weakness_30 then
		for _,energy_type in pairs(c.weakness_30) do
			res=res+energy_type
		end
	elseif c.weakness_40 then
		for _,energy_type in pairs(c.weakness_40) do
			res=res+energy_type
		end
	end
	--check for effects that add weakness
	local t1={c:IsHasEffect(EFFECT_ADD_WEAKNESS_TYPE)}
	for _,te1 in pairs(t1) do
		res=res+te1:GetValue()
	end
	--check for effects that change weakness
	local t2={c:IsHasEffect(EFFECT_CHANGE_WEAKNESS_TYPE)}
	for _,te2 in pairs(t2) do
		res=te2:GetValue()
	end
	--check for effects that turn off weakness
	if c:IsHasEffect(EFFECT_NO_WEAKNESS) then res=0 end
	return res
end
--check if a pokemon has a particular energy type in its weakness
function Card.IsWeaknessType(c,...)
	local res=nil
	local energy_list={...}
	for _,energy_type in ipairs(energy_list) do
		if c.weakness_x2 then
			for _,weakness in ipairs(c.weakness_x2) do
				if energy_type==weakness then res=true end
			end
		elseif c.weakness_10 then
			for _,weakness in ipairs(c.weakness_10) do
				if energy_type==weakness then res=true end
			end
		elseif c.weakness_20 then
			for _,weakness in ipairs(c.weakness_20) do
				if energy_type==weakness then res=true end
			end
		elseif c.weakness_30 then
			for _,weakness in ipairs(c.weakness_30) do
				if energy_type==weakness then res=true end
			end
		elseif c.weakness_40 then
			for _,weakness in ipairs(c.weakness_40) do
				if energy_type==weakness then res=true end
			end
		end
		--check for effects that add weakness
		local t1={c:IsHasEffect(EFFECT_ADD_WEAKNESS_TYPE)}
		for _,te1 in pairs(t1) do
			if energy_type==te1:GetValue() then res=true end
		end
		--check for effects that change weakness
		local t2={c:IsHasEffect(EFFECT_CHANGE_WEAKNESS_TYPE)}
		for _,te2 in pairs(t2) do
			if energy_type==te2:GetValue() then res=true end
		end
		--check for effects that turn off weakness
		if c:IsHasEffect(EFFECT_NO_WEAKNESS) then res=false end
	end
	return res
end
--get a pokemon's resistance energy type
function Card.GetResistanceType(c)
	local res=0
	if c.resistance_20 then
		for _,energy_type in pairs(c.resistance_20) do
			res=res+energy_type
		end
	elseif c.resistance_30 then
		for _,energy_type in pairs(c.resistance_30) do
			res=res+energy_type
		end
	end
	--check for effects that add resistance
	local t1={c:IsHasEffect(EFFECT_ADD_RESISTANCE_TYPE)}
	for _,te1 in pairs(t1) do
		res=res+te1:GetValue()
	end
	--check for effects that change resistance
	local t2={c:IsHasEffect(EFFECT_CHANGE_RESISTANCE_TYPE)}
	for _,te2 in pairs(t2) do
		res=te2:GetValue()
	end
	--check for effects that turn off resistance
	if c:IsHasEffect(EFFECT_NO_RESISTANCE) then res=0 end
	return res
end
--check if a pokemon has a particular energy type in its resistance
function Card.IsResistanceType(c,...)
	local res=nil
	local energy_list={...}
	for _,energy_type in ipairs(energy_list) do
		if c.resistance_20 then
			for _,resist in ipairs(c.resistance_20) do
				if energy_type==resist then res=true end
			end
		elseif c.resistance_30 then
			for _,resist in ipairs(c.resistance_30) do
				if energy_type==resist then res=true end
			end
		end
		--check for effects that add resistance
		local t1={c:IsHasEffect(EFFECT_ADD_RESISTANCE_TYPE)}
		for _,te1 in pairs(t1) do
			if energy_type==te1:GetValue() then res=true end
		end
		--check for effects that change resistance
		local t2={c:IsHasEffect(EFFECT_CHANGE_RESISTANCE_TYPE)}
		for _,te2 in pairs(t2) do
			if energy_type==te2:GetValue() then res=true end
		end
		--check for effects that turn off resistance
		if c:IsHasEffect(EFFECT_NO_RESISTANCE) then res=false end
	end
	return res
end
--get a pokemon's weakness numeral
function Card.GetWeaknessCount(c)
	local res=0
	if c.weakness_x2 then res=2
	elseif c.weakness_10 then res=10
	elseif c.weakness_20 then res=20
	elseif c.weakness_30 then res=30
	elseif c.weakness_40 then res=40 end
	--check for effects that add weakness
	local t1={c:IsHasEffect(EFFECT_ADD_WEAKNESS_COUNT)}
	for _,te1 in pairs(t1) do
		res=te1:GetValue()
	end
	--check for effects that change weakness
	local t2={c:IsHasEffect(EFFECT_SET_WEAKNESS_COUNT)}
	for _,te2 in pairs(t2) do
		res=te2:GetValue()
	end
	--check for effects that turn off weakness
	if c:IsHasEffect(EFFECT_NO_WEAKNESS) then res=0 end
	return res
end
--get a pokemon's resistance numeral
function Card.GetResistanceCount(c)
	local res=0
	if c.resistance_20 then res=-20
	elseif c.resistance_30 then res=-30 end
	--check for effects that add resistance
	local t1={c:IsHasEffect(EFFECT_ADD_RESISTANCE_COUNT)}
	for _,te1 in pairs(t1) do
		res=te1:GetValue()
	end
	--check for effects that increase or decrease resistance
	local t2={c:IsHasEffect(EFFECT_UPDATE_RESISTANCE_COUNT)}
	for _,te2 in pairs(t2) do
		res=res-te2:GetValue()
	end
	--check for effects that turn off resistance
	if c:IsHasEffect(EFFECT_NO_RESISTANCE) then res=0 end
	return res
end
--check if a pokemon has a weakness
function Card.IsHasWeakness(c)
	return c:GetWeaknessType()>0
end
--check if a pokemon has a resistance
function Card.IsHasResistance(c)
	return c:GetResistanceType()>0
end
--check if a pokemon has dual weakness
function Card.IsHasDualWeakness(c)
	return (c.weakness_x2 and #c.weakness_x2==2)
		or (c.weakness_10 and #c.weakness_10==2)
		or (c.weakness_20 and #c.weakness_20==2)
		or (c.weakness_30 and #c.weakness_30==2)
		or (c.weakness_40 and #c.weakness_40==2)
end
--check if a pokemon has dual resistance
function Card.IsHasDualResistance(c)
	return (c.resistance_20 and #c.resistance_20==2)
		or (c.resistance_30 and #c.resistance_30==2)
end
--add weakness to a pokemon that does not have a weakness
function Card.AddWeakness(c,weak_type,weak_count)
	--weak_type: the energy type of the weakness
	--weak_count: the weakness numeral
	if c:IsHasWeakness() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_WEAKNESS_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetValue(weak_type)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_ADD_WEAKNESS_COUNT)
	e2:SetValue(weak_count)
	c:RegisterEffect(e2,true)
end
--add resistance to a pokemon that does not have a resistance
function Card.AddResistance(c,resist_type,resist_count)
	--resist_type: the energy type of the resistance
	--resist_count: the resistance numeral
	if c:IsHasResistance() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_RESISTANCE_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetValue(resist_type)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_ADD_RESISTANCE_COUNT)
	e2:SetValue(resist_count)
	c:RegisterEffect(e2,true)
end
--get the length printed on a pokemon's card (not to be confused with height)
function Card.GetLength(c)
	return c.length
end
--get the height printed on a pokemon's card (not to be confused with length)
function Card.GetHeight(c)
	return c.height
end
--check if a pokemon has length printed on its card (not to be confused with height)
function Card.IsHasLength(c)
	return c.length
end
--check if a pokemon has height printed on its card (not to be confused with length)
function Card.IsHasHeight(c)
	return c.height
end
--check if a pokemon has an evolution chain (required for effects that evolve pokemon)
--Note: Update this function if a Pokemon with an evolution chain of 5 or more branches is introduced
function Card.IsHasEvolutionChain(c)
	if c:IsMegaEvolution() or c:IsPokemonBREAK() or c:IsPokemonVMAX() then return false end
	return c.evolution_list1 or c.evolution_list2 or c.evolution_list3 or c.evolution_list4
		or c.mega_evolution_list or c.break_evolution_list or c.vmax_evolution_list
end
--check if a pokemon is active
function Card.IsActive(c)
	return c:IsLocation(LOCATION_ACTIVE) and c:GetSequence()>=SEQ_MZONE_EX_LEFT
end
--check if a pokemon is on the bench
function Card.IsBenched(c)
	return (c:IsLocation(LOCATION_BENCH) and c:GetSequence()<SEQ_MZONE_EX_LEFT)
		--bench extended due to "Sky Field" (Roaring Skies 89/108)
		or (c:IsLocation(LOCATION_BENCHEXT) and c:GetSequence()~=SEQ_FZONE)
end
--check if a pokemon is in play
function Card.IsInPlay(c)
	return c:IsActive() or c:IsBenched()
end
--check if a pokemon was active before it left play
function Card.IsPreviousActive(c)
	return c:GetPreviousSequence()==SEQ_MZONE_EX_LEFT
end
--check if a pokemon is damaged
function Card.IsDamaged(c)
	return c:GetCounter(COUNTER_DAMAGE)>0
end
--get the amount of damage that has been done to a pokemon
function Card.GetDamage(c)
	return c:GetCounter(COUNTER_DAMAGE)*10
end
--check if a pokemon is asleep
function Card.IsAsleep(c)
	return c:IsHasEffect(EFFECT_ASLEEP)
end
--check if a pokemon is burned
function Card.IsBurned(c)
	return c:IsHasEffect(EFFECT_BURNED)
end
--check if a pokemon is confused
function Card.IsConfused(c)
	return c:IsHasEffect(EFFECT_CONFUSED)
end
--check if a pokemon is paralyzed
function Card.IsParalyzed(c)
	return c:IsHasEffect(EFFECT_PARALYZED)
end
--check if a pokemon is poisoned
function Card.IsPoisoned(c)
	return c:IsHasEffect(EFFECT_POISONED)
end
--check if a pokemon is affected by a special condition
function Card.IsAffectedBySpecialCondition(c)
	return c:IsAsleep() or c:IsBurned() or c:IsConfused() or c:IsParalyzed() or c:IsPoisoned()
end
--check if a pokemon can be asleep
function Card.IsCanBeAsleep(c)
	return not c:IsAsleep()
		and not c:IsHasEffect(EFFECT_IMMUNE_ASLEEP) and not c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--check if a pokemon can be burned
function Card.IsCanBeBurned(c)
	return not c:IsBurned()
		and not c:IsHasEffect(EFFECT_IMMUNE_BURNED) and not c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--check if a pokemon can be confused
function Card.IsCanBeConfused(c)
	return not c:IsConfused()
		and not c:IsHasEffect(EFFECT_IMMUNE_CONFUSED) and not c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--check if a pokemon can be paralyzed
function Card.IsCanBeParalyzed(c)
	return not c:IsParalyzed()
		and not c:IsHasEffect(EFFECT_IMMUNE_PARALYZED) and not c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--check if a pokemon can be poisoned
function Card.IsCanBePoisoned(c)
	return not c:IsHasEffect(EFFECT_IMMUNE_POISONED) and not c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--check if a pokemon is unaffected by a special condition
function Card.IsImmuneToSpecialCondition(c)
	return c:IsHasEffect(EFFECT_IMMUNE_ASLEEP) or c:IsHasEffect(EFFECT_IMMUNE_BURNED)
		or c:IsHasEffect(EFFECT_IMMUNE_CONFUSED) or c:IsHasEffect(EFFECT_IMMUNE_PARALYZED)
		or c:IsHasEffect(EFFECT_IMMUNE_POISONED) or c:IsHasEffect(EFFECT_IMMUNE_SPECIAL_CONDITION)
end
--apply a special condition to a pokemon
function Card.ApplySpecialCondition(c,player,spc)
	--c: the pokemon to apply the special condition to
	--player: the player who applies the special condition
	--spc: the special condition to apply (SPC)
	local res=nil
	if bit.band(spc,SPC_ASLEEP)~=0 and c:IsCanBeAsleep() then
		--apply asleep
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_ASLEEP)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ASLEEP)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		--asleep check
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_ASLEEP_CHECK)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCountLimit(1)
		e2:SetLabelObject(c)
		e2:SetCondition(aux.CheckAsleepCondition)
		e2:SetOperation(aux.CheckAsleepOperation)
		Duel.RegisterEffect(e2,player)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_ASLEEP)
		res=true
	end
	if bit.band(spc,SPC_BURNED)~=0 and c:IsCanBeBurned() then
		c:AddMarker(player,MARKER_BURN,1,REASON_RULE)
		--apply burned
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_BURNED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_BURNED)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		--burned check
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_BURNED_CHECK)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCountLimit(1)
		e2:SetLabelObject(c)
		e2:SetCondition(aux.CheckBurnedCondition)
		e2:SetOperation(aux.CheckBurnedOperation)
		Duel.RegisterEffect(e2,player)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_BURNED)
		res=true
	end
	if bit.band(spc,SPC_CONFUSED)~=0 and c:IsCanBeConfused() then
		--apply confused
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_CONFUSED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CONFUSED)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		--confused check
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_CONFUSED_CHECK)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PRE_ATTACK)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetRange(LOCATION_INPLAY)
		e2:SetCondition(aux.CheckConfusedCondition)
		e2:SetOperation(aux.CheckConfusedOperation)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_CONFUSED)
		res=true
	end
	if bit.band(spc,SPC_PARALYZED)~=0 and c:IsCanBeParalyzed() then
		--apply paralyzed
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_PARALYZED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PARALYZED)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		--paralyzed check
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_PARALYZED_CHECK)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCountLimit(1)
		e2:SetLabelObject(c)
		e2:SetCondition(aux.CheckParalyzedCondition)
		e2:SetOperation(aux.CheckParalyzedOperation)
		if Duel.GetTurnPlayer()~=c:GetControler() then
			e2:SetLabel(Duel.GetTurnCount())
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e2:SetLabel(0)
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e2,player)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_PARALYZED)
		res=true
	end
	if bit.band(spc,SPC_POISONED)~=0 and c:IsCanBePoisoned() then
		c:AddMarker(player,MARKER_POISON,1,REASON_RULE)
		--apply poisoned
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(DESC_POISONED)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_POISONED)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		--poisoned check
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(DESC_POISONED_CHECK)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCountLimit(1)
		e2:SetLabelObject(c)
		e2:SetCondition(aux.CheckPoisonedCondition)
		e2:SetOperation(aux.CheckPoisonedOperation)
		Duel.RegisterEffect(e2,player)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_POISONED)
		res=true
	end
	return res
end
function aux.CheckAsleepCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsAsleep() then
		return true
	else
		e:Reset()
		return false
	end
end
function aux.CheckAsleepOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local cp=tc:GetControler()
	local coins_left=1
	--check for effects that increase the coin flip
	local t={Duel.IsPlayerAffectedByEffect(cp,EFFECT_ASLEEP_TOSS_EXTRA_COIN)}
	for _,te in pairs(t) do
		coins_left=coins_left+te:GetValue()
	end
	local awaken=true
	while coins_left>0 do
		if Duel.TossCoin(cp,1)==RESULT_TAILS then awaken=false end
		coins_left=coins_left-1
	end
	if awaken then
		tc:RemoveSpecialCondition(cp,SPC_ASLEEP)
	end
end
function aux.CheckBurnedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsBurned() then
		return true
	else
		e:Reset()
		return false
	end
end
function aux.CheckBurnedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local cp=tc:GetControler()
	local damc=2
	--check for effects that increase or decrease the number of damage counters
	local t1={Duel.IsPlayerAffectedByEffect(cp,EFFECT_UPDATE_BURNED_DAMAGE)}
	for _,te1 in pairs(t1) do
		damc=damc+te1:GetValue()
	end
	--check for effects that replace the number of damage counters
	local t2={Duel.IsPlayerAffectedByEffect(cp,EFFECT_REPLACE_BURNED_DAMAGE)}
	for _,te2 in pairs(t2) do
		damc=te2:GetValue()
	end
	tc:AddCounter(cp,COUNTER_DAMAGE,damc,REASON_RULE)
	--check for effects that prevent removing the burned special condition
	if Duel.TossCoin(cp,1)==RESULT_HEADS and not Duel.IsPlayerAffectedByEffect(cp,EFFECT_DONOT_REMOVE_BURNED_HEADS) then
		tc:RemoveSpecialCondition(cp,SPC_BURNED)
	end
end
function aux.CheckConfusedCondition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsConfused() and re:IsHasCategory(CATEGORY_POKEMON_ATTACK)
end
function aux.CheckConfusedOperation(e,tp,eg,ep,ev,re,r,rp)
	local damc=3
	--check for effects that increase or decrease the number of damage counters
	local t1={Duel.IsPlayerAffectedByEffect(tp,EFFECT_UPDATE_CONFUSED_DAMAGE)}
	for _,te1 in pairs(t1) do
		damc=damc+te1:GetValue()
	end
	--check for effects that replace the number of damage counters
	local t2={Duel.IsPlayerAffectedByEffect(tp,EFFECT_REPLACE_CONFUSED_DAMAGE)}
	for _,te2 in pairs(t2) do
		damc=te2:GetValue()
	end
	if Duel.TossCoin(tp,1)==RESULT_TAILS and re:GetHandler():AddCounter(tp,COUNTER_DAMAGE,damc,REASON_RULE) then
		Duel.NegatePokemonAttack(ev)
	end
end
function aux.CheckParalyzedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:IsParalyzed() and Duel.GetTurnPlayer()==tc:GetControler() and Duel.GetTurnCount()~=e:GetLabel()
end
function aux.CheckParalyzedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:RemoveSpecialCondition(tc:GetControler(),SPC_PARALYZED)
end
function aux.CheckPoisonedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsPoisoned() then
		return true
	else
		e:Reset()
		return false
	end
end
function aux.CheckPoisonedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local cp=tc:GetControler()
	local damc=1
	--check for effects that increase or decrease the number of damage counters
	local t1={Duel.IsPlayerAffectedByEffect(cp,EFFECT_UPDATE_POISONED_DAMAGE)}
	for _,te1 in pairs(t1) do
		damc=damc+te1:GetValue()
	end
	--check for effects that replace the number of damage counters
	local t2={tc:IsHasEffect(EFFECT_REPLACE_POISONED_DAMAGE)}
	for _,te2 in pairs(t2) do
		damc=te2:GetValue()
	end
	local t3={Duel.IsPlayerAffectedByEffect(cp,EFFECT_REPLACE_POISONED_DAMAGE)}
	for _,te3 in pairs(t3) do
		damc=te3:GetValue()
	end
	tc:AddCounter(cp,COUNTER_DAMAGE,damc,REASON_RULE)
end
--remove a special condition affecting a pokemon
function Card.RemoveSpecialCondition(c,player,spc)
	--c: the pokemon to remove the special condition from
	--player: the player who removes the special condition
	--spc: the special condition to remove (SPC)
	local res=nil
	if bit.band(spc,SPC_ASLEEP)~=0 and c:IsAsleep() then
		if c:IsPosition(POS_FACEUP_COUNTERCLOCKWISE) and not c:IsParalyzed() then
			Duel.ChangePosition(c,POS_FACEUP_UPSIDE)
		end
		c:ResetEffect(EFFECT_ASLEEP,RESET_CODE)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_ASLEEP_CLEAR)
		res=true
	end
	if bit.band(spc,SPC_BURNED)~=0 and c:IsBurned() then
		if c:GetMarker(MARKER_BURN)>0 then
			c:RemoveMarker(player,MARKER_BURN,1,REASON_RULE)
		end
		c:ResetEffect(EFFECT_BURNED,RESET_CODE)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_BURNED_CLEAR)
		res=true
	end
	if bit.band(spc,SPC_CONFUSED)~=0 and c:IsConfused() then
		c:ResetEffect(EFFECT_CONFUSED,RESET_CODE)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_CONFUSED_CLEAR)
		res=true
	end
	if bit.band(spc,SPC_PARALYZED)~=0 and c:IsParalyzed() then
		if c:IsPosition(POS_FACEUP_CLOCKWISE) and not c:IsAsleep() then
			Duel.ChangePosition(c,POS_FACEUP_UPSIDE)
		end
		c:ResetEffect(EFFECT_PARALYZED,RESET_CODE)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_PARALYZED_CLEAR)
		res=true
	end
	if bit.band(spc,SPC_POISONED)~=0 and c:IsPoisoned() then
		if c:GetMarker(MARKER_POISON)>0 then
			c:RemoveMarker(player,MARKER_POISON,1,REASON_RULE)
		end
		c:ResetEffect(EFFECT_POISONED,RESET_CODE)
		Duel.HintSelection(Group.FromCards(c))
		Duel.Hint(HINT_OPSELECTED,1-player,DESC_POISONED_CLEAR)
		res=true
	end
	return res
end
--check if a pokemon can attack
function Card.IsCanAttack(c,e)
	if Duel.IsFirstTurn() or c:IsParalyzed() or c:IsHasEffect(EFFECT_CANNOT_ATTACK) then return false end
	if c:IsAsleep() and not e:IsHasProperty(EFFECT_FLAG_ATTACK_IGNORE_ASLEEP) then return false end
	return c:IsActive() and Duel.GetDefendingPokemon()
end
--check if an active pokemon can be retreated to the bench
function Card.IsCanRetreat(c)
	local cp=c:GetControler()
	if Duel.GetFlagEffect(cp,EFFECT_RETREAT_CHECK)>0 or Duel.GetBenchedPokemon(cp):GetCount()==0 then return false end
	if c:IsAsleep() and not c:IsHasEffect(EFFECT_ASLEEP_RETREAT) then return false end
	if c:IsParalyzed() and not c:IsHasEffect(EFFECT_PARALYZED_RETREAT) then return false end
	if c:IsHasEffect(EFFECT_CANNOT_RETREAT) or not c:IsActive() then return false end
	local g=c:GetAttachedGroup()
	local ct=g:Filter(Card.IsEnergy,nil):GetSum(Card.GetEnergyCount)
	return ct>=c:GetRetreatCost()
end
--check if a pokemon is retreating
function Card.IsRetreating(c)
	return c:IsStatus(STATUS_RETREATING)
end
--check if a pokemon can evolve
function Card.IsCanEvolve(c,e,player,ignore_play_turn,ignore_first_turn)
	--c: the pokemon to check
	--e: reserved
	--player: the player who evolves the pokemon
	--ignore_play_turn: true if the pokemon can evolve during the same turn it is played
	--ignore_first_turn: true if the pokemon can evolve during a player's first turn
	if c:IsHasEffect(EFFECT_CANNOT_EVOLVE) or not c:IsHasEvolutionChain() then return false end
	return (not c:IsStatus(STATUS_PLAY_TURN) or c:IsHasEffect(EFFECT_EVOLVE_PLAY_TURN)
		or Duel.IsPlayerAffectedByEffect(player,EFFECT_EVOLVE_PLAY_TURN) or ignore_play_turn)
		and (not Duel.IsFirstTurn(player) or c:IsHasEffect(EFFECT_EVOLVE_FIRST_TURN)
		or Duel.IsPlayerAffectedByEffect(player,EFFECT_EVOLVE_FIRST_TURN) or ignore_first_turn)
end
--check if a pokemon can level up
function Card.IsCanLevelUp(c,e,player,ignore_play_turn,ignore_active_rule)
	--c: the pokemon to check
	--e: reserved
	--player: the player who levels up the pokemon
	--ignore_play_turn: true if the pokemon can level up during the same turn it is played
	--ignore_active_rule: true if the pokemon does not need to be active
	if c:IsHasEffect(EFFECT_CANNOT_LEVEL_UP) or c:IsPokemonLVX() or not c.level_up_list then return false end
	return (not c:IsStatus(STATUS_PLAY_TURN) or ignore_play_turn) and (c:IsActive() or ignore_active_rule)
		and not Duel.IsFirstTurn(player)
end
--check if a pokemon can use a pokemon power
function Card.IsCanUsePokemonPower(c)
	return not c:IsHasEffect(EFFECT_DISABLE_POKEMON_POWER)
end
--check if a pokemon can use a poke-power
function Card.IsCanUsePokePower(c)
	return not c:IsHasEffect(EFFECT_DISABLE_POKEPOWER)
end
--check if a pokemon can use a poke-body
function Card.IsCanUsePokeBody(c)
	return not c:IsHasEffect(EFFECT_DISABLE_POKEBODY)
end
--check if a pokemon can use an ability
function Card.IsCanUseAbility(c)
	return not c:IsHasEffect(EFFECT_DISABLE_ABILITY)
end
--check if a pokemon can use a GX attack
function Card.IsCanUseGXAttack(c)
	if c:IsHasEffect(EFFECT_IGNORE_USED_GX_ATTACK) then return true end
	return Duel.GetFlagEffect(c:GetControler(),EFFECT_GX_ATTACK_CHECK)==0
end
--check if a pokemon can use the effect of a pokemon tool
function Card.IsCanUsePokemonTool(c)
	return not c:IsHasEffect(EFFECT_DISABLE_POKEMON_TOOL)
end
--check if a pokemon tool can be attached to a pokemon
function Card.IsCanAttachPokemonTool(c)
	local ct=c:GetAttachedGroup():FilterCount(Card.IsPokemonTool,nil)
	return ct==0 or (c:IsHasEffect(EFFECT_DOUBLE_POKEMON_TOOL) and ct<=1)
end
--check if a pokemon is immune to damage from attacks
function Card.IsImmuneToAttackDamage(c)
	return c:IsHasEffect(EFFECT_IMMUNE_ATTACK_DAMAGE)
end
--check if a pokemon can take damage
function Card.IsCanBeDamaged(c)
	return not c:IsHasEffect(EFFECT_CANNOT_BE_DAMAGED)
end
--check if a pokemon can be healed
function Card.IsCanBeHealed(c)
	return c:IsDamaged() and not c:IsHasEffect(EFFECT_CANNOT_BE_HEALED)
end
--check if a card was played from the hand (required for coming into play effects)
function Card.IsPlayedFromHand(c,playtype)
	--playtype: how the pokemon was played (SUMMON_TYPE)
	if not c:IsPreviousLocation(LOCATION_HAND+LOCATION_EXTRA) then return false end
	if c:IsTrainer() or c:IsEnergy() then return c:GetReasonPlayer()==c:GetOwner() end
	return c:GetPlayPlayer()==c:GetOwner() and (not playtype or c:IsPlayType(playtype))
end
--Renamed Card functions
--get a pokemon's original retreat cost
--Card.GetOriginalRetreatCost=Card.GetOriginalLevel --reserved
--check if a pokemon's retreat cost is equal to a given value
function Card.IsRetreatCost(c,cost)
	return c:GetRetreatCost()==cost
end
--check if a pokemon's retreat cost is less than or equal to a given value
--Card.IsRetreatCostBelow=Card.IsLevelBelow --reserved
--check if a pokemon's retreat cost is greater than or equal to a given value
Card.IsRetreatCostAbove=Card.IsLevelAbove
--get all energy types a card has
Card.GetEnergyType=Card.GetAttribute
--check if a card has a particular energy type
Card.IsEnergyType=Card.IsAttribute
--get a pokemon's remaining HP (hit points)
Card.GetRemainingHP=Card.GetAttack
--get a pokemon's maximum HP (hit points)
Card.GetMaxHP=Card.GetDefense
--check if a pokemon's remaining HP (hit points) is less than or equal to a given value
Card.IsRemainingHPBelow=Card.IsAttackBelow
--check if a pokemon's remaining HP (hit points) is greater than or equal to a given value
--Card.IsRemainingHPAbove=Card.IsAttackAbove --reserved
--check if a pokemon's maximum HP (hit points) is less than or equal to a given value
Card.IsMaxHPBelow=Card.IsDefenseBelow
--check if a pokemon's maximum HP (hit points) is greater than or equal to a given value
Card.IsMaxHPAbove=Card.IsDefenseAbove
--get a pokemon's play type (SUMMON_TYPE)
Card.GetPlayType=Card.GetSummonType
--check what a pokemon's play type (SUMMON_TYPE) is
Card.IsPlayType=Card.IsSummonType
--get the player who played the pokemon
Card.GetPlayPlayer=Card.GetSummonPlayer
--check if a pokemon can be played
Card.IsCanBePlayed=Card.IsCanBeSpecialSummoned
--check if c2 is the correct card for c1 to be attached to
function Card.CheckAttachedTarget(c1,c2)
	return c1:CheckEquipTarget(c2)
end
--get the card the attached cards are attached to
Card.GetAttachedTarget=Card.GetOverlayTarget
--get the group of cards attached to a card
Card.GetAttachedGroup=Card.GetOverlayGroup
--get the number of cards attached to a card
Card.GetAttachedCount=Card.GetOverlayCount
--check if a card can be put in the discard pile
Card.IsAbleToDPile=Card.IsAbleToGrave
--check if a card can be put in the lost zone
Card.IsAbleToLost=Card.IsAbleToRemove
--get the number of a particular marker on a card
Card.GetMarker=Card.GetCounter
--limit the number of markers that can be put on a card
Card.SetMarkerLimit=Card.SetCounterLimit
--check if a marker can be put on a pokemon
Card.IsCanAddMarker=Card.IsCanAddCounter
--add the pokemon information (such as types) to a non-pokemon card
Card.AddPokemonAttribute=Card.AddMonsterAttribute
Card.AddPokemonAttributeComplete=Card.AddMonsterAttributeComplete
--prevent a trainer card from being sent to the discard pile when its effect resolves
Card.CancelToDPile=Card.CancelToGrave
