local ConRO_Mage, ids = ...;

--General
	ids.Racial = {
		AncestralCall = {spellID = 274738},
		ArcanePulse = {spellID = 260364},
		ArcaneTorrent = {spellID = 50613},
		Berserking = {spellID = 26297},
		Cannibalize = {spellID = 20577},
		GiftoftheNaaru = {spellID = 59548},
		Shadowmeld = {spellID = 58984},
	}

--Arcane
	ids.Arc_Ability = {
	--Mage Baseline
		ArcaneExplosion = {spellID = 1449},
		ArcaneIntellect = {spellID = 1459},
		Blink = {spellID = 1953},
		ConeofCold = {spellID = 120},
		ConjureRefreshment = {spellID = 190336},
		Counterspell = {spellID = 2139},
		FireBlast = {spellID = 319836},
		FrostNova = {spellID = 122},
		Frostbolt = {spellID = 116},
		Invisibility = {spellID = 66},
		Polymorph = {spellID = 118},
		Portal = {
		},
		SlowFall = {spellID = 130},
		Teleport = {
		},
		TimeWarp = {spellID = 80353},
	--Arcane Baseline
		ArcaneBarrage = {spellID = 44425},
		ArcaneBlast = {spellID = 30451},
		Clearcasting = {spellID = 79684},
		MasterySavant = {spellID = 190740},
	--Mage
		AccumulativeShielding = {spellID = 382800, talentID = 80149},
		AlterTime = {spellID = 342245, talentID = 80174},
		ArcaneWarding = {spellID = 383092, talentID = 80173},
		BlastWave = {spellID = 157981, talentID = 80160},
		CryoFreeze = {spellID = 382292, talentID = 80165},
		DragonsBreath = {spellID = 31661, talentID = 80147},
		Displacement = {spellID = 389713, talentID = 80152},
		DivertedEnergy = {spellID = 382270, talentID = 80158},
		EnergizedBarriers = {spellID = 386828, talentID = 80157},
		FlowofTime = {spellID = 382268, talentID = 80153},
		FreezingCold = {spellID = 386763, talentID = 80143},
		FrigidWinds = {spellID = 235224, talentID = 80188},
		GreaterInvisibility = {spellID = 110959, talentID = 115877},
		IceBlock = {spellID = 45438, talentID = 80181},
		IceCold = {spellID = 414659, talentID = 80141},
			IceBlockIC = {spellID = 414658, talentID = 80141},
		IceFloes = {spellID = 108839, talentID = 80162},
		IceNova = {spellID = 157997, talentID = 80186},
		IceWard = {spellID = 205036, talentID = 80142},
		ImprovedFrostNova = {spellID = 343183, talentID = 80166},
		IncantationofSwiftness = {spellID = 382293, talentID = 80170},
		IncantersFlow = {spellID = 1463, talentID = 80177},
		MassPolymorph = {spellID = 383121, talentID = 80164},
		MassBarrier = {spellID = 414660, talentID = 80148},
		MassInvisibility = {spellID = 414664, talentID = 115878},
		MassSlow = {spellID = 391102, talentID = 80167},
		MasterofTime = {spellID = 342249, talentID = 80159},
		MirrorImage = {spellID = 55342, talentID = 80183},
		OverflowingEnergy = {spellID = 390218, talentID = 80179},
		PrismaticBarrier = {spellID = 235450, talentID = 80180},
		QuickWitted = {spellID = 382297, talentID = 80161},
		Reabsorption = {spellID = 382820, talentID = 80184},
		Reduplication = {spellID = 382569, talentID = 80185},
		RemoveCurse = {spellID = 475, talentID = 80175},
		RigidIce = {spellID = 382481, talentID = 80168},
		RingofFrost = {spellID = 113724, talentID = 80144},
		ShiftingPower = {spellID = 382440, talentID = 80171},
		Shimmer = {spellID = 212653, talentID = 80163},
		Slow = {spellID = 31589, talentID = 80154},
		Spellsteal = {spellID = 30449, talentID = 80140},
		TempestBarrier = {spellID = 382289, talentID = 80169},
		TemporalVelocity = {spellID = 382826, talentID = 80156},
		TemporalWarp = {spellID = 386539, talentID = 80150},
		TimeAnomaly = {spellID = 383243, talentID = 80151},
		TimeManipulation = {spellID = 387807, talentID = 80189},
		TomeofAntonidas = {spellID = 382490, talentID = 80155},
		TomeofRhonin = {spellID = 382493, talentID = 80187},
		VolatileDetonation = {spellID = 389627, talentID = 80145},
		WintersProtection = {spellID = 382424, talentID = 80182},
	--Arcane
		Amplification = {spellID = 236628, talentID = 80294},
		ArcaneBombardment = {spellID = 384581, talentID = 80303},
		ArcaneEcho = {spellID = 342231, talentID = 80191},
		ArcaneFamiliar = {spellID = 205022, talentID = 80207},
		ArcaneHarmony = {spellID = 384452, talentID = 80195},
		ArcaneMissiles = {spellID = 5143, talentID = 80307},
		ArcaneOrb = {spellID = 153626, talentID = 80308},
		ArcaneSurge = {spellID = 365350, talentID = 80299},
		ArcaneTempo = {spellID = 383980, talentID = 80205},
		ArcingCleave = {spellID = 231564, talentID = 80201},
		CascadingPower = {spellID = 384276, talentID = 80193},
		ChargedOrb = {spellID = 384651, talentID = 80310},
		ChronoShift = {spellID = 235711, talentID = 80202},
		ConcentratedPower = {spellID = 414379, talentID = 80298},
		Concentration = {spellID = 384374, talentID = 80194},
		CracklingEnergy = {spellID = 321752, talentID = 80297},
		Enlightened = {spellID = 321387, talentID = 80204},
		Evocation = {spellID = 12051, talentID = 80209},
		Foresight = {spellID = 384861, talentID = 80203},
		IlluminatedThoughts = {spellID = 384060, talentID = 80292},
		HarmonicEcho = {spellID = 384683, talentID = 80305},
		Impetus = {spellID = 383676, talentID = 80291},
		ImprovedArcaneMissiles = {spellID = 383661, talentID = 80309},
		ImprovedClearcasting = {spellID = 321420, talentID = 80293},
		ImprovedPrismaticBarrier = {spellID = 321745, talentID = 80301},
		ManaAdept = {spellID = 321526, talentID = 80300},
		ManaGem = {
			Conjure = {spellID = 759, talentID = 80192},
			Use = {spellID = 36799, talentID = 80192},
		},
		NetherPrecision = {spellID = 383782, talentID = 80295},
		NetherTempest = {spellID = 114923, talentID = 80198},
		OrbBarrage = {spellID = 384858, talentID = 80196},
		PresenceofMind = {spellID = 205025, talentID = 80208},
		ProdigiousSavant = {spellID = 384612, talentID = 80197},
		RadiantSpark = {spellID = 376103, talentID = 80304},
		Resonance = {spellID = 205028, talentID = 80200},
		Reverberate = {spellID = 281482, talentID = 115762},
		RuleofThrees = {spellID = 264354, talentID = 80206},
		SiphonStorm = {spellID = 384187, talentID = 80210},
		Slipstream = {spellID = 236457, talentID = 80296},
		Supernova = {spellID = 157980, talentID = 80290},
		TouchoftheMagi = {spellID = 321507, talentID = 80302},
	}
	ids.Arc_PvPTalent = {
		ArcaneEmpowerment = 276741,
		TormenttheWeak = 198151,
		MasterofEscape = 210476,
		RewindTime = 213220,
		MassInvisibility = 198158,
		NetherwindArmor = 198062,
		TemporalShield = 198111,
		DampenedMagic = 236788,
		Kleptomania = 198100,
		PrismaticCloak = 198064,
	}
	ids.Arc_Form = {
		ArcaneHarmony = 384455,
		PresenceofMind = 205025,
		IncantersFlow = 116267,
	}
	ids.Arc_Buff = {
		ArcaneFamiliar = 210126,
		ArcaneIntellect = 1459,
		ArcanePower = 12042,
		Clearcasting = 263725,
		ClearcastingAE = 276743,
		Evocation = 12051,
		NetherPrecision = 383783,
		PrismaticBarrier = 235450,
		RuleofThrees = 264774,
		SiphonStorm = 384267,
	}
	ids.Arc_Debuff = {
		NetherTempest = 114923,
		RadiantSpark = 376103,
		RadiantSparkVulnerability = 376104,
		TouchoftheMagi = 210824,
	}
	ids.Arc_PetAbility = {

	}

--Fire
	ids.Fire_Ability = {
	--Mage Baseline
		ArcaneExplosion = {spellID = 1449},
		ArcaneIntellect = {spellID = 1459},
		Blink = {spellID = 1953},
		ConeofCold = {spellID = 120},
		ConjureRefreshment = {spellID = 190336},
		Counterspell = {spellID = 2139},
		FrostNova = {spellID = 122},
		Frostbolt = {spellID = 116},
		Invisibility = {spellID = 66},
		Polymorph = {spellID = 118},
		Portal = {
		},
		SlowFall = {spellID = 130},
		Teleport = {
		},
		TimeWarp = {spellID = 80353},
	--Fire Baseline
		Cauterize = {spellID = 86949},
		Fireball = {spellID = 133},
		Flamestrike = {spellID = 2120},
		HotStreak = {spellID = 195283},
		MasteryIgnite = {spellID = 12846},
	--Mage
		AccumulativeShielding = {spellID = 382800, talentID = 80149},
		AlterTime = {spellID = 342245, talentID = 80174},
		ArcaneWarding = {spellID = 383092, talentID = 80173},
		BlastWave = {spellID = 157981, talentID = 80160},
		BlazingBarrier = {spellID = 235313, talentID = 80178},
		CryoFreeze = {spellID = 382292, talentID = 80165},
		DragonsBreath = {spellID = 31661, talentID = 80147},
		Displacement = {spellID = 389713, talentID = 80152},
		DivertedEnergy = {spellID = 382270, talentID = 80158},
		EnergizedBarriers = {spellID = 386828, talentID = 80157},
		FlowofTime = {spellID = 382268, talentID = 80153},
		FreezingCold = {spellID = 386763, talentID = 80143},
		FrigidWinds = {spellID = 235224, talentID = 80188},
		GreaterInvisibility = {spellID = 110959, talentID = 115877},
		IceBlock = {spellID = 45438, talentID = 80181},
		IceCold = {spellID = 414659, talentID = 80141},
			IceBlockIC = {spellID = 414658, talentID = 80141},
		IceFloes = {spellID = 108839, talentID = 80162},
		IceNova = {spellID = 157997, talentID = 80186},
		IceWard = {spellID = 205036, talentID = 80142},
		ImprovedFrostNova = {spellID = 343183, talentID = 80166},
		IncantationofSwiftness = {spellID = 382293, talentID = 80170},
		IncantersFlow = {spellID = 1463, talentID = 80177},
		MassPolymorph = {spellID = 383121, talentID = 80164},
		MassBarrier = {spellID = 414660, talentID = 80148},
		MassInvisibility = {spellID = 414664, talentID = 115878},
		MassSlow = {spellID = 391102, talentID = 80167},
		MasterofTime = {spellID = 342249, talentID = 80159},
		MirrorImage = {spellID = 55342, talentID = 80183},
		OverflowingEnergy = {spellID = 390218, talentID = 80179},
		QuickWitted = {spellID = 382297, talentID = 80161},
		Reabsorption = {spellID = 382820, talentID = 80184},
		Reduplication = {spellID = 382569, talentID = 80185},
		RemoveCurse = {spellID = 475, talentID = 80175},
		RigidIce = {spellID = 382481, talentID = 80168},
		RingofFrost = {spellID = 113724, talentID = 80144},
		ShiftingPower = {spellID = 382440, talentID = 80171},
		Shimmer = {spellID = 212653, talentID = 80163},
		Slow = {spellID = 31589, talentID = 80154},
		Spellsteal = {spellID = 30449, talentID = 80140},
		TempestBarrier = {spellID = 382289, talentID = 80169},
		TemporalVelocity = {spellID = 382826, talentID = 80156},
		TemporalWarp = {spellID = 386539, talentID = 80150},
		TimeAnomaly = {spellID = 383243, talentID = 80151},
		TimeManipulation = {spellID = 387807, talentID = 80189},
		TomeofAntonidas = {spellID = 382490, talentID = 80155},
		TomeofRhonin = {spellID = 382493, talentID = 80187},
		VolatileDetonation = {spellID = 389627, talentID = 80145},
		WintersProtection = {spellID = 382424, talentID = 80182},
	--Fire
		AlexstraszasFury = {spellID = 235870, talentID = 80288},
		CalloftheSunKing = {spellID = 343222, talentID = 80278},
		Combustion = {spellID = 190319, talentID = 80275},
		Conflagration = {spellID = 205023, talentID = 80262},
		Convection = {spellID = 416715, talentID = 80254},
		ControlledDestruction = {spellID = 383669, talentID = 80272},
		CriticalMass = {spellID = 117216, talentID = 80287},
		DeepImpact = {spellID = 416719, talentID = 80252},
		FeeltheBurn = {spellID = 383391, talentID = 80261},
		FerventFlickering = {spellID = 387044, talentID = 80286},
		FeveredIncantation = {spellID = 383810, talentID = 80277},
		FieryRush = {spellID = 383634, talentID = 80271},
		FireBlast = {spellID = 108853, talentID = 80282},
		Firefall = {spellID = 384033, talentID = 80264},
		Firemind = {spellID = 383499, talentID = 80276},
		Firestarter = {spellID = 205026, talentID = 80139},
		FlameAccelerant = {spellID = 203275, talentID = 80267},
		FlameOn = {spellID = 205029, talentID = 80256},
		FlamePatch = {spellID = 205037, talentID = 80259},
		FromtheAshes = {spellID = 342344, talentID = 80289},
		FueltheFire = {spellID = 416094, talentID = 80257},
		Hyperthermia = {spellID = 383860, talentID = 116062},
		ImprovedCombustion = {spellID = 383967, talentID = 80269},
		ImprovedScorch = {spellID = 383604, talentID = 80279},
		IncendiaryEruptions = {spellID = 383665, talentID = 80255},
		Inflame = {spellID = 417467, talentID = 116101},
		IntensifyingFlame = {spellID = 416714, talentID = 80274},
		Kindling = {spellID = 155148, talentID = 80265},
		LivingBomb = {spellID = 44457, talentID = 80260},
		MasterofFlame = {spellID = 384174, talentID = 116061},
		Meteor = {spellID = 153561, talentID = 80253},
		PhoenixFlames = {spellID = 257541, talentID = 80285},
		PheonixReborn = {spellID = 383476, talentID = 80266},
		Pyroblast = {spellID = 11366, talentID = 80283},
		Pyromaniac = {spellID = 205020, talentID = 116060},
		Pyrotechnics = {spellID = 157642, talentID = 80284},
		Scorch = {spellID = 2948, talentID = 80281},
		SearingTouch = {spellID = 269644, talentID = 80280},
		SunKingsBlessing = {spellID = 383886, talentID = 80273},
		SurgingBlaze = {spellID = 343230, talentID = 80258},
		TemperedFlames = {spellID = 383659, talentID = 80268},
		UnleashedInferno = {spellID = 416506, talentID = 116063},
		Wildfire = {spellID = 383489, talentID = 80270},
	}
	ids.Fire_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
		NetherwindArmor = 198062,
		TemporalShield = 198111,
		Tinder = 203275,
		WorldinFlames = 203280,
		ControlledBurn = 280450,
		Firestarter = 203283,
		Flamecannon = 203284,
		GreaterPyroblast = 203286,
		PrismaticCloak = 198064,
		DampenedMagic = 236788,
		Kleptomania = 198100,
	}
	ids.Fire_Form = {

	}
	ids.Fire_Buff = {
		ArcaneIntellect = 1459,
		BlazingBarrier = 235313,
		Combustion = 190319,
		HeatingUp = 48107,
		HotStreak = 48108,
		IncantersFlow = 116267,
		LivingBomb = 217694,
		Pyroclasm = 269651, 
	}
	ids.Fire_Debuff = {
		Conflagration = 226757,
		Ignite = 12654,
	}
	ids.Fire_PetAbility = {

	}

--Frost
	ids.Frost_Ability = {
	--Mage Baseline
		ArcaneExplosion = {spellID = 1449},
		ArcaneIntellect = {spellID = 1459},
		Blink = {spellID = 1953},
		ConeofCold = {spellID = 120},
		ConjureRefreshment = {spellID = 190336},
		Counterspell = {spellID = 2139},
		FireBlast = {spellID = 319836},
		FrostNova = {spellID = 122},
		Frostbolt = {spellID = 116},
		Invisibility = {spellID = 66},
		Polymorph = {spellID = 118},
		Portal = {
		},
		SlowFall = {spellID = 130},
		Teleport = {
		},
		TimeWarp = {spellID = 80353},
	--Frost Baseline
		Blizzard = {spellID = 190356},
		ColdSnap = {spellID = 235219},
		MasteryIcicles = {spellID = 76613},
	--Mage
		AccumulativeShielding = {spellID = 382800, talentID = 80149},
		AlterTime = {spellID = 342245, talentID = 80174},
		ArcaneWarding = {spellID = 383092, talentID = 80173},
		BlastWave = {spellID = 157981, talentID = 80160},
		CryoFreeze = {spellID = 382292, talentID = 80165},
		DragonsBreath = {spellID = 31661, talentID = 80147},
		Displacement = {spellID = 389713, talentID = 80152},
		DivertedEnergy = {spellID = 382270, talentID = 80158},
		EnergizedBarriers = {spellID = 386828, talentID = 80157},
		FlowofTime = {spellID = 382268, talentID = 80153},
		FreezingCold = {spellID = 386763, talentID = 80143},
		FrigidWinds = {spellID = 235224, talentID = 80188},
		GreaterInvisibility = {spellID = 110959, talentID = 115877},
		IceBarrier = {spellID = 11426, talentID = 80176},
		IceBlock = {spellID = 45438, talentID = 80181},
		IceCold = {spellID = 414659, talentID = 80141},
			IceBlockIC = {spellID = 414658, talentID = 80141},
		IceFloes = {spellID = 108839, talentID = 80162},
		IceNova = {spellID = 157997, talentID = 80186},
		IceWard = {spellID = 205036, talentID = 80142},
		ImprovedFrostNova = {spellID = 343183, talentID = 80166},
		IncantationofSwiftness = {spellID = 382293, talentID = 80170},
		IncantersFlow = {spellID = 1463, talentID = 80177},
		MassPolymorph = {spellID = 383121, talentID = 80164},
		MassBarrier = {spellID = 414660, talentID = 80148},
		MassInvisibility = {spellID = 414664, talentID = 115878},
		MassSlow = {spellID = 391102, talentID = 80167},
		MasterofTime = {spellID = 342249, talentID = 80159},
		MirrorImage = {spellID = 55342, talentID = 80183},
		OverflowingEnergy = {spellID = 390218, talentID = 80179},
		QuickWitted = {spellID = 382297, talentID = 80161},
		Reabsorption = {spellID = 382820, talentID = 80184},
		Reduplication = {spellID = 382569, talentID = 80185},
		RemoveCurse = {spellID = 475, talentID = 80175},
		RigidIce = {spellID = 382481, talentID = 80168},
		RingofFrost = {spellID = 113724, talentID = 80144},
		ShiftingPower = {spellID = 382440, talentID = 80171},
		Shimmer = {spellID = 212653, talentID = 80163},
		Slow = {spellID = 31589, talentID = 80154},
		Spellsteal = {spellID = 30449, talentID = 80140},
		TempestBarrier = {spellID = 382289, talentID = 80169},
		TemporalVelocity = {spellID = 382826, talentID = 80156},
		TemporalWarp = {spellID = 386539, talentID = 80150},
		TimeAnomaly = {spellID = 383243, talentID = 80151},
		TimeManipulation = {spellID = 387807, talentID = 80189},
		TomeofAntonidas = {spellID = 382490, talentID = 80155},
		TomeofRhonin = {spellID = 382493, talentID = 80187},
		VolatileDetonation = {spellID = 389627, talentID = 80145},
		WintersProtection = {spellID = 382424, talentID = 80182},
	--Frost
		BoneChilling = {spellID = 205027, talentID = 80230},
		BrainFreeze = {spellID = 190447, talentID = 80244},
		ChainReaction = {spellID = 378309, talentID = 80226},
		ColdFront = {spellID = 382110, talentID = 80251},
		ColdestSnap = {spellID = 417493, talentID = 80218},
		CometStorm = {spellID = 153595, talentID = 80248},
		Cryopathy = {spellID = 417491, talentID = 80215},
		DeepShatter = {spellID = 378749, talentID = 80222},
		EverlastingFrost = {spellID = 385167, talentID = 102429},
		FingersofFrost = {spellID = 112965, talentID = 80227},
		FlashFreeze = {spellID = 379993, talentID = 80231},
		Flurry = {spellID = 44614, talentID = 80243},
		FracturedFrost = {spellID = 378448, talentID = 80250},
		FreezingRain = {spellID = 270233, talentID = 80212},
		FreezingWinds = {spellID = 382103, talentID = 80214},
		Frostbite = {spellID = 378756, talentID = 102428},
		FrozenOrb = {spellID = 84714, talentID = 80242},
		FrozenTouch = {spellID = 205030, talentID = 80245},
		GlacialAssault = {spellID = 378947, talentID = 80249},
		GlacialSpike = {spellID = 199786, talentID = 80220},
		Hailstones = {spellID = 381244, talentID = 80221},
		IceCaller = {spellID = 236662, talentID = 80233},
		IceLance = {spellID = 30455, talentID = 80241},
		IcyVeins = {spellID = 12472, talentID = 80235},
		LonelyWinter = {spellID = 205024, talentID = 80237},
		PerpetualWinter = {spellID = 378198, talentID = 80247},
		PiercingCold = {spellID = 378919, talentID = 80229},
		RayofFrost = {spellID = 205021, talentID = 80216},
		Shatter = {spellID = 12982, talentID = 80228},
		SlickIce = {spellID = 382144, talentID = 80219},
		Snowstorm = {spellID = 381706, talentID = 80234},
		SplinteringCold = {spellID = 379049, talentID = 80225},
		SplinteringRay = {spellID = 418733, talentID = 116133},
		SplittingIce = {spellID = 56377, talentID = 80224},
		SubZero = {spellID = 380154, talentID = 80223},
		ThermalVoid = {spellID = 155149, talentID = 80217},
		WintersBlessing = {spellID = 417489, talentID = 80239},
		Wintertide = {spellID = 378406, talentID = 80236},
	}
	ids.Frost_PvPTalent = {
		DampenedMagic = {spellID = 236788},
		Kleptomania = {spellID = 198100},
		ChilledtotheBone = {spellID = 198126},
		Frostbite = {spellID = 198120},
		DeepShatter = {spellID = 198123},
		ConcentratedCoolness = {spellID = 198148},
			ConcentratedCoolness_FrozenOrb = {spellID = 198149},
		BurstofCold = {spellID = 206431},
		IceForm = {spellID = 198144},
		NetherwindArmor = {spellID = 198062},
		PrismaticCloak = {spellID = 198064},
	}
	ids.Frost_Form = {
		FreezingWinds = 382106,
	}
	ids.Frost_Buff = {
		ArcaneIntellect = 1459,
		BrainFreeze = 190446,
		FingersofFrost = 44544,
		FreezingRain = 270232,
		GlacialSpike = 199844,
		IceBarrier = 11426,
		Icicles = 205473,
		IcyVeins = 12472,
	}
	ids.Frost_Debuff = {
		TemporalDisplacement = 80354,
		WintersChill = 228358,
	}
	ids.Frost_PetAbility = {

	}
