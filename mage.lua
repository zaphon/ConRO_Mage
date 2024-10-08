ConRO.Mage = {};
ConRO.Mage.CheckTalents = function()
end
ConRO.Mage.CheckPvPTalents = function()
end
local ConRO_Mage, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Mage.CheckTalents;
	self.ModuleOnEnable = ConRO.Mage.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Mage [No Specialization Under 10]";
		self.NextSpell = ConRO.Mage.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = "Mage [Arcane - Caster]";
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Mage.Arcane;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = "Mage [Fire - Caster]";
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Mage.Fire;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = "Mage [Frost - Caster]";
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Mage.Frost;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Mage.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 0;
	if mode == 0 then
		self.NextDef = ConRO.Mage.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Mage.ArcaneDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Mage.FireDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Mage.FrostDef;
		else
			self.NextDef = ConRO.Mage.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Mage.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

--Info
local _Player_Level = UnitLevel("player");
local _Player_Percent_Health = ConRO:PercentHealth('player');
local _is_PvP = ConRO:IsPvP();
local _in_combat = UnitAffectingCombat('player');
local _party_size = GetNumGroupMembers();
local _is_PC = UnitPlayerControlled("target");
local _is_Enemy = ConRO:TarHostile();
local _Target_Health = UnitHealth('target');
local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
local _Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
local _ArcaneCharges = ConRO:PlayerPower('ArcaneCharges');

--Conditions
local _is_moving = ConRO:PlayerSpeed();
local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
local _enemies_in_25yrds, _target_in_25yrds = ConRO:Targets("25");
local _enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
local _can_Execute = _Target_Percent_Health < 20;

--Racials
local _AncestralCall, _AncestralCall_RDY = _, _;
local _ArcanePulse, _ArcanePulse_RDY = _, _;
local _Berserking, _Berserking_RDY = _, _;
local _ArcaneTorrent, _ArcaneTorrent_RDY = _, _;

function ConRO:Stats()
	_Player_Level = UnitLevel("player");
	_Player_Percent_Health = ConRO:PercentHealth('player');
	_is_PvP = ConRO:IsPvP();
	_in_combat = UnitAffectingCombat('player');
	_party_size = GetNumGroupMembers();
	_is_PC = UnitPlayerControlled("target");
	_is_Enemy = ConRO:TarHostile();
	_Target_Health = UnitHealth('target');
	_Target_Percent_Health = ConRO:PercentHealth('target');

	_Mana, _Mana_Max, _Mana_Percent = ConRO:PlayerPower('Mana');
	_ArcaneCharges = ConRO:PlayerPower('ArcaneCharges');

	_is_moving = ConRO:PlayerSpeed();
	_enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	_enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	_enemies_in_25yrds, _target_in_25yrds = ConRO:Targets("25");
	_enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
	_can_Execute = _Target_Percent_Health < 20;

	_AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(ids.Racial.AncestralCall, timeShift);
	_ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(ids.Racial.ArcanePulse, timeShift);
	_Berserking, _Berserking_RDY = ConRO:AbilityReady(ids.Racial.Berserking, timeShift);
	_ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(ids.Racial.ArcaneTorrent, timeShift);
end

function ConRO.Mage.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Mage_Ability, ids.Mage_Form, ids.Mage_Buff, ids.Mage_Debuff, ids.Mage_PetAbility, ids.Mage_PvPTalent;

--Abilities

--Conditions

--Warnings

--Rotations	


	return nil;
end

function ConRO.Mage.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Mage_Ability, ids.Mage_Form, ids.Mage_Buff, ids.Mage_Debuff, ids.Mage_PetAbility, ids.Mage_PvPTalent;

--Abilities

--Conditions

--Warnings

--Rotations	

	return nil;
end

function ConRO.Mage.Arcane(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Arc_Ability, ids.Arc_Form, ids.Arc_Buff, ids.Arc_Debuff, ids.Arc_PetAbility, ids.Arc_PvPTalent;

--Abilties	
	local _ArcaneBarrage, _ArcaneBarrage_RDY = ConRO:AbilityReady(Ability.ArcaneBarrage, timeShift);
	local _ArcaneBlast, _ArcaneBlast_RDY = ConRO:AbilityReady(Ability.ArcaneBlast, timeShift);
		local _RuleofThrees_BUFF = ConRO:Aura(Buff.RuleofThrees, timeShift);
	local _ArcaneExplosion, _ArcaneExplosion_RDY = ConRO:AbilityReady(Ability.ArcaneExplosion, timeShift);
	local _ArcaneIntellect, _ArcaneIntellect_RDY = ConRO:AbilityReady(Ability.ArcaneIntellect, timeShift);
	local _ArcaneMissiles, _ArcaneMissiles_RDY = ConRO:AbilityReady(Ability.ArcaneMissiles, timeShift);
		local _, _ArcaneHarmony_COUNT = ConRO:Form(Form.ArcaneHarmony);
		local _Clearcasting_BUFF, _Clearcasting_COUNT = ConRO:Aura(Buff.Clearcasting, timeShift);
		local _ClearcastingAE_BUFF, _ClearcastingAE_COUNT = ConRO:Aura(Buff.ClearcastingAE, timeShift);
		local _Clearcasting_MCOUNT = 3;
		local _NetherPrecision_BUFF, _NetherPrecision_COUNT = ConRO:Aura(Buff.NetherPrecision, timeShift);
	local _ArcaneSurge, _ArcaneSurge_RDY = ConRO:AbilityReady(Ability.ArcaneSurge, timeShift);
	local _Blink, _Blink_RDY = ConRO:AbilityReady(Ability.Blink, timeShift);
	local _ConjureManaGem, _ConjureManaGem_RDY = ConRO:AbilityReady(Ability.ManaGem.Conjure, timeShift);
		local _ManaGem, _ManaGem_RDY, _, _, _ManaGem_COUNT = ConRO:ItemReady(Ability.ManaGem.Use.spellID, timeShift);
	local _Counterspell, _Counterspell_RDY = ConRO:AbilityReady(Ability.Counterspell, timeShift);
	local _Evocation, _Evocation_RDY, _Evocation_CD = ConRO:AbilityReady(Ability.Evocation, timeShift);
		local _Evocation_BUFF = ConRO:Aura(Buff.Evocation, timeShift);
		local _SiphonStorm_BUFF, _, _SiphonStorm_DUR  = ConRO:Aura(Buff.SiphonStorm, timeShift);
	local _PresenceofMind, _PresenceofMind_RDY = ConRO:AbilityReady(Ability.PresenceofMind, timeShift);
		local _PresenceofMind_BUFF = ConRO:Form(Form.PresenceofMind);
	local _RadiantSpark, _RadiantSpark_RDY = ConRO:AbilityReady(Ability.RadiantSpark, timeShift);
		local _RadiantSpark_DEBUFF = ConRO:TargetAura(Debuff.RadiantSpark, timeShift);
		local _RadiantSparkVulnerability_DEBUFF, _RadiantSparkVulnerability_COUNT = ConRO:TargetAura(Debuff.RadiantSparkVulnerability, timeShift);
	local _Spellsteal, _Spellsteal_RDY = ConRO:AbilityReady(Ability.Spellsteal, timeShift);
	local _TimeWarp, _TimeWarp_RDY = ConRO:AbilityReady(Ability.TimeWarp, timeShift);
		local _, _TemporalDisplacement = ConRO:Heroism();
	local _TouchoftheMagi, _TouchoftheMagi_RDY, _TouchoftheMagi_CD = ConRO:AbilityReady(Ability.TouchoftheMagi, timeShift);
		local _TouchoftheMagi_DEBUFF, _, _TouchoftheMagi_DUR = ConRO:TargetAura(Debuff.TouchoftheMagi, timeShift);

	local _ArcaneFamiliar, _ArcaneFamiliar_RDY = ConRO:AbilityReady(Ability.ArcaneFamiliar, timeShift);
		local _ArcaneFamiliar_BUFF = ConRO:Aura(Buff.ArcaneFamiliar, timeShift);
	local _ArcaneOrb, _ArcaneOrb_RDY = ConRO:AbilityReady(Ability.ArcaneOrb, timeShift);
		local _ArcaneOrb_CHARGES = ConRO:SpellCharges(_ArcaneOrb);
	local _NetherTempest, _NetherTempest_RDY = ConRO:AbilityReady(Ability.NetherTempest, timeShift);
		local _NetherTempest_DEBUFF = ConRO:TargetAura(Debuff.NetherTempest, timeShift);
	local _Shimmer, _Shimmer_RDY = ConRO:AbilityReady(Ability.Shimmer, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY = ConRO:AbilityReady(Ability.ShiftingPower, timeShift);

--Conditions
	local _enemies_in_15yrds, _target_in_15yrds = ConRO:Targets("15");

	if currentSpell == _ArcaneBlast then
		_ArcaneCharges = _ArcaneCharges + 1;
	end
	if currentSpell == _TouchoftheMagi then
		_ArcaneCharges = 4;
	end

	local _Mana_Threshold = 60;
		if tChosen[Ability.Enlightened.talentID] then
			_Mana_Threshold = 80;
		end

	if _is_PvP then
		if pvpChosen[PvPTalent.ArcaneEmpowerment] then
			_Clearcasting_BUFF, _Clearcasting_COUNT, _Clearcasting_MCOUNT = _ClearcastingAE_BUFF, _ClearcastingAE_COUNT, 5;
		end
	end

--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[Ability.Shimmer.talentID] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);

	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(Buff.ArcaneIntellect));

	ConRO:AbilityBurst(_ArcaneSurge, _ArcaneSurge_RDY and _RadiantSparkVulnerability_COUNT == 3 and ConRO:BurstMode(_ArcaneSurge));
	ConRO:AbilityBurst(_PresenceofMind, _PresenceofMind_RDY and not _PresenceofMind_BUFF and _ArcanePower_BUFF and _ArcanePower_DUR <= 3 and ConRO:BurstMode(_PresenceofMind));
	ConRO:AbilityBurst(_TimeWarp, _TimeWarp_RDY and tChosen[Ability.TemporalWarp.talentID] and (_TemporalDisplacement or ConRO:IsSolo()) and ConRO:BurstMode(_TimeWarp));
	ConRO:AbilityBurst(_TouchoftheMagi, _TouchoftheMagi_RDY and _ArcaneCharges <= 0 and currentSpell ~= _TouchoftheMagi and ConRO:BurstMode(_TouchoftheMagi));

	ConRO:AbilityBurst(_ShiftingPower, _ShiftingPower_RDY and not _ArcaneSurge_RDY and not _Evocation_RDY and not _TouchoftheMagi_RDY and ConRO:BurstMode(_ShiftingPower));

--Warnings	

--Rotations
	for i = 1, 2, 1 do
		if _Evocation_BUFF and _Mana < _Mana_Max then
			tinsert(ConRO.SuggestedSpells, _Evocation);
		end

		if _ArcaneFamiliar_RDY and not _ArcaneFamiliar_BUFF then
			tinsert(ConRO.SuggestedSpells, _ArcaneFamiliar);
			_ArcaneFamiliar_RDY = false;
		end

		if not _in_combat then
			if _ConjureManaGem_RDY and _ManaGem_COUNT <= 0 then
				tinsert(ConRO.SuggestedSpells, _ConjureManaGem);
				_ConjureManaGem_RDY = false;
			end

			if _MirrorImage_RDY then
				tinsert(ConRO.SuggestedSpells, _MirrorImage);
				_MirrorImage_RDY = false;
			end

			if _Evocation_RDY and tChosen[Ability.SiphonStorm.talentID] then
				tinsert(ConRO.SuggestedSpells, _Evocation);
				_Evocation_RDY = false;
			end

			if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds <= 1) or ConRO_SingleButton:IsVisible()) then
				if _ArcaneBlast_RDY and currentSpell ~= _ArcaneBlast then
					tinsert(ConRO.SuggestedSpells, _ArcaneBlast);
					_ArcaneBlast_RDY = false;
					_ArcaneCharges = _ArcaneCharges + 1;
				end
			else
				if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
					tinsert(ConRO.SuggestedSpells, _RadiantSpark);
					_RadiantSpark_RDY = false;
				end
			end

			if _ArcaneOrb_RDY then
				tinsert(ConRO.SuggestedSpells, _ArcaneOrb);
				_ArcaneOrb_RDY = false;
				_ArcaneCharges = _ArcaneCharges + 1;
			end
		end

		if _ShiftingPower_RDY and not _SiphonStorm_BUFF and not _ArcaneSurge_RDY and ConRO:FullMode(_ShiftingPower) then
			tinsert(ConRO.SuggestedSpells, _ShiftingPower);
		end

		if _PresenceofMind_RDY and _TouchoftheMagi_DEBUFF and _TouchoftheMagi_DUR <= 2 then
			tinsert(ConRO.SuggestedSpells, _PresenceofMind);
			_PresenceofMind_RDY = false;
		end

		if _RadiantSpark_DEBUFF or _RadiantSparkVulnerability_DEBUFF or currentSpell == _RadiantSpark then
			if _NetherTempest_RDY and not _NetherTempest_DEBUFF then
				tinsert(ConRO.SuggestedSpells, _NetherTempest);
				_NetherTempest_RDY = false;
			end

			if _ArcaneSurge_RDY and currentSpell ~= _ArcaneSurge and ConRO:FullMode(_ArcaneSurge) then
				tinsert(ConRO.SuggestedSpells, _ArcaneSurge);
				_ArcaneSurge_RDY = false;
			end

			if _ManaGem_RDY and _ManaGem_COUNT > 0 and _Mana_Percent < 75 then
				tinsert(ConRO.SuggestedSpells, _ManaGem);
				_ManaGem_RDY = false;
			end

			if _TouchoftheMagi_RDY and ConRO.lastSpellId == _ArcaneBarrage then
				tinsert(ConRO.SuggestedSpells, _TouchoftheMagi);
				_TouchoftheMagi_RDY = false;
			end

			if _ArcaneBarrage_RDY and _TouchoftheMagi_RDY then
				tinsert(ConRO.SuggestedSpells, _ArcaneBarrage);
				_ArcaneBarrage_RDY = false;
				_ArcaneCharges = 0;
			end

			if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
				if _ArcaneBarrage_RDY then
					tinsert(ConRO.SuggestedSpells, _ArcaneBarrage);
					_ArcaneCharges = _ArcaneCharges + 1;
				end
			else
				if _ArcaneBlast_RDY then
					tinsert(ConRO.SuggestedSpells, _ArcaneBlast);
					_ArcaneCharges = _ArcaneCharges + 1;
				end
			end
		end

		if _RadiantSpark_RDY and (_TouchoftheMagi_RDY or _TouchoftheMagi_CD <= 2)  then
			if _Evocation_RDY and tChosen[Ability.SiphonStorm.talentID] then
				tinsert(ConRO.SuggestedSpells, _Evocation);
				_Evocation_RDY = false;
				_Evocation_BUFF = true;
			end

			if _TimeWarp_RDY and ((tChosen[Ability.TemporalWarp.talentID] and _TemporalDisplacement) or ConRO:IsSolo()) and ConRO:FullMode(_TimeWarp) then
				tinsert(ConRO.SuggestedSpells, _TimeWarp);
				_TimeWarp_RDY = false;
			end

			if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds <= 1) or ConRO_SingleButton:IsVisible()) then
				if _SiphonStorm_BUFF and _SiphonStorm_DUR >= 17 then
					if _ArcaneMissiles_RDY and _Clearcasting_COUNT >= 1 then
						tinsert(ConRO.SuggestedSpells, _ArcaneMissiles);
						_Clearcasting_COUNT = _Clearcasting_COUNT - 1;
					end

					if _ArcaneBlast_RDY then
						tinsert(ConRO.SuggestedSpells, _ArcaneBlast);
						_ArcaneCharges = _ArcaneCharges + 1;
					end
				end
			end

			if _RadiantSpark_RDY and currentSpell ~= _RadiantSpark then
				tinsert(ConRO.SuggestedSpells, _RadiantSpark);
				_RadiantSpark_RDY = false;
			end
		end

		if _ArcaneOrb_RDY and ConRO.lastSpellId == _ArcaneBarrage and _ArcaneCharges < 2 then
			tinsert(ConRO.SuggestedSpells, _ArcaneOrb);
			_ArcaneOrb_RDY = false;
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _ArcaneBarrage_RDY and _ArcaneCharges >= 4 then
				tinsert(ConRO.SuggestedSpells, _ArcaneBarrage);
				_ArcaneBarrage_RDY = false;
				_ArcaneCharges = 0;
			end
		else
			if _NetherTempest_RDY and not _NetherTempest_DEBUFF and _Mana_Percent < 10 then
				tinsert(ConRO.SuggestedSpells, _NetherTempest);
				_NetherTempest_RDY = false;
			end

			if _ArcaneBarrage_RDY and _Mana_Percent < 10 then
				tinsert(ConRO.SuggestedSpells, _ArcaneBarrage);
				_ArcaneBarrage_RDY = false;
				_ArcaneCharges = 0;
			end
		end

		if _ConjureManaGem_RDY and _Mana_Percent <= 25 and _ManaGem_COUNT <= 0 then
			tinsert(ConRO.SuggestedSpells, _ConjureManaGem);
			_ConjureManaGem_RDY = false;
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_10yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _ArcaneExplosion_RDY and _ArcaneCharges < 4 then
				tinsert(ConRO.SuggestedSpells, _ArcaneExplosion);
				_ArcaneCharges = _ArcaneCharges + 1;
			end
		else
			if _ArcaneBlast_RDY and _NetherPrecision_COUNT >= 1 then
				tinsert(ConRO.SuggestedSpells, _ArcaneBlast);
				_NetherPrecision_COUNT = _NetherPrecision_COUNT - 1;
				_ArcaneCharges = _ArcaneCharges + 1;
			end

			if _ArcaneMissiles_RDY and _Clearcasting_COUNT >= 1 then
				tinsert(ConRO.SuggestedSpells, _ArcaneMissiles);
				_Clearcasting_COUNT = _Clearcasting_COUNT - 1;
			end

			if _ArcaneBlast_RDY then
				tinsert(ConRO.SuggestedSpells, _ArcaneBlast);
				_ArcaneCharges = _ArcaneCharges + 1;
			end
		end
	end
	return nil;
end

function ConRO.Mage.ArcaneDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Arc_Ability, ids.Arc_Form, ids.Arc_Buff, ids.Arc_Debuff, ids.Arc_PetAbility, ids.Arc_PvPTalent;

--Abilties
	local _PrismaticBarrier, _PrismaticBarrier_RDY = ConRO:AbilityReady(Ability.PrismaticBarrier, timeShift);
		local _PrismaticBarrier_BUFF = ConRO:Aura(Buff.PrismaticBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlock, timeShift);
	local _MirrorImage, _MirrorImage_RDY = ConRO:AbilityReady(Ability.MirrorImage, timeShift);

--Conditions
	if tChosen[Ability.IceCold.talentID] then
		_IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlockIC, timeShift);
	end

--Rotations	
	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _IceBlock);
	end

	if _PrismaticBarrier_RDY and not _PrismaticBarrier_BUFF then
		tinsert(ConRO.SuggestedDefSpells, _PrismaticBarrier);
	end

	if _MirrorImage_RDY and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _MirrorImage);
	end
	return nil;
end

function ConRO.Mage.Fire(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Fire_Ability, ids.Fire_Form, ids.Fire_Buff, ids.Fire_Debuff, ids.Fire_PetAbility, ids.Fire_PvPTalent;

--Abilities
	local _ArcaneIntellect, _ArcaneIntellect_RDY = ConRO:AbilityReady(Ability.ArcaneIntellect, timeShift);
	local _Blink, _Blink_RDY = ConRO:AbilityReady(Ability.Blink, timeShift);
	local _Combustion, _Combustion_RDY, _Combustion_CD = ConRO:AbilityReady(Ability.Combustion, timeShift);
		local _Combustion_BUFF, _, _Combustion_DUR = ConRO:Aura(Buff.Combustion, timeShift);
	local _Counterspell,  _Counterspell_RDY = ConRO:AbilityReady(Ability.Counterspell, timeShift);
	local _FireBlast, _FireBlast_RDY = ConRO:AbilityReady(Ability.FireBlast, timeShift);
		local _FireBlast_CHARGES = ConRO:SpellCharges(_FireBlast);
	local _Fireball, _Fireball_RDY = ConRO:AbilityReady(Ability.Fireball, timeShift);
		local _HeatingUp_BUFF = ConRO:Aura(Buff.HeatingUp, timeShift);
		local _HotStreak_BUFF = ConRO:Aura(Buff.HotStreak, timeShift);
	local _Flamestrike, _Flamestrike_RDY = ConRO:AbilityReady(Ability.Flamestrike, timeShift);
	local _Pyroblast, _Pyroblast_RDY, _, _Pyroblast_MaxCD, _Pyroblast_CAST = ConRO:AbilityReady(Ability.Pyroblast, timeShift);
	local _PhoenixFlames, _PhoenixFlames_RDY = ConRO:AbilityReady(Ability.PhoenixFlames, timeShift);
		local _PhoenixFlames_CHARGES, _, _PhoenixFlames_CCD = ConRO:SpellCharges(_PhoenixFlames);
	local _Scorch, _Scorch_RDY = ConRO:AbilityReady(Ability.Scorch, timeShift);
	local _Spellsteal, _Spellsteal_RDY = ConRO:AbilityReady(Ability.Spellsteal, timeShift);
	local _LivingBomb, _LivingBomb_RDY = ConRO:AbilityReady(Ability.LivingBomb, timeShift);
	local _Meteor, _Meteor_RDY = ConRO:AbilityReady(Ability.Meteor, timeShift);
	local _Shimmer, _Shimmer_RDY = ConRO:AbilityReady(Ability.Shimmer, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY = ConRO:AbilityReady(Ability.ShiftingPower, timeShift);

--Conditions

--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[Ability.Shimmer.talentID] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);

	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(Buff.ArcaneIntellect));

	ConRO:AbilityBurst(_Combustion, _Combustion_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch) and ConRO:BurstMode(_Combustion));
	ConRO:AbilityBurst(_Meteor, _Meteor_RDY and ((not _Combustion_RDY or _Combustion_BUFF) and (_Combustion_CD > 40)) and ConRO:BurstMode(_Meteor));

	ConRO:AbilityBurst(_ShiftingPower, _ShiftingPower_RDY and _target_in_10yrds and not _Combustion_RDY and ConRO:BurstMode(_ShiftingPower));

--Warnings	

--Rotations	
	if not _in_combat then
		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _Flamestrike_RDY and currentSpell ~= _Flamestrike  then
				tinsert(ConRO.SuggestedSpells, _Flamestrike);
			end

			if _FireBlast_RDY and not _HotStreak_BUFF and currentSpell == _Flamestrike then
				tinsert(ConRO.SuggestedSpells, _FireBlast);
			end
		else
			if _Pyroblast_RDY and currentSpell ~= _Pyroblast then
				tinsert(ConRO.SuggestedSpells, _Pyroblast);
			end

			if _Fireball_RDY and currentSpell ~= _Fireball then
				tinsert(ConRO.SuggestedSpells, _Fireball);
			end
		end
	elseif tChosen[Ability.Firestarter.talentID] and _Target_Percent_Health >= 90 then
		if _FireBlast_RDY and not _HeatingUp_BUFF and not _HotStreak_BUFF then
			tinsert(ConRO.SuggestedSpells, _FireBlast);
		end

		if _Pyroblast_RDY and ((_HeatingUp_BUFF and currentSpell ~= _Pyroblast) or (_HotStreak_BUFF and currentSpell == _Fireball)) then
			tinsert(ConRO.SuggestedSpells, _Pyroblast);
		end

		if _Fireball_RDY and _HotStreak_BUFF and currentSpell ~= _Fireball then
			tinsert(ConRO.SuggestedSpells, _Fireball);
		end

		if _Fireball_RDY and currentSpell ~= _Fireball then
			tinsert(ConRO.SuggestedSpells, _Fireball);
		end
	elseif _Firestorm_BUFF then
		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _Flamestrike_RDY then
				tinsert(ConRO.SuggestedSpells, _Flamestrike);
			end
		else
			if _Pyroblast_RDY then
				tinsert(ConRO.SuggestedSpells, _Pyroblast);
			end
		end
	elseif _Combustion_BUFF then
		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _Flamestrike_RDY and _HotStreak_BUFF or (_HeatingUp_BUFF  and (currentSpell == _Scorch or currentSpell == _Flamestrike)) then
				tinsert(ConRO.SuggestedSpells, _Flamestrike);
			end
		else
			if _Pyroblast_RDY and _HotStreak_BUFF or (_HeatingUp_BUFF and (currentSpell == _Scorch or currentSpell == _Pyroblast)) then
				tinsert(ConRO.SuggestedSpells, _Pyroblast);
			end
		end

		if _Meteor_RDY and ConRO:FullMode(_Meteor) then
			tinsert(ConRO.SuggestedSpells, _Meteor);
		end

		if _PhoenixFlames_RDY and (not _FireBlast_RDY or _PhoenixFlames_CHARGES >= 3) and (_HeatingUp_BUFF or ConRO.lastSpellId == _Pyroblast or ConRO.lastSpellId == _Flamestrike) then
			tinsert(ConRO.SuggestedSpells, _PhoenixFlames);
		end

		if _FireBlast_RDY and (_HeatingUp_BUFF or ConRO.lastSpellId == _Pyroblast or ConRO.lastSpellId == _Flamestrike) then
			tinsert(ConRO.SuggestedSpells, _FireBlast);
		end

		if _Scorch_RDY then
			tinsert(ConRO.SuggestedSpells, _Scorch);
		end
	else
		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _FireBlast_RDY and not _HotStreak_BUFF and (_Combustion_RDY or ((_FireBlast_CHARGES >= 1 and _Combustion_CD >= 20) or (_FireBlast_CHARGES >= 2 and _Combustion_CD >= 10) or _FireBlast_CHARGES >= 3)) and (currentSpell == _Scorch or currentSpell == _Flamestrike) then
				tinsert(ConRO.SuggestedSpells, _FireBlast);
			end
		else
			if _FireBlast_RDY and ((_Combustion_RDY and not _HotStreak_BUFF) or (_HeatingUp_BUFF and ((_FireBlast_CHARGES >= 1 and _Combustion_CD >= 20) or (_FireBlast_CHARGES >= 2 and _Combustion_CD >= 10) or _FireBlast_CHARGES >= 3))) and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Pyroblast or currentSpell == _Flamestrike) then
				tinsert(ConRO.SuggestedSpells, _FireBlast);
			end
		end

		if _Combustion_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Pyroblast or currentSpell == _Flamestrike) and ConRO_FullButton:IsVisible() then
			tinsert(ConRO.SuggestedSpells, _Combustion);
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _Flamestrike_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Flamestrike) then
				tinsert(ConRO.SuggestedSpells, _Flamestrike);
			end
		else
			if _Pyroblast_RDY and _HotStreak_BUFF and (currentSpell == _Fireball or currentSpell == _Scorch or currentSpell == _Pyroblast) then
				tinsert(ConRO.SuggestedSpells, _Pyroblast);
			end
		end

		if _ShiftingPower_RDY and _target_in_10yrds and not _Combustion_RDY and ConRO:FullMode(_ShiftingPower) then
			tinsert(ConRO.SuggestedSpells, _ShiftingPower);
		end

		if _Meteor_RDY and _Combustion_CD > 40 and not _Combustion_RDY and ConRO:FullMode(_Meteor) then
			tinsert(ConRO.SuggestedSpells, _Meteor);
		end

		if _HotStreak_BUFF and currentSpell ~= _Fireball and currentSpell ~= _Scorch and ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds <= 1) or ConRO_SingleButton:IsVisible()) then
			if _Scorch_RDY and (_is_moving or (tChosen[Ability.SearingTouch.talentID] and _Target_Percent_Health <= 30)) then
				tinsert(ConRO.SuggestedSpells, _Scorch);
			elseif _Fireball_RDY then
				tinsert(ConRO.SuggestedSpells, _Fireball);
			end
		end

		if _PhoenixFlames_RDY and not _HeatingUp_BUFF and ((_PhoenixFlames_CHARGES >= 1 and _Combustion_CD >= 50) or (_PhoenixFlames_CHARGES >= 2 and _Combustion_CD >= 25) or _PhoenixFlames_CHARGES >= 3) then
			tinsert(ConRO.SuggestedSpells, _PhoenixFlames);
		end

		if _DragonsBreath_RDY and _target_in_10yrds and ((_HeatingUp_BUFF and tChosen[Ability.AlexstraszasFury.talentID]) or (ConRO_AutoButton:IsVisible() and _enemies_in_10yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _DragonsBreath);
		end

		if _LivingBomb_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _LivingBomb);
		end

		if (_is_moving or (tChosen[Ability.SearingTouch.talentID] and _Target_Percent_Health <= 30)) then
			if _Scorch_RDY then
				tinsert(ConRO.SuggestedSpells, _Scorch);
			end
		elseif ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _Flamestrike_RDY then
				tinsert(ConRO.SuggestedSpells, _Flamestrike);
			end
		else
			if _Fireball_RDY then
				tinsert(ConRO.SuggestedSpells, _Fireball);
			end
		end
	end
	return nil;
end

function ConRO.Mage.FireDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Fire_Ability, ids.Fire_Form, ids.Fire_Buff, ids.Fire_Debuff, ids.Fire_PetAbility, ids.Fire_PvPTalent;

--Abilities	
	local _BlazingBarrier, _BlazingBarrier_RDY = ConRO:AbilityReady(Ability.BlazingBarrier, timeShift);
		local _BlazingBarrier_BUFF = ConRO:Aura(Buff.BlazingBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlock, timeShift);
	local _MirrorImage, _MirrorImage_RDY = ConRO:AbilityReady(Ability.MirrorImage, timeShift);

--Conditions
	if tChosen[Ability.IceCold.talentID] then
		_IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlockIC, timeShift);
	end

--Rotations	
	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _IceBlock);
	end

	if _BlazingBarrier_RDY and not _BlazingBarrier_BUFF then
		tinsert(ConRO.SuggestedDefSpells, _BlazingBarrier);
	end

	if _MirrorImage_RDY and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _MirrorImage);
	end
	return nil;
end

function ConRO.Mage.Frost(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Frost_Ability, ids.Frost_Form, ids.Frost_Buff, ids.Frost_Debuff, ids.Frost_PetAbility, ids.Frost_PvPTalent;

--Abilities
	local _ArcaneExplosion, _ArcaneExplosion_RDY = ConRO:AbilityReady(Ability.ArcaneExplosion, timeShift);
	local _ArcaneIntellect, _ArcaneIntellect_RDY = ConRO:AbilityReady(Ability.ArcaneIntellect, timeShift);
	local _Blink, _Blink_RDY = ConRO:AbilityReady(Ability.Blink, timeShift);
	local _Blizzard, _Blizzard_RDY = ConRO:AbilityReady(Ability.Blizzard, timeShift);
		local _FreezingRain_BUFF = ConRO:Aura(Buff.FreezingRain, timeShift);
	local _CometStorm, _CometStorm_RDY, _CometStorm_CD = ConRO:AbilityReady(Ability.CometStorm, timeShift);
	local _ConeofCold, _ConeofCold_RDY = ConRO:AbilityReady(Ability.ConeofCold, timeShift);
		local _, _Snowstorm_COUNT = ConRO:Aura(Buff.Snowstorm, timeShift);
	local _Counterspell, _Counterspell_RDY = ConRO:AbilityReady(Ability.Counterspell, timeShift);
	local _Flurry, _Flurry_RDY, _Flurry_CD = ConRO:AbilityReady(Ability.Flurry, timeShift);
		local _BrainFreeze_BUFF = ConRO:Aura(Buff.BrainFreeze, timeShift);
		local _WintersChill_DEBUFF, _WintersChill_COUNT = ConRO:TargetAura(Debuff.WintersChill, timeShift);
	local _Frostbolt, _Frostbolt_RDY = ConRO:AbilityReady(Ability.Frostbolt, timeShift);
	local _FrozenOrb, _FrozenOrb_RDY = ConRO:AbilityReady(Ability.FrozenOrb, timeShift);
		local _FreezingWinds_FORM = ConRO:Form(Form.FreezingWinds);
		local _ConcentratedCoolness_FrozenOrb, _, _ConcentratedCoolness_FrozenOrb_CD = ConRO:AbilityReady(PvPTalent.ConcentratedCoolness_FrozenOrb, timeShift);
	local _GlacialSpike, _GlacialSpike_RDY = ConRO:AbilityReady(Ability.GlacialSpike, timeShift);
		local _GlacialSpike_BUFF = ConRO:Aura(Buff.GlacialSpike, timeShift);
	local _IceFloes, _IceFloes_RDY = ConRO:AbilityReady(Ability.IceFloes, timeShift);
	local _IceForm, _, _IceForm_CD = ConRO:AbilityReady(PvPTalent.IceForm, timeShift);
	local _IceLance, _IceLance_RDY = ConRO:AbilityReady(Ability.IceLance, timeShift);
		local _, _Icicles_COUNT = ConRO:Aura(Buff.Icicles, timeShift);
		local _FingersofFrost_BUFF, _FingersofFrost_COUNT = ConRO:Aura(Buff.FingersofFrost, timeShift);
	local _IceNova, _IceNova_RDY = ConRO:AbilityReady(Ability.IceNova, timeShift);
	local _IcyVeins, _IcyVeins_RDY, _IcyVeins_CD = ConRO:AbilityReady(Ability.IcyVeins, timeShift);
		local _IcyVeins_BUFF = ConRO:Aura(Buff.IcyVeins, timeShift);
	local _RayofFrost, _RayofFrost_RDY = ConRO:AbilityReady(Ability.RayofFrost, timeShift);
	local _ShiftingPower, _ShiftingPower_RDY = ConRO:AbilityReady(Ability.ShiftingPower, timeShift);
	local _Shimmer, _Shimmer_RDY = ConRO:AbilityReady(Ability.Shimmer, timeShift);
	local _Spellsteal, _Spellsteal_RDY = ConRO:AbilityReady(Ability.Spellsteal, timeShift);
	local _TimeWarp, _TimeWarp_RDY = ConRO:AbilityReady(Ability.TimeWarp, timeShift);
		local _TemporalDisplacement_DEBUFF = ConRO:Aura(Debuff.TemporalDisplacement, timeShift, "HARMFUL");
		local _TimeWarp_BUFF, _TemporalDisplacement = ConRO:Heroism();

--Conditions
	local _enemies_in_15yrds, _target_in_15yrds = ConRO:Targets("15");

	local _Pet_summoned = ConRO:CallPet();
	local _Pet_assist = ConRO:PetAssist();

	if currentSpell == _Frostbolt then
		_Icicles_COUNT = _Icicles_COUNT + 1;
	elseif currentSpell == _GlacialSpike then
		_Icicles_COUNT = 0;
	end

	if currentSpell == _GlacialSpike or currentSpell == _RayofFrost or currentSpell == _Frostbolt then
		_WintersChill_COUNT = _WintersChill_COUNT - 1;
	end

	if _is_PvP then
		if pvpChosen[PvPTalent.IceForm.spellID] then
			_IcyVeins_RDY = _IcyVeins_RDY and _IceForm_CD <= 0
			_IcyVeins = _IceForm;
		end
		if pvpChosen[PvPTalent.ConcentratedCoolness.spellID] then
			_FrozenOrb_RDY = _FrozenOrb_RDY and _ConcentratedCoolness_FrozenOrb_CD <= 0;
			_FrozenOrb = _ConcentratedCoolness_FrozenOrb;
		end
	end

--Indicators	
	ConRO:AbilityInterrupt(_Counterspell, _Counterspell_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_Spellsteal, _Spellsteal_RDY and ConRO:Purgable());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_10yrds and ConRO:Purgable());
	ConRO:AbilityMovement(_Blink, _Blink_RDY and not tChosen[Ability.Shimmer.talentID] and _target_in_melee);
	ConRO:AbilityMovement(_Shimmer, _Shimmer_RDY and _target_in_melee);

	ConRO:AbilityRaidBuffs(_ArcaneIntellect, _ArcaneIntellect_RDY and not ConRO:RaidBuff(Buff.ArcaneIntellect));

	ConRO:AbilityBurst(_FrozenOrb, _FrozenOrb_RDY and ConRO:BurstMode(_FrozenOrb));
	ConRO:AbilityBurst(_IcyVeins, _in_combat and _IcyVeins_RDY and ConRO:BurstMode(_IcyVeins));
	ConRO:AbilityBurst(_FrozenOrb, _in_combat and _FrozenOrb_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) and not _RayofFrost_RDY and ConRO:BurstMode(_FrozenOrb));
	ConRO:AbilityBurst(_RayofFrost, _in_combat and _RayofFrost_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds <= 1) or ConRO_SingleButton:IsVisible()) and _WintersChill_COUNT == 1 and ConRO:BurstMode(_RayofFrost));
	ConRO:AbilityBurst(_ShiftingPower, _in_combat and _ShiftingPower_RDY and _enemies_in_15yrds >= 3 and currentSpell ~= _ShiftingPower and ConRO:BurstMode(_ShiftingPower));
	ConRO:AbilityBurst(_TimeWarp, _TimeWarp_RDY and _IcyVeins_BUFF and not _TimeWarp_BUFF and tChosen[Ability.TemporalWarp.talentID] and (_TemporalDisplacement or ConRO:IsSolo()) and ConRO:BurstMode(_TimeWarp));

--Warnings	

--Rotations	
	for i = 1, 2, 1 do
		if not _in_combat then
			if _Frostbolt_RDY and currentSpell ~= _Frostbolt then
				tinsert(ConRO.SuggestedSpells, _Frostbolt);
				_Frostbolt_RDY = false;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end

			if _Flurry_RDY and _WintersChill_COUNT <= 0 then
				tinsert(ConRO.SuggestedSpells, _Flurry);
				_Flurry_RDY = false;
				_WintersChill_COUNT = 2;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end
		end

		if _Flurry_RDY and _WintersChill_COUNT <= 0 and (currentSpell == _Frostbolt or currentSpell == _GlacialSpike) then
			tinsert(ConRO.SuggestedSpells, _Flurry);
			_Flurry_RDY = false;
			_WintersChill_COUNT = 2;
			_Icicles_COUNT = _Icicles_COUNT + 1;
		end

		if _IcyVeins_RDY and ConRO:FullMode(_IcyVeins) then
			tinsert(ConRO.SuggestedSpells, _IcyVeins);
			_IcyVeins_RDY = false;
		end

		if ConRO:IsSolo() then
			if _TimeWarp_RDY and _IcyVeins_BUFF and not _TimeWarp_BUFF and ((tChosen[Ability.TemporalWarp.talentID] and _TemporalDisplacement_DEBUFF) or not _TemporalDisplacement_DEBUFF) and ConRO:FullMode(_TimeWarp) then
				tinsert(ConRO.SuggestedSpells, _TimeWarp);
				_TimeWarp_RDY = false;
			end
		else
			if _TimeWarp_RDY and _IcyVeins_BUFF and not _TimeWarp_BUFF and (tChosen[Ability.TemporalWarp.talentID] and _TemporalDisplacement) and ConRO:FullMode(_TimeWarp) then
				tinsert(ConRO.SuggestedSpells, _TimeWarp);
				_TimeWarp_RDY = false;
			end
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 3) or ConRO_AoEButton:IsVisible()) then
			if _ConeofCold_RDY and tChosen[Ability.ColdestSnap.talentID] and _enemies_in_10yrds >= 3 and _CometStorm_CD >= 26 then
				tinsert(ConRO.SuggestedSpells, _ConeofCold);
				_ConeofCold_RDY = false;
				_CometStorm_RDY = true;
				_FrozenOrb_RDY = true;
				_WintersChill_COUNT = 2;
			end

			if _FrozenOrb_RDY and ConRO:FullMode(_FrozenOrb) then
				tinsert(ConRO.SuggestedSpells, _FrozenOrb);
				_FrozenOrb_RDY = false;
			end

			if _Blizzard_RDY and currentSpell ~= _Blizzard then
				tinsert(ConRO.SuggestedSpells, _Blizzard);
				_Blizzard_RDY = false;
			end

			if _CometStorm_RDY then
				tinsert(ConRO.SuggestedSpells, _CometStorm);
				_CometStorm_RDY = false;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _ConeofCold_RDY and tChosen[Ability.Snowstorm.talentID] and _enemies_in_10yrds >= 3 and _Snowstorm_COUNT >= 15 then
				tinsert(ConRO.SuggestedSpells, _ConeofCold);
				_ConeofCold_RDY = false;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _IceNova_RDY and currentSpell == _GlacialSpike then
				tinsert(ConRO.SuggestedSpells, _IceNova);
				_IceNova_RDY = false;
			end

			if _ShiftingPower_RDY and _enemies_in_15yrds >= 3 and currentSpell ~= _ShiftingPower and ConRO:FullMode(_ShiftingPower) then
				tinsert(ConRO.SuggestedSpells, _ShiftingPower);
				_ShiftingPower_RDY = false;
			end

			if (_GlacialSpike_RDY or (_Icicles_COUNT >= 5 and tChosen[Ability.GlacialSpike.talentID])) and currentSpell ~= _GlacialSpike and (_WintersChill_COUNT >= 1 or _IceNova_RDY) then
				tinsert(ConRO.SuggestedSpells, _GlacialSpike);
				_GlacialSpike_RDY = false;
				_Icicles_COUNT = 0;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _Flurry_RDY and _WintersChill_COUNT <= 0 then
				tinsert(ConRO.SuggestedSpells, _Flurry);
				_Flurry_RDY = false;
				_WintersChill_COUNT = 2;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end

			if _IceLance_RDY and (ConRO.lastSpellId == ids.Frost_Ability.Flurry or _WintersChill_COUNT >= 1 or _FingersofFrost_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _IceLance);
				_FingersofFrost_COUNT = _FingersofFrost_COUNT - 1;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end

			if _IceNova_RDY then
				tinsert(ConRO.SuggestedSpells, _IceNova);
				_IceNova_RDY = false;
			end

			if _ArcaneExplosion_RDY and _Mana_Percent >= 30 and _enemies_in_10yrds >= 7 then
				tinsert(ConRO.SuggestedSpells, _ArcaneExplosion);
			end

			if _Frostbolt_RDY then
				tinsert(ConRO.SuggestedSpells, _Frostbolt);
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end
		else
			if _Flurry_RDY and _WintersChill_COUNT <= 0 and (currentSpell == _Frostbolt or currentSpell == _GlacialSpike) then
				tinsert(ConRO.SuggestedSpells, _Flurry);
				_Flurry_RDY = false;
				_WintersChill_COUNT = 2;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end

			if tChosen[Ability.GlacialSpike.talentID] then
				if _Flurry_RDY and _WintersChill_COUNT <= 0 and not _FingersofFrost_BUFF and _Icicles_COUNT == 4 then
					tinsert(ConRO.SuggestedSpells, _Flurry);
					_Flurry_RDY = false;
					_WintersChill_COUNT = 2;
					_Icicles_COUNT = _Icicles_COUNT + 1;
				end
			end

			if _CometStorm_RDY and (ConRO.lastSpellId == _Flurry or _WintersChill_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _CometStorm);
				_CometStorm_RDY = false;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _RayofFrost_RDY and (_WintersChill_COUNT == 1 or (ConRO.lastSpellId == _IceLance and _WintersChill_COUNT == 2))and ConRO:FullMode(_RayofFrost) then
				tinsert(ConRO.SuggestedSpells, _RayofFrost);
				_RayofFrost_RDY = false;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if (_GlacialSpike_RDY or (_Icicles_COUNT >= 5 and tChosen[Ability.GlacialSpike.talentID])) and currentSpell ~= _GlacialSpike and (ConRO.lastSpellId == _Flurry or _Flurry_RDY or (_Flurry_CD <= 1.5) or _WintersChill_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _GlacialSpike);
				_GlacialSpike_RDY = false;
				_Icicles_COUNT = 0;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _FrozenOrb_RDY and not _RayofFrost_RDY and ConRO:FullMode(_FrozenOrb) then
				tinsert(ConRO.SuggestedSpells, _FrozenOrb);
				_FrozenOrb_RDY = false;
			end

			if _Blizzard_RDY and (ConRO_AutoButton:IsVisible() and _enemies_in_40yrds >= 2) and (_FreezingRain_BUFF or (tChosen[Ability.IceCaller.talentID] and not _FrozenOrb_RDY)) and currentSpell ~= _Blizzard then
				tinsert(ConRO.SuggestedSpells, _Blizzard);
				_Blizzard_RDY = false;
			end

			if _ShiftingPower_RDY and currentSpell ~= _ShiftingPower and not _WintersChill_DEBUFF and not _IcyVeins_RDY and not _RayofFrost_RDY and not _FrozenOrb_RDY and not _CometStorm_RDY and ConRO:FullMode(_ShiftingPower) then
				tinsert(ConRO.SuggestedSpells, _ShiftingPower);
				_ShiftingPower_RDY = false;
			end

			if _IceLance_RDY and (_FingersofFrost_COUNT >= 1 or ConRO.lastSpellId == _Flurry or _WintersChill_COUNT >= 1) then
				tinsert(ConRO.SuggestedSpells, _IceLance);
				_FingersofFrost_COUNT = _FingersofFrost_COUNT - 1;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end

			if (_GlacialSpike_RDY or (_Icicles_COUNT >= 5 and tChosen[Ability.GlacialSpike.talentID])) and currentSpell ~= _GlacialSpike and _IcyVeins_BUFF then
				tinsert(ConRO.SuggestedSpells, _GlacialSpike);
				_GlacialSpike_RDY = false;
				_Icicles_COUNT = 0;
				_WintersChill_COUNT = _WintersChill_COUNT - 1;
			end

			if _Frostbolt_RDY then
				tinsert(ConRO.SuggestedSpells, _Frostbolt);
				_Icicles_COUNT = _Icicles_COUNT + 1;
			end
		end
	end
	return nil;
end

function ConRO.Mage.FrostDef(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Frost_Ability, ids.Frost_Form, ids.Frost_Buff, ids.Frost_Debuff, ids.Frost_PetAbility, ids.Frost_PvPTalent;

--Abilities	
	local _IceBarrier, _IceBarrier_RDY = ConRO:AbilityReady(Ability.IceBarrier, timeShift);
		local _IceBarrier_BUFF = ConRO:Aura(Buff.IceBarrier, timeShift);
	local _IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlock, timeShift);
	local _ColdSnap, _ColdSnap_RDY = ConRO:AbilityReady(Ability.ColdSnap, timeShift);
	local _MirrorImage, _MirrorImage_RDY = ConRO:AbilityReady(Ability.MirrorImage, timeShift);

--Conditions
	if tChosen[Ability.IceCold.talentID] then
		_IceBlock, _IceBlock_RDY = ConRO:AbilityReady(Ability.IceBlockIC, timeShift);
	end

--Rotations	
	if _ColdSnap_RDY and not _IceBlock_RDY then
		tinsert(ConRO.SuggestedDefSpells, _ColdSnap);
	end

	if _IceBlock_RDY and _Player_Percent_Health <= 25 and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _IceBlock);
	end

	if _IceBarrier_RDY and not _IceBarrier_BUFF then
		tinsert(ConRO.SuggestedDefSpells, _IceBarrier);
	end

	if _MirrorImage_RDY and _in_combat then
		tinsert(ConRO.SuggestedDefSpells, _MirrorImage);
	end
	return nil;
end
