--Overwritten Duel functions
--put a pokemon in play
--Note: Overwritten to register custom flag effects and to transfer counters & markers
Duel.PlayPokemonStep=Duel.SpecialSummonStep
Duel.PlayPokemonComplete=Duel.SpecialSummonComplete
local duel_special_summon=Duel.SpecialSummon
function Duel.SpecialSummon(targets,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone,remove_damage)
	--remove_damage: true to remove damage counters from a pokemon when it evolves
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	zone=zone or ZONE_MZONE
	local res=0
	for tc in aux.Next(targets) do
		if Duel.PlayPokemonStep(tc,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone) then
			if sumtype==SUMMON_TYPE_EVOLVE then
				--register Card.IsEvolved
				tc:RegisterFlagEffect(EFFECT_EVOLVED,RESET_EVENT+RESETS_STANDARD,0,1)
			end
			--transfer counters
			aux.TransferCounters(tc,remove_damage)
			--transfer markers
			aux.TransferMarkers(tc)
			--transfer special conditions
			aux.TransferSPC(tc)
			res=res+1
		end
	end
	Duel.PlayPokemonComplete()
	return res
end
Duel.PlayPokemon=Duel.SpecialSummon
--draw a card
--Note: Added parameter to allow a player to draw a card from the bottom of their deck
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason,bottom)
	--bottom: true to draw cards from the bottom of the deck instead of the top
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	if bottom then
		local g=Duel.GetDeckbottomGroup(player,count)
		Duel.DisableShuffleCheck()
		return Duel.SendtoHand(g,player,reason+REASON_DRAW)
	end
	return duel_draw(player,count,reason)
end
--check if a player can draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	count=count or 0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_is_player_can_draw(player,count)
end
--select a card
--Note: Overwritten to notify a player if there are no cards to select
local duel_select_matching_card=Duel.SelectMatchingCard
function Duel.SelectMatchingCard(sel_player,f,player,s,o,min,max,ex,...)
	if not Duel.IsExistingMatchingCard(f,player,s,o,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	return duel_select_matching_card(sel_player,f,player,s,o,min,max,ex,...)
end
--New Duel functions
--Note: Replace this funcion with Duel.SelectMatchingCard if YGOPro can forbid players to look at their face-down cards
function Duel.SelectMatchingPrizeCard(sel_player,f,target_player,min,max,ex,...)
	if not Duel.IsExistingMatchingCard(aux.AND(Card.IsPrize,f),target_player,LOCATION_PRIZE,0,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	local g=Duel.GetMatchingGroup(aux.AND(Card.IsPrize,f),target_player,LOCATION_PRIZE,0,ex,...)
	local sg1=Group.CreateGroup()
	if g:GetCount()>0 then
		--changed to random because face-down cards can be viewed
		local sg2=g:RandomSelect(sel_player,min,max)
		sg1:Merge(sg2)
	end
	return sg1
end
--get the bottom cards of a player's deck
function Duel.GetDeckbottomGroup(player,count)
	local f=function(c,count)
		local seq=c:GetSequence()
		return seq>=0 and seq<=count-1
	end
	return Duel.GetMatchingGroup(f,player,LOCATION_DECK,0,nil,count)
end
--sort the cards on the bottom of a player's deck in any order
function Duel.SortDeckbottom(sort_player,target_player,count)
	--sort_player: the player who sorts the cards
	--target_player: the player whose cards to sort
	--count: the number of cards to sort
	if count<=1 then return end
	for i=1,count do
		local g1=Duel.GetDeckbottomGroup(target_player,count)
		Duel.MoveSequence(g1:GetFirst(),SEQ_DECKTOP)
	end
	Duel.SortDecktop(sort_player,target_player,count)
	for i=1,count do
		local g2=Duel.GetDecktopGroup(target_player,count)
		Duel.MoveSequence(g2:GetFirst(),SEQ_DECKBOTTOM)
	end
end
--a player puts their card face down in front of them
function Duel.PutFacedown(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		local cp=tc:GetControler()
		Duel.MoveToField(tc,cp,cp,LOCATION_TEMPORARY,POS_FACEDOWN,true)
	end
end
--a player sets aside a card
function Duel.SetAside(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if Duel.Remove(tc,POS_FACEDOWN,reason)>0 then
			res=res+1
		end
	end
	return res
end
--a player selects a zone on their bench to put a card in
function Duel.SelectBenchZone(player)
	--player: the player who selects the zone
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOZONE)
	local seq=Duel.SelectDisableField(player,3,LOCATION_BENCH,0,0)
	return math.log(seq,2)
end
--a player selects a zone on the bench to render unusable
function Duel.SelectDisableBenchZone(player,count,s,o)
	--player: the player who selects the zone
	--count: the number of zones to select
	--s: your bench
	--o: opponent's bench
	s=s or LOCATION_BENCH
	o=o or 0
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISABLEZONE)
	return Duel.SelectDisableField(player,count,s,o,0)
end
--check if it is the first turn of the game or a player's first turn
function Duel.IsFirstTurn(player)
	--player: nil to check if it is the first turn of the game
	if player and Duel.GetTurnPlayer()~=player then return false end
	return Duel.GetTurnCount()==1
		or Duel.GetFlagEffect(PLAYER_ONE,EFFECT_SUDDEN_DEATH_CHECK)>0
		or Duel.GetFlagEffect(PLAYER_TWO,EFFECT_SUDDEN_DEATH_CHECK)>0
end
--check if a player can play a supporter card
function Duel.IsPlayerCanPlaySupporter(player)
	if Duel.IsFirstTurn() then return false end
	local ct=Duel.GetFlagEffect(player,EFFECT_SUPPORTER_CHECK)
	if Duel.IsPlayerAffectedByEffect(player,EFFECT_DOUBLE_SUPPORTER) and ct<=1 then return true end
	return ct==0
end
--check if a player can play a stadium card
function Duel.IsPlayerCanPlayStadium(player)
	return Duel.GetFlagEffect(player,EFFECT_STADIUM_CHECK)==0
end
--check if a player can play an energy card
function Duel.IsPlayerCanPlayEnergy(player,c)
	local ct=Duel.GetFlagEffect(player,EFFECT_ENERGY_CHECK)
	--check for "Blaine" (Gym Challenge 17/132) effect
	if c:IsHasEffect(EFFECT_BLAINE) and ct<=1 then return true end
	return ct==0
end
--check if a player has played a supporter card this turn
function Duel.CheckSupporterPlay(player)
	return Duel.GetFlagEffect(player,EFFECT_SUPPORTER_CHECK)>0
end
--check if a player has used their gx attack this game
function Duel.CheckGXAttackUse(player)
	return Duel.GetFlagEffect(player,EFFECT_GX_ATTACK_CHECK)>0
end
--a player retreats their active pokemon
--Not fully implemented: Duel.SwapSequence doesn't work when promoting Pokemon in LOCATION_BENCHEXT
function Duel.Retreat(player)
	local c=Duel.GetActivePokemon(player)
	if not c:IsCanRetreat() then return end
	local g=c:GetAttachedGroup():Filter(Card.IsEnergy,nil)
	local cost=c:GetRetreatCost()
	if cost>0 then
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
		local sg1=g:FilterSelect(player,Card.GetEnergyCount,cost,cost,nil)
		if Duel.SendtoDPile(sg1,REASON_COST+REASON_DISCARD+REASON_RETREAT)==0 then return end
	end
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_PROMOTE)
	local sg2=Duel.GetBenchedPokemon(player):Select(player,1,1,nil)
	if sg2:GetCount()==0 then return end
	Duel.HintSelection(sg2)
	Duel.SwapSequence(c,sg2:GetFirst())
	--register the retreat for the turn
	Duel.RegisterFlagEffect(player,EFFECT_RETREAT_CHECK,RESET_PHASE+PHASE_END,0,1)
	--raise event for "when this Pokemon retreats"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_RETREAT,Effect.GlobalEffect(),0,0,0,0)
end
--a player adds a card to their prize cards
function Duel.SendtoPrize(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		if tc:IsLocation(LOCATION_DECK) then Duel.DisableShuffleCheck() end
		Duel.Remove(tc,POS_FACEDOWN,reason)
		--register Card.IsPrize
		tc:RegisterFlagEffect(EFFECT_PRIZE_CARD,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
--a player takes their prize card
function Duel.TakePrize(player,min,max,reason)
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ATOHAND)
	--local g=Duel.SelectMatchingCard(player,aux.PrizeFilter(Card.IsAbleToHand),player,LOCATION_PRIZE,0,min,max,nil)
	local g=Duel.SelectMatchingPrizeCard(player,Card.IsAbleToHand,player,min,max,nil)
	for c in aux.Next(g) do
		--reset Card.IsPrize
		c:ResetFlagEffect(EFFECT_PRIZE_CARD)
		--raise event for "When you take this face-down Prize card, before putting it into your hand"
		--e.g. "Greedy Dice" (Steam Siege 102/114)
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_PRE_PRIZE_TAKE,Effect.GlobalEffect(),0,0,0,0)
		if not c:IsStatus(STATUS_ACTIVATED) then
			Duel.SendtoHand(c,PLAYER_OWNER,reason)
		end
		--register Duel.GetTakenPrizeCount
		Duel.RegisterFlagEffect(player,EFFECT_PRIZE_CARD_CHECK,0,0,1)
	end
end
--send a card to the lost zone
function Duel.SendtoLost(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsPrize() then
			--workaround to banish a banished card
			if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)>0 then
				Duel.ConfirmCards(1-tc:GetControler(),tc)
			end
		end
		res=res+Duel.Remove(tc,POS_FACEUP,reason)
	end
	return res
end
--a player turns their prize card face up or down
function Duel.TurnPrize(targets,pos)
	--targets: the prize to turn
	--pos: POS_FACEUP or POS_FACEDOWN
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	targets=targets:Filter(Card.IsPrize,nil)
	for tc in aux.Next(targets) do
		if (tc:IsFacedown() and pos==POS_FACEUP) or (tc:IsFaceup() and pos==POS_FACEDOWN) then
			--workaround to banish a banished card
			--Note: Remove this if YGOPro can flip a face-down banished card face-up
			Duel.DisableShuffleCheck(true)
			Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
			Duel.ConfirmCards(1-tc:GetControler(),tc)
			Duel.SendtoPrize(tc,REASON_RULE)
			Duel.DisableShuffleCheck(false)
		end
	end
end
--get a player's prize cards
function Duel.GetPrize(player)
	--player: nil to get any player's prize cards
	if player then
		return Duel.GetMatchingGroup(Card.IsPrize,player,LOCATION_PRIZE,0,nil)
	else
		return Duel.GetMatchingGroup(Card.IsPrize,0,LOCATION_PRIZE,LOCATION_PRIZE,nil)
	end
end
--get the number of prize cards a player has
function Duel.GetPrizeCount(player)
	return Duel.GetPrize(player):GetCount()
end
--get the number of prize cards a player has taken this game
function Duel.GetTakenPrizeCount(player)
	return Duel.GetFlagEffect(player,EFFECT_PRIZE_CARD_CHECK)
end
--get the number of unoccupied zones a player has on their bench
function Duel.GetFreeBenchCount(player)
	return Duel.GetLocationCount(player,LOCATION_BENCH)
end
--check if a player's bench is full
function Duel.IsBenchFull(player)
	return Duel.GetFreeBenchCount(player)<=0
end
--check if a player's bench is not full
function Duel.IsNotBenchFull(player)
	return not Duel.IsBenchFull(player)
end
--get a player's active pokemon
--Note: returns Card if player~=nil, otherwise returns Group
function Duel.GetActivePokemon(player)
	--player: nil to get both players' active pokemon
	if player then
		return Duel.GetFirstMatchingCard(aux.ActivePokemonFilter(),player,LOCATION_ACTIVE,0,nil)
	else
		local c1=Duel.GetFirstMatchingCard(aux.ActivePokemonFilter(),PLAYER_ONE,LOCATION_ACTIVE,0,nil)
		local c2=Duel.GetFirstMatchingCard(aux.ActivePokemonFilter(),PLAYER_TWO,LOCATION_ACTIVE,0,nil)
		return Group.FromCards(c1,c2)
	end
end
--get a player's benched pokemon
function Duel.GetBenchedPokemon(player)
	--player: nil to get both players' benched pokemon
	if player then
		return Duel.GetMatchingGroup(aux.BenchedPokemonFilter(),player,LOCATION_INPLAY,0,nil)
	else
		return Duel.GetMatchingGroup(aux.BenchedPokemonFilter(),0,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	end
end
--get a player's in-play pokemon
function Duel.GetInPlayPokemon(player)
	--player: nil to get both players' in-play pokemon
	if player then
		local g=Group.FromCards(Duel.GetActivePokemon(player))
		g:Merge(Duel.GetBenchedPokemon(player))
		return g
	else
		local g=Group.CreateGroup()
		g:Merge(Duel.GetActivePokemon())
		g:Merge(Duel.GetBenchedPokemon())
		return g
	end
end
--get the active pokemon that does the attack
function Duel.GetAttackingPokemon()
	return Duel.GetActivePokemon(Duel.GetTurnPlayer())
end
--get the active pokemon that receives the attack
function Duel.GetDefendingPokemon()
	return Duel.GetActivePokemon(1-Duel.GetTurnPlayer())
end
--get the devolved pokemon (required for immediately evolving a pokemon when it devolves)
function Duel.GetDevolvedPokemon()
	return Duel.GetFirstMatchingCard(Card.IsDevolved,0,LOCATION_INPLAY,LOCATION_INPLAY,nil)
end
--get a player's stadium card
function Duel.GetStadiumCard(player)
	--player: nil to get any player's stadium card
	if player then
		return Duel.GetFieldCard(player,LOCATION_SZONE,SEQ_FZONE)
	else
		local f=function(c)
			return c:IsFaceup() and c:IsStadium()
		end
		return Duel.GetFirstMatchingCard(f,0,LOCATION_INPLAY,LOCATION_INPLAY,nil)
	end
end
--attack animation that shows the player's active pokemon attacking the opponent's active pokemon
function Duel.PokemonAttack(c1,c2)
	--c1: the attacking pokemon
	--c2: the defending pokemon
	if c1 and c2 and not c1:IsStatus(STATUS_ATTACK_NEGATED) then
		Duel.CalculateDamage(c1,c2)
	end
end
--end the turn
function Duel.EndTurn()
	local turnp=Duel.GetTurnPlayer()
	Duel.SkipPhase(turnp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	local g=Duel.GetInPlayPokemon()
	for tc in aux.Next(g) do
		tc:IsStatus(STATUS_ATTACK_NEGATED,false)
	end
end
--make a pokemon's attack do nothing
function Duel.NegatePokemonAttack(chainc)
	--chainc: the activated attack to negate
	local tc=Duel.GetActivePokemon(Duel.GetTurnPlayer())
	if Duel.NegateActivation(chainc) then
		if tc then tc:SetStatus(STATUS_ATTACK_NEGATED,true) end
		Duel.EndTurn()
	end
end
--do damage to a pokemon by a pokemon's attack
--To-Do: Improve this function
function Duel.AttackDamage(e,count,c,apply_weak,apply_resist,apply_effect)
	--count: the amount of damage the attack does
	--c: the pokemon that receives damage (defending pokemon by default)
	--apply_weak: false to not apply weakness (applies by default vs defending pokemon)
	--apply_resist: false to not apply resistance (applies by default vs defending pokemon)
	--apply_effect: false to not apply effects that change the amount of damage done (applies by default)
	local reason_player=e:GetHandlerPlayer()
	local init_count=count
	local a=Duel.GetAttackingPokemon()
	c=c or Duel.GetDefendingPokemon()
	if apply_weak~=false and apply_weak==nil then apply_weak=true end
	if apply_resist~=false and apply_resist==nil then apply_resist=true end
	if apply_effect~=false and apply_effect==nil then apply_effect=true end
	--check for weakness
	if not a:IsEnergyType(c:GetWeaknessType()) or c:IsBenched() then apply_weak=false end
	--check for resistance
	if not a:IsEnergyType(c:GetResistanceType()) or c:IsBenched() then apply_resist=false end
	--check for "Prevent all effects, excluding damage" and "Prevent all effects of attacks, except damage"
	--(required for damaging a pokemon with these effects)
	if c:IsHasEffect(EFFECT_IMMUNE_EFFECT_NONDAMAGE) or c:IsHasEffect(EFFECT_IMMUNE_ATTACK_EFFECT_NONDAMAGE) then
		e:SetProperty(e:GetProperty()|EFFECT_FLAG_IGNORE_IMMUNE)
	end
	--check for effects that cause damage to be affected by weakness for benched pokemon
	--e.g. "Wide Lens" (Roaring Skies 95/108)
	if not apply_weak and c:IsBenched() and a:IsHasEffect(EFFECT_ATTACK_WEAKNESS_BENCH) then apply_weak=true end
	--check for effects that cause damage to be affected by resistance for benched pokemon
	--e.g. "Wide Lens" (Roaring Skies 95/108)
	if not apply_resist and c:IsBenched() and a:IsHasEffect(EFFECT_ATTACK_RESISTANCE_BENCH) then apply_resist=true end
	--check if the pokemon can be damaged
	if count==0 or not c:IsCanBeDamaged() or c:IsImmuneToAttackDamage() or c:IsFacedown() then return false end
	--check if the attacking pokemon is immune to its own damage (e.g. "Protection Cube" Flashfire 95/106)
	if c==a and a:IsHasEffect(EFFECT_IMMUNE_ATTACK_DAMAGE_SELF) then return false end
	--check for effects that ignore weakness
	if c:IsHasEffect(EFFECT_IGNORE_WEAKNESS) then apply_weak=false end
	--check for effects that ignore resistance
	if a:IsHasEffect(EFFECT_IGNORE_RESISTANCE) then apply_resist=false end
	--apply effects "before applying Weakness and Resistance"
	if apply_effect then
		--check for "Any damage done to the receiving Pokemon is reduced by N"
		local t1={c:IsHasEffect(EFFECT_UPDATE_DAMAGE_BEFORE)}
		for _,te1 in pairs(t1) do
			if type(te1:GetValue())=="function" then
				count=count+te1:GetValue()(te1,c)
			else
				count=count+te1:GetValue()
			end
		end
		--check for "The attacks do N more damage to your opponent's Active Pokemon"
		local t2={a:IsHasEffect(EFFECT_UPDATE_ATTACK_ACTIVE_BEFORE)}
		for _,te2 in pairs(t2) do
			if c:IsActive() then
				if type(te2:GetValue())=="function" then
					count=count+te2:GetValue()(te2,a)
				else
					count=count+te2:GetValue()
				end
			end
		end
		--check for "The attacks do N more damage to your opponent's Active Pokemon-EX"
		local t3={a:IsHasEffect(EFFECT_UPDATE_ATTACK_ACTIVE_EX_BEFORE)}
		for _,te3 in pairs(t3) do
			if c:IsActive() and c:IsPokemonEX() then
				if type(te3:GetValue())=="function" then
					count=count+te3:GetValue()(te3,a)
				else
					count=count+te3:GetValue()
				end
			end
		end
		--check for "The attacks do N more damage to your opponent's Active Pokemon-GX or Active Pokemon-EX"
		local t4={a:IsHasEffect(EFFECT_UPDATE_ATTACK_ACTIVE_GX_EX_BEFORE)}
		for _,te4 in pairs(t4) do
			if c:IsActive() and (c:IsPokemonGX() or c:IsPokemonEX()) then
				if type(te4:GetValue())=="function" then
					count=count+te4:GetValue()(te4,a)
				else
					count=count+te4:GetValue()
				end
			end
		end
		--check for "Any damage done to your opponent's Pokemon is reduced by N"
		local t5={a:IsHasEffect(EFFECT_UPDATE_ATTACK_OPPO_BEFORE)}
		for _,te5 in pairs(t5) do
			if a:GetControler()~=c:GetControler() then
				if type(te5:GetValue())=="function" then
					count=count+te5:GetValue()(te5,a)
				else
					count=count+te5:GetValue()
				end
			end
		end
		--check for "Any damage done by attacks is reduced by N"
		local t6={a:IsHasEffect(EFFECT_UPDATE_ATTACK_BEFORE)}
		for _,te6 in pairs(t6) do
			if type(te6:GetValue())=="function" then
				count=count+te6:GetValue()(te6,a)
			else
				count=count+te6:GetValue()
			end
		end
		--check for "The attacks of your opponent's Pokemon do N less damage"
		local t7={c:IsHasEffect(EFFECT_UPDATE_DEFEND_BEFORE)}
		for _,te7 in pairs(t7) do
			if type(te7:GetValue())=="function" then
				count=count+te7:GetValue()(te7,c)
			else
				count=count+te7:GetValue()
			end
		end
	end
	--apply weakness
	if apply_weak and c:GetWeaknessCount()>0 then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_WEAKNESS)
		if c:GetWeaknessCount()==2 then count=count*2
		else count=count+c:GetWeaknessCount() end
		--apply dual weakness
		if a:IsDualType() and c:IsHasDualWeakness() and a:GetEnergyType()==c:GetWeaknessType() then count=count*2 end
	end
	--apply resistance
	if apply_resist and c:GetResistanceCount()>0 then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_RESISTANCE)
		count=count+c:GetResistanceCount()
		--apply dual resistance
		if a:IsDualType() and c:IsHasDualResistance() and a:GetEnergyType()==c:GetResistanceType() then count=count*2 end
	end
	--apply effects "after applying Weakness and Resistance"
	if apply_effect then
		--check for "The attack does N more damage to the Defending Pokemon"
		local t8={a:IsHasEffect(EFFECT_UPDATE_ATTACK_ACTIVE_AFTER)}
		for _,te8 in pairs(t8) do
			if c:IsActive() then
				if type(te8:GetValue())=="function" then
					count=count+te8:GetValue()(te8,a)
				else
					count=count+te8:GetValue()
				end
			end
		end
		--check for "Pokemon take N less damage from the opponent's attacks"
		local t9={c:IsHasEffect(EFFECT_UPDATE_DEFEND_AFTER)}
		for _,te9 in pairs(t9) do
			if type(te9:GetValue())=="function" then
				count=count+te9:GetValue()(te9,c)
			else
				count=count+te9:GetValue()
			end
		end
		--check for "Any damage done by your opponent's Pokemon-ex is reduced by N"
		local t10={c:IsHasEffect(EFFECT_UPDATE_DEFEND_OPPO_EX_OLD_AFTER)}
		for _,te10 in pairs(t10) do
			if a:GetControler()~=c:GetControler() and a:IsPokemonex() then
				if type(te10:GetValue())=="function" then
					count=count+te10:GetValue()(te10,c)
				else
					count=count+te10:GetValue()
				end
			end
		end
		--check for "The receiving Pokemon takes N less damage from your opponent's attacks"
		local t11={c:IsHasEffect(EFFECT_UPDATE_DEFEND_OPPO_AFTER)}
		for _,te11 in pairs(t11) do
			if a:GetControler()~=c:GetControler() then
				if type(te11:GetValue())=="function" then
					count=count+te11:GetValue()(te11,c)
				else
					count=count+te11:GetValue()
				end
			end
		end
		--check for "The receiving Pokemon takes N less damage from your opponent's Pokemon-GX and Pokemon-EX attacks"
		local t12={c:IsHasEffect(EFFECT_UPDATE_DEFEND_OPPO_GX_EX2_AFTER)}
		for _,te12 in pairs(t12) do
			if a:GetControler()~=c:GetControler() and (a:IsPokemonGX() or a:IsPokemonEX()) then
				if type(te12:GetValue())=="function" then
					count=count+te12:GetValue()(te12,c)
				else
					count=count+te12:GetValue()
				end
			end
		end
		--check for "Any damage done to the receiving Pokemon from your opponent's Pokemon that have any Special Energy attached is reduced by N"
		local t13={c:IsHasEffect(EFFECT_UPDATE_DEFEND_OPPO_SPENERGY_AFTER)}
		for _,te13 in pairs(t13) do
			if a:GetControler()~=c:GetControler() and a:GetAttachedGroup():IsExists(Card.IsSpecialEnergy,1,nil) then
				if type(te13:GetValue())=="function" then
					count=count+te13:GetValue()(te13,c)
				else
					count=count+te13:GetValue()
				end
			end
		end
	end
	if count<=0 then return false end
	if count>init_count and not apply_weak and not apply_resist then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_DAMAGE_INCREASED)
	elseif count<init_count and not apply_weak and not apply_resist then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_DAMAGE_REDUCED)
	end
	local reason=REASON_ATTACK+REASON_DAMAGE
	local res=c:AddCounter(reason_player,COUNTER_DAMAGE,math.ceil(count/10),reason)
	e:SetProperty(e:GetProperty()&~EFFECT_FLAG_IGNORE_IMMUNE)
	if res then
		--raise event for "If an attack from a Pokemon does damage"
		Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_ATTACK_DAMAGE,Effect.GlobalEffect(),reason,reason_player,0,0)
		--raise event for "If this Pokemon is damaged by an opponent's attack"
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_ATTACK_DAMAGE,Effect.GlobalEffect(),reason,reason_player,0,0)
	end
	return res
end
--do damage to a pokemon by a pokemon's ability or trainer
--To-Do: Improve this function
function Duel.EffectDamage(e,count,c1,c2,apply_weak,apply_resist)
	--count: the amount of damage the ability or trainer does
	--c1: the card that does damage
	--c2: the pokemon that receives damage
	--apply_weak: false to not apply weakness (applies by default vs defending pokemon)
	--apply_resist: false to not apply resistance (applies by default vs defending pokemon)
	local reason_player=e:GetHandlerPlayer()
	local init_count=count
	c1=c1 or Duel.GetAttackingPokemon()
	c2=c2 or Duel.GetDefendingPokemon()
	if apply_weak~=false and apply_weak==nil then apply_weak=true end
	if apply_resist~=false and apply_resist==nil then apply_resist=true end
	--check for weakness
	if not c1:IsEnergyType(c2:GetWeaknessType()) or c2:IsBenched() then apply_weak=false end
	--check for resistance
	if not c1:IsEnergyType(c2:GetResistanceType()) or c2:IsBenched() then apply_resist=false end
	--check for "Prevent all effects, excluding damage" (required for damaging a pokemon with these effects)
	if c2:IsHasEffect(EFFECT_IMMUNE_EFFECT_NONDAMAGE) then
		e:SetProperty(e:GetProperty()|EFFECT_FLAG_IGNORE_IMMUNE)
	end
	--check if the pokemon can be damaged
	if count==0 or not c2:IsCanBeDamaged() or c2:IsFacedown() then return false end
	--check for effects that ignore weakness
	if c2:IsHasEffect(EFFECT_IGNORE_WEAKNESS) then apply_weak=false end
	--check for effects that ignore resistance
	if c1:IsHasEffect(EFFECT_IGNORE_RESISTANCE) then apply_resist=false end
	--check for "Any damage done to the receiving Pokemon is reduced by N"
	local t1={c2:IsHasEffect(EFFECT_UPDATE_DAMAGE_BEFORE)}
	for _,te1 in pairs(t1) do
		if type(te1:GetValue())=="function" then
			count=count+te1:GetValue()(te1,c2)
		else
			count=count+te1:GetValue()
		end
	end
	--apply weakness
	if apply_weak and c2:GetWeaknessCount()>0 then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_WEAKNESS)
		if c2:GetWeaknessCount()==2 then count=count*2
		else count=count+c2:GetWeaknessCount() end
		--apply dual weakness
		if c1:IsDualType() and c2:IsHasDualWeakness() and c1:GetEnergyType()==c2:GetWeaknessType() then count=count*2 end
	end
	--apply resistance
	if apply_resist and c2:GetResistanceCount()>0 then
		Duel.Hint(HINT_OPSELECTED,1-Duel.GetTurnPlayer(),DESC_RESISTANCE)
		count=count+c2:GetResistanceCount()
		--apply dual resistance
		if c1:IsDualType() and c2:IsHasDualResistance() and c1:GetEnergyType()==c2:GetResistanceType() then count=count*2 end
	end
	if count<=0 then return false end
	if count>init_count and not apply_weak and not apply_resist then
		Duel.Hint(HINT_OPSELECTED,1-turnp,DESC_DAMAGE_INCREASED)
	elseif count<init_count and not apply_weak and not apply_resist then
		Duel.Hint(HINT_OPSELECTED,1-turnp,DESC_DAMAGE_REDUCED)
	end
	local res=c2:AddCounter(reason_player,COUNTER_DAMAGE,math.ceil(count/10),REASON_EFFECT+REASON_DAMAGE)
	e:SetProperty(e:GetProperty()&~EFFECT_FLAG_IGNORE_IMMUNE)
	return res
end
--heal damage from a pokemon
function Duel.HealDamage(player,targets,count,reason)
	--player: the player who heals damage
	--targets: the pokemon to heal
	--count: the amount of damage to heal
	--reason: the reason for healing the pokemon
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=nil
	for tc in aux.Next(targets) do
		if tc:IsCanBeHealed() then
			tc:RemoveCounter(player,COUNTER_DAMAGE,math.ceil(count/10),reason)
			res=true
		end
	end
	return res
end
--switch counters between pokemon
function Duel.SwitchCounter(player,countertype,targets1,targets2,reason)
	--player: the player who switches the counters
	--countertype: the counters to switch
	--targets1: the first pokemon to switch counters from
	--targets2: the second pokemon to switch counters from
	--reason: the reason for switching the counters
	if type(targets1)=="Card" then targets1=Group.FromCards(targets1) end
	if type(targets2)=="Card" then targets2=Group.FromCards(targets2) end
	for tc1 in aux.Next(targets1) do
		for tc2 in aux.Next(targets2) do
			local ct1=tc1:GetCounter(countertype)
			local ct2=tc2:GetCounter(countertype)
			if ct1==ct2 then break end
			if ct1>0 then tc1:RemoveCounter(player,countertype,ct1,reason) end
			if ct2>0 then tc2:RemoveCounter(player,countertype,ct2,reason) end
			if ct2>0 then tc1:AddCounter(player,countertype,ct2,reason) end
			if ct1>0 then tc2:AddCounter(player,countertype,ct1,reason) end
		end
	end
end
--switch an active pokemon with a benched pokemon
--Not fully implemented: Transferring non-special condition effects onto pokemon on an extended bench
function Duel.SwitchPokemon(switch_player,target_player,f1,f2)
	--switch_player: the player who switches the pokemon
	--target_player: the player whose pokemon to switch
	--f1: filter function if the active pokemon is specified
	--f2: filter function if the benched pokemon is specified
	local g1=Group.FromCards(Duel.GetActivePokemon(target_player))
	local g2=Duel.GetBenchedPokemon(target_player)
	if f1 then g1=g1:Filter(f1,nil) end
	if f2 then g2=g2:Filter(f2,nil) end
	if g1:GetCount()==0 or g2:GetCount()==0 then return false end
	local tc1=g1:GetFirst()
	--register active pokemon counters
	local damc1=tc1:GetCounter(COUNTER_DAMAGE)
	local colc1=tc1:GetCounter(COUNTER_COLORING)
	local chac1=tc1:GetCounter(COUNTER_CHAR)
	--register active pokemon markers
	local rodm1=tc1:GetMarker(MARKER_LIGHTNING_ROD)
	local ivym1=tc1:GetMarker(MARKER_DARK_IVYSAUR)
	local prim1=tc1:GetMarker(MARKER_IMPRISON)
	local shom1=tc1:GetMarker(MARKER_SHOCKWAVE)
	Duel.Hint(HINT_SELECTMSG,switch_player,HINTMSG_PROMOTE)
	local tc2=g2:Select(switch_player,1,1,nil):GetFirst()
	--register benched pokemon counters
	local damc2=tc2:GetCounter(COUNTER_DAMAGE)
	local colc2=tc2:GetCounter(COUNTER_COLORING)
	local chac2=tc2:GetCounter(COUNTER_CHAR)
	--register benched pokemon markers
	local rodm2=tc2:GetMarker(MARKER_LIGHTNING_ROD)
	local ivym2=tc2:GetMarker(MARKER_DARK_IVYSAUR)
	local prim2=tc2:GetMarker(MARKER_IMPRISON)
	local shom2=tc2:GetMarker(MARKER_SHOCKWAVE)
	Duel.HintSelection(Group.FromCards(tc2))
	Duel.SwapSequence(tc1,tc2)
	if tc1:IsLocation(LOCATION_BENCHEXT) then
		--transfer counters
		if damc1>0 then tc1:AddCounter(switch_player,COUNTER_DAMAGE,damc1,REASON_RULE) end
		if colc1>0 then tc1:AddCounter(switch_player,COUNTER_COLORING,colc1,REASON_RULE) end
		if chac1>0 then tc1:AddCounter(switch_player,COUNTER_CHAR,chac1,REASON_RULE) end
		if damc2>0 then tc2:AddCounter(switch_player,COUNTER_DAMAGE,damc2,REASON_RULE) end
		if colc2>0 then tc2:AddCounter(switch_player,COUNTER_COLORING,colc2,REASON_RULE) end
		if chac2>0 then tc2:AddCounter(switch_player,COUNTER_CHAR,chac2,REASON_RULE) end
		--transfer markers
		if rodm1>0 then tc1:AddMarker(switch_player,MARKER_LIGHTNING_ROD,rodm1,REASON_RULE) end
		if ivym1>0 then tc1:AddMarker(switch_player,MARKER_DARK_IVYSAUR,ivym1,REASON_RULE) end
		if prim1>0 then tc1:AddMarker(switch_player,MARKER_IMPRISON,prim1,REASON_RULE) end
		if shom1>0 then tc1:AddMarker(switch_player,MARKER_SHOCKWAVE,shom1,REASON_RULE) end
		if rodm2>0 then tc2:AddMarker(switch_player,MARKER_LIGHTNING_ROD,rodm2,REASON_RULE) end
		if ivym2>0 then tc2:AddMarker(switch_player,MARKER_DARK_IVYSAUR,ivym2,REASON_RULE) end
		if prim2>0 then tc2:AddMarker(switch_player,MARKER_IMPRISON,prim2,REASON_RULE) end
		if shom2>0 then tc2:AddMarker(switch_player,MARKER_SHOCKWAVE,shom2,REASON_RULE) end
		--Not fully implemented: Transfer non-special condition effects
	end
	return true
end
--switch a pokemon in play with a pokemon that is not in play
--Not fully implemented: Transferring non-special condition effects
function Duel.SwitchPokemonOffField(switch_player,targets1,targets2,dest_loc,deck_seq,reason,add_effects)
	--switch_player: the player who switches the pokemon
	--targets1: the pokemon in play to switch
	--targets2: the new pokemon to switch with
	--dest_loc: where to put the old pokemon
	--deck_seq: where to put the old pokemon in the deck (SEQ_DECK)
	--reason: the reason for switching the pokemon
	--add_effects: true to transfer any special conditions and effects on the new pokemon
	if type(targets1)=="Card" then targets1=Group.FromCards(targets1) end
	if type(targets2)=="Card" then targets2=Group.FromCards(targets2) end
	if targets1:GetCount()==0 or targets2:GetCount()==0 then return false end
	for tc1 in aux.Next(targets1) do
		--add retreating status
		tc1:SetStatus(STATUS_RETREATING,true)
		for tc2 in aux.Next(targets2) do
			local target_player=tc2:GetControler()
			--add retreating status
			tc2:SetStatus(STATUS_RETREATING,true)
			--register attached cards
			local g=tc1:GetAttachedGroup()
			--workaround to prevent YGOPro from discarding attached cards
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_RULE)
			Duel.ConfirmCards(1-tc1:GetControler(),g)
			--register counters
			aux.RegisterCounters(tc1)
			--register markers
			aux.RegisterMarkers(tc1)
			--register special conditions
			aux.RegisterSPC(tc1,SPC_ALL)
			if dest_loc==LOCATION_HAND then
				Duel.SendtoHand(tc1,PLAYER_OWNER,reason)
			elseif dest_loc==LOCATION_DECK and deck_seq then
				Duel.SendtoDeck(tc1,PLAYER_OWNER,deck_seq,reason)
			elseif dest_loc==LOCATION_DPILE then
				Duel.SendtoDPile(tc1,reason)
			elseif dest_loc==LOCATION_LZONE then
				Duel.SendtoLost(tc1,reason)
			end
			local zone=bit.lshift(0x1,tc1:GetPreviousSequence())
			Duel.MoveToField(tc2,switch_player,target_player,LOCATION_BENCH,POS_FACEUP_UPSIDE,true,zone)
			--transfer attached cards
			Duel.Attach(e,tc2,g)
			if tc2:IsPreviousLocation(LOCATION_DECK) then Duel.ShuffleDeck(target_player) end
			--transfer counters
			aux.TransferCounters(tc2)
			--transfer markers
			aux.TransferMarkers(tc2)
			--transfer special conditions
			if add_effects then aux.TransferSPC(tc2) end
			--Not fully implemented: Transferring non-special condition effects
			--remove retreating status
			tc1:SetStatus(STATUS_RETREATING,false)
			tc2:SetStatus(STATUS_RETREATING,false)
		end
	end
	return true
end
--discard energy or a trainer card from a pokemon
function Duel.DiscardAttached(player,targets,f,min,max,reason,ex,...)
	--player: the player who discards the card
	--targets: the pokemon whose attached card to discard
	--f: filter function if the card is specified
	--min,max: the number of cards to discard
	--reason: the reason for discarding the card
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	f=f or aux.TRUE
	local res=0
	for tc in aux.Next(targets) do
		local g=tc:GetAttachedGroup()
		if g:GetCount()==0 then break end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_DISCARD)
		local sg=g:FilterSelect(player,f,min,max,ex,...)
		res=res+Duel.SendtoDPile(sg,reason+REASON_DISCARD)
	end
	return res
end
--select an energy type
function Duel.SelectEnergyType(player,colorless)
	--player: the player who selects the energy type
	--colorless: true to include colorless-type
	local option_list={}
	local type_list=colorless and aux.energy_type_list2 or aux.energy_type_list1
	local select_list=colorless and aux.energy_select_list2 or aux.energy_select_list1
	for _,opt in pairs(type_list) do
		table.insert(option_list,select_list[opt])
	end
	return type_list[Duel.SelectOption(player,table.unpack(option_list))+1]
end
aux.energy_type_list1={
	ENERGY_G,
	ENERGY_R,
	ENERGY_W,
	ENERGY_L,
	ENERGY_P,
	ENERGY_F,
	ENERGY_D,
	ENERGY_M,
	ENERGY_Y,
	ENERGY_N,
	--add new energy here
}
aux.energy_type_list2={
	ENERGY_G,
	ENERGY_R,
	ENERGY_W,
	ENERGY_L,
	ENERGY_P,
	ENERGY_F,
	ENERGY_D,
	ENERGY_M,
	ENERGY_C,
	ENERGY_Y,
	ENERGY_N,
	--add new energy here
}
aux.energy_select_list1={
	[ENERGY_G]=OPTION_GRASS,
	[ENERGY_R]=OPTION_FIRE,
	[ENERGY_W]=OPTION_WATER,
	[ENERGY_L]=OPTION_LIGHTNING,
	[ENERGY_P]=OPTION_PSYCHIC,
	[ENERGY_F]=OPTION_FIGHTING,
	[ENERGY_D]=OPTION_DARKNESS,
	[ENERGY_M]=OPTION_METAL,
	[ENERGY_Y]=OPTION_FAIRY,
	[ENERGY_N]=OPTION_DRAGON,
	--add new energy here
}
aux.energy_select_list2={
	[ENERGY_G]=OPTION_GRASS,
	[ENERGY_R]=OPTION_FIRE,
	[ENERGY_W]=OPTION_WATER,
	[ENERGY_L]=OPTION_LIGHTNING,
	[ENERGY_P]=OPTION_PSYCHIC,
	[ENERGY_F]=OPTION_FIGHTING,
	[ENERGY_D]=OPTION_DARKNESS,
	[ENERGY_M]=OPTION_METAL,
	[ENERGY_C]=OPTION_COLORLESS,
	[ENERGY_Y]=OPTION_FAIRY,
	[ENERGY_N]=OPTION_DRAGON,
	--add new energy here
}
--select a special condition on a pokemon to remove
function Duel.SelectRemoveSpecialCondition(player,c)
	--player: the player who selects the special condition
	--c: the pokemon that has the special condition
	local spc_list={}
	if c:IsAsleep() then table.insert(spc_list,1) end
	if c:IsBurned() then table.insert(spc_list,2) end
	if c:IsConfused() then table.insert(spc_list,3) end
	if c:IsParalyzed() then table.insert(spc_list,4) end
	if c:IsPoisoned() then table.insert(spc_list,5) end
	if #spc_list==0 then return end
	local option_list={}
	for _,te in pairs(spc_list) do
		table.insert(option_list,aux.spc_select_list[te])
	end
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_REMOVESPC)
	local spc=spc_list[Duel.SelectOption(player,table.unpack(option_list))+1]
	c:RemoveSpecialCondition(player,aux.spc_list[spc])
end
aux.spc_list={
	[1]=SPC_ASLEEP,
	[2]=SPC_BURNED,
	[3]=SPC_CONFUSED,
	[4]=SPC_PARALYZED,
	[5]=SPC_POISONED,
}
aux.spc_select_list={
	[1]=OPTION_ASLEEP,
	[2]=OPTION_BURNED,
	[3]=OPTION_CONFUSED,
	[4]=OPTION_PARALYZED,
	[5]=OPTION_POISONED,
}
--select a length ("Blaine's Quiz #1" Gym Heroes 97/132)
function Duel.SelectLength(player)
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_LENGTH)
	return Duel.AnnounceNumber(player,table.unpack(aux.length_list))
end
aux.length_list={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47}
--select a height ("Cedric Juniper" Legendary Treasures 110/113)
function Duel.SelectHeight(player)
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_HEIGHT)
	return Duel.AnnounceNumber(player,table.unpack(aux.height_list))
end
aux.height_list={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47}
--draw up to a number of cards
function Duel.DrawUpTo(player,count,reason,forced)
	--forced: true if a player must draw at least 1 card
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>count then deck_count=count end
	if deck_count>0 and Duel.IsPlayerCanDraw(player,1) then
		if forced or (not forced and Duel.SelectYesNo(player,YESNOMSG_DRAW)) then
			local t={}
			for i=1,deck_count do t[i]=i end
			Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCEDRAW)
			local draw_count=Duel.AnnounceNumber(player,table.unpack(t))
			return Duel.Draw(player,draw_count,reason)
		end
	end
	return 0
end
--attach a card to a pokemon
function Duel.Attach(e,c,targets)
	--c: the pokemon to attach the card to
	--targets: the card to attach to the pokemon
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--check for "Energy cards attached to that Pokemon can't be removed by your opponent's attacks or Trainer cards"
	--e.g. "Brock's Protection" (Gym Challenge 101/132)
	local filt_func=function(target)
		return target:IsHasEffect(EFFECT_BROCKS_PROTECTION)
	end
	local g=targets:Filter(filt_func,nil)
	targets:Sub(g)
	local ag=c:GetAttachedGroup()
	Duel.Overlay(c,targets)
	--workaround to put a newly attached card on the very bottom (required to devolve pokemon properly)
	if g:GetCount()==0 then
		for tc in aux.Next(ag) do
			if tc:IsLocation(LOCATION_ATTACHED) and not tc:IsPokemon() then
				Duel.DisableShuffleCheck(true)
				Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
				Duel.Overlay(c,tc)
				Duel.DisableShuffleCheck(false)
			end
		end
		for tc in aux.Next(ag) do
			if tc:IsLocation(LOCATION_ATTACHED) and tc:IsPokemon() then
				Duel.DisableShuffleCheck(true)
				Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
				Duel.Overlay(c,tc)
				Duel.DisableShuffleCheck(false)
			end
		end
	end
	for tc in aux.Next(targets) do
		--raise event for "When you attach this card to 1 of your Pokemon"
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_BECOME_ATTACHED,e,0,0,0,0)
		--raise event for "When you attach a card to this Pokemon"
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_ATTACH,e,0,0,0,0)
	end
	--raise event for "Whenever a player attaches a card to 1 of their Pokemon"
	Duel.RaiseEvent(targets,EVENT_CUSTOM+EVENT_ATTACH,e,0,0,0,0)
end
--move energy to a pokemon
function Duel.MoveEnergy(c,targets)
	--c: the pokemon to move the energy to
	--targets: the energy to move to the pokemon
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--check for "Energy cards attached to that Pokemon can't be removed by your opponent's attacks or Trainer cards"
	--e.g. "Brock's Protection" (Gym Challenge 101/132)
	local filt_func=function(target)
		return target:IsHasEffect(EFFECT_BROCKS_PROTECTION)
	end
	local g=targets:Filter(filt_func,nil)
	targets:Sub(g)
	local ag=c:GetAttachedGroup()
	Duel.Overlay(c,targets)
	--workaround to put a newly attached card on the very bottom (required to devolve pokemon properly)
	if g:GetCount()==0 then
		for tc in aux.Next(ag) do
			if tc:IsLocation(LOCATION_ATTACHED) and not tc:IsPokemon() then
				Duel.DisableShuffleCheck(true)
				Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
				Duel.Overlay(c,tc)
				Duel.DisableShuffleCheck(false)
			end
		end
		for tc in aux.Next(ag) do
			if tc:IsLocation(LOCATION_ATTACHED) and tc:IsPokemon() then
				Duel.DisableShuffleCheck(true)
				Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
				Duel.Overlay(c,tc)
				Duel.DisableShuffleCheck(false)
			end
		end
	end
end
--evolve a pokemon
function Duel.Evolve(c,targets,player,remove_damage)
	--c: the evolution pokemon to play
	--targets: the pokemon to evolve
	--player: the player who evolves the pokemon
	--remove_damage: true to remove all damage counters from the pokemon when it evolves
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	c:SetMaterial(targets) --required for EVENT_BE_MATERIAL
	for tc in aux.Next(targets) do
		--register counters
		aux.RegisterCounters(tc)
		--register markers
		aux.RegisterMarkers(tc)
		--register asleep special condition due to asleep not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_ASLEEP_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ASLEEP)
		end
		--register burned special condition due to burned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_BURNED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_BURNED)
		end
		--register confused special condition due to confused not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_CONFUSED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_CONFUSED)
		end
		--register paralyzed special condition due to paralyzed not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_PARALYZED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_PARALYZED)
		end
		--register poisoned special condition due to poisoned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_POISONED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_POISONED)
		end
		--register all special conditions due to any special condition not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_SPC_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ALL)
		end
		--check if the pokemon can evolve during the turn it is played
		local keep_evolve_play_turn=tc:IsHasEffect(EFFECT_EVOLVE_PLAY_TURN)
		--check if the pokemon can evolve during the first turn
		local keep_evolve_first_turn=tc:IsHasEffect(EFFECT_EVOLVE_FIRST_TURN)
		--workaround to play in ex mzone
		if tc:IsActive() then Duel.SendtoExtraP(c,PLAYER_OWNER,REASON_RULE) end
		--transfer attached cards
		local g=tc:GetAttachedGroup()
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
		Duel.Overlay(c,tc)
		local pos=c:IsPokemonBREAK() and POS_FACEUP_SIDEWAYS or POS_FACEUP_UPSIDE
		local zone=bit.lshift(0x1,tc:GetPreviousSequence())
		Duel.PlayPokemon(c,SUMMON_TYPE_EVOLVE,player,player,true,false,pos,zone,remove_damage)
		--transfer effects
		if keep_evolve_play_turn then
			aux.AddTempEffectCustom(c,c,DESC_EVOLVE_TURN,EFFECT_EVOLVE_PLAY_TURN,RESET_PHASE+PHASE_END)
		end
		if keep_evolve_first_turn then
			aux.AddTempEffectCustom(c,c,DESC_EVOLVE_FIRST_TURN,EFFECT_EVOLVE_FIRST_TURN,RESET_PHASE+PHASE_END)
		end
		--check if the pokemon is a Pokemon BREAK
		if c:IsPokemonBREAK() then
			--transfer attacks & effects
			c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD,1)
			--transfer weakness
			c:AddWeakness(tc:GetWeaknessType(),tc:GetWeaknessCount())
			--transfer resistance
			c:AddResistance(tc:GetResistanceType(),tc:GetResistanceCount())
			--transfer retreat cost
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_RETREAT_COST)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetValue(tc:GetRetreatCost())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1)
		end
	end
end
--devolve a pokemon
function Duel.Devolve(targets,dest_loc,deck_seq,reason,ignore_play_turn,ignore_first_turn)
	--targets: the pokemon to devolve
	--dest_loc: where to put the devolved pokemon
	--deck_seq: where to put the devolved pokemon in the deck (SEQ_DECK)
	--reason: the reason for devolving the pokemon
	--ignore_play_turn: true if the pokemon can evolve during the same turn it is played
	--ignore_first_turn: true if the pokemon can evolve during a player's first turn
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		--workaround to prevent YGOPro from discarding attached cards
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local c=e:GetHandler()
			local g=c:GetAttachedGroup()
			if g:GetCount()==0 then return end
			local tc=c:GetTopAttachedCard()
			local zone=bit.lshift(0x1,c:GetPreviousSequence())
			Duel.MoveToField(tc,tp,c:GetPreviousControler(),LOCATION_BENCH,c:GetPreviousPosition(),true,zone)
			--register Card.IsDevolved
			tc:RegisterFlagEffect(EFFECT_DEVOLVED,RESET_EVENT+RESETS_STANDARD,0,1)
			g:RemoveCard(tc)
			Duel.Attach(e,tc,g)
			e:Reset()
			--transfer counters
			aux.TransferCounters(tc)
			--transfer markers
			aux.TransferMarkers(tc)
			--transfer special conditions
			aux.TransferSPC(tc)
			--add played status
			tc:SetStatus(STATUS_PLAY_TURN,true)
			--remove played status
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetOperation(function(e)
				tc:SetStatus(STATUS_PLAY_TURN,false)
			end)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			--evolve turn played
			if ignore_play_turn then
				aux.AddTempEffectCustom(c,tc,DESC_EVOLVE_TURN,EFFECT_EVOLVE_PLAY_TURN,RESET_PHASE+PHASE_END)
			end
			--evolve first turn
			if ignore_first_turn then
				aux.AddTempEffectCustom(c,tc,DESC_EVOLVE_FIRST_TURN,EFFECT_EVOLVE_FIRST_TURN,RESET_PHASE+PHASE_END)
			end
		end)
		tc:RegisterEffect(e1)
		--register counters
		aux.RegisterCounters(tc)
		--register markers
		aux.RegisterMarkers(tc)
		--register asleep special condition due to asleep not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_ASLEEP_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ASLEEP)
		end
		--register burned special condition due to burned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_BURNED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_BURNED)
		end
		--register confused special condition due to confused not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_CONFUSED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_CONFUSED)
		end
		--register paralyzed special condition due to paralyzed not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_PARALYZED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_PARALYZED)
		end
		--register poisoned special condition due to poisoned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_POISONED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_POISONED)
		end
		--register all special conditions due to any special condition not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_SPC_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ALL)
		end
		if dest_loc==LOCATION_HAND then
			Duel.SendtoHand(tc,PLAYER_OWNER,reason)
		elseif dest_loc==LOCATION_DECK and deck_seq then
			Duel.SendtoDeck(tc,PLAYER_OWNER,deck_seq,reason)
		elseif dest_loc==LOCATION_DPILE then
			Duel.SendtoDPile(tc,reason+REASON_DISCARD)
		elseif dest_loc==LOCATION_LZONE then
			Duel.SendtoLost(tc,reason)
		end
	end
end
--level up a pokemon
--Not fully implemented: Transferring all pokemon attacks and effects to the leveled up Pokemon
function Duel.LevelUp(c,targets,player,ignore_active_rule)
	--c: the Pokemon LV.X to play
	--targets: the pokemon to level up
	--player: the player who levels up the pokemon
	--ignore_active_rule: true if the pokemon does not need to be active
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	c:SetMaterial(targets) --required for EVENT_BE_MATERIAL
	for tc in aux.Next(targets) do
		--register counters
		aux.RegisterCounters(tc)
		--register markers
		aux.RegisterMarkers(tc)
		--register asleep special condition due to asleep not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_ASLEEP_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ASLEEP)
		end
		--register burned special condition due to burned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_BURNED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_BURNED)
		end
		--register confused special condition due to confused not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_CONFUSED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_CONFUSED)
		end
		--register paralyzed special condition due to paralyzed not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_PARALYZED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_PARALYZED)
		end
		--register poisoned special condition due to poisoned not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_POISONED_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_POISONED)
		end
		--register all special conditions due to any special condition not being removed by evolving/devolving
		if tc:IsHasEffect(EFFECT_DONOT_REMOVE_SPC_EVOLVE_DEVOLVE) then
			aux.RegisterSPC(tc,SPC_ALL)
		end
		--workaround to play in ex mzone
		if tc:IsActive() then Duel.SendtoExtraP(c,PLAYER_OWNER,REASON_RULE) end
		--transfer attached cards
		local g=tc:GetAttachedGroup()
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
		Duel.Overlay(c,tc)
		local zone=ignore_active_rule and bit.lshift(0x1,tc:GetPreviousSequence()) or ZONE_MZONE_EX_LEFT
		Duel.PlayPokemon(c,SUMMON_TYPE_LEVEL_UP,player,player,true,false,POS_FACEUP_UPSIDE,zone)
		--transfer attacks & effects
		c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,1)
	end
end
--merge two halves of a card into a single card (required for playing Pokemon LEGEND)
function Duel.MergeCards(targets1,targets2)
	--targets1: the top card
	--targets2: the bottom card
	if type(targets1)=="Card" then targets1=Group.FromCards(targets1) end
	for tc in aux.Next(targets1) do
		Duel.Overlay(tc,targets2,REASON_RULE)
	end
end
--shuffle a player's prize cards
--Not fully implemented: Cannot shuffle banished cards
function Duel.ShufflePrize(player)
	local g=Duel.GetPrize(player)
	--workaround to shuffle banished cards
	Duel.SendtoHand(g,player,REASON_RULE)
	Duel.ShuffleHand(player)
	Duel.Remove(g,player,POS_FACEDOWN,REASON_RULE)
	for tc in aux.Next(g) do
		--register Card.IsPrize
		tc:RegisterFlagEffect(EFFECT_PRIZE_CARD,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
--Renamed Duel functions
--knock out a pokemon
Duel.KnockOut=Duel.Destroy
--send a card to the discard pile (including discard a card)
Duel.SendtoDPile=Duel.SendtoGrave
--get all the cards attached to a player's cards
Duel.GetAttachedGroup=Duel.GetOverlayGroup
--check if a player can put a pokemon in play
Duel.IsPlayerCanPlayPokemon=Duel.IsPlayerCanSpecialSummonMonster
