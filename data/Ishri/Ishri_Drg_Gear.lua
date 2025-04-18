-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Match','Normal','Acc')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Weapons:options('Trishula','Shining','Savage')
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}

    select_default_macro_book()
		
	--DRG	
	--Academic
	gear.DRG_AF_Head		=	{ name="Vishap Armet +1"}
    gear.DRG_AF_Body		=	{ name="Vishap Mail +1"}
    gear.DRG_AF_Hands		=	{ name="Vishap Finger Gauntlets +1"}
    gear.DRG_AF_Legs		=	{ name="Vishap Brais +1"}
    gear.DRG_AF_Feet		=	{ name="Vishap Greaves +1"}
    --Pedagogy
    gear.DRG_RELIC_Head		=	{ name="Pteroslaver Armet"}
    gear.DRG_RELIC_Body		=	{ name="Pteroslaver Mail"}
    gear.DRG_RELIC_Hands 	=	{ name="Pteroslaver Finger Gauntlets"}
    gear.DRG_RELIC_Legs		=	{ name="Pteroslaver Brais +3"}
    gear.DRG_RELIC_Feet		=	{ name="Pteroslaver Greaves"}
    --Peltast
    gear.DRG_EMPY_Head		=	{ name="Peltast's Mezail"}
    gear.DRG_EMPY_Body		=	{ name="Peltast's Plackart +2"}
    gear.DRG_EMPY_Hands		=	{ name="Peltast's Vambraces"}
    gear.DRG_EMPY_Legs		=	{ name="Peltast's Cuissots"}
    gear.DRG_EMPY_Feet		=	{ name="Peltast's Schynbalds"}	
	
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +1"}

	sets.precast.JA.Jump = {
    	ammo="Focal Orb", --aurgelmir
    	head="Flam. Zucchetto +2",
    	body=gear.DRG_AF_Body,
    	hands=gear.DRG_AF_Hands,
    	legs=gear.DRG_RELIC_Legs,
    	feet="Flam. Gambieras +2", --ostro greaves
    	neck="Anu Torque", --vim torque
    	waist="Dynamic Belt +1", --sailfi +1
    	left_ear="Sherida Earring",
    	right_ear="Telos Earring",
    	left_ring="Petrov Ring",
    	right_ring="Niqmaddu Ring",
    	back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

	sets.precast.JA['Ancient Circle'] = {legs = gear.DRG_AF_Legs} --legs="Vishap Brais"

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {})
	
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
	
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {}) --empy feet
	
	sets.precast.JA['Super Jump'] = {}
	
	sets.precast.JA['Spirit Link'] = {head = gear.DRG_AF_Head} hands="Lnc. Vmbrc. +2"
	
	sets.precast.JA['Call Wyvern'] = {body = gear.DRG_RELIC_Body} 
	
	sets.precast.JA['Deep Breathing'] = {hands = gear.DRG_AF_Hands}
	
	sets.precast.JA['Spirit Surge'] = {body = gear.DRG_RELIC_Body} 
	
	sets.precast.JA['Steady Wing'] = {}
	
	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {back="Brigantia's Mantle"}
	
	sets.precast.JA['Smiting Breath'] = {back="Brigantia's Mantle"}
	
	sets.HealingBreath = {back="Brigantia's Mantle"}
	--sets.SmitingBreath = {back="Brigantia's Mantle"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Founder's Greaves",feet="Carmine Greaves +1"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Tempus Fugit",legs="Founder's Greaves",feet="Carmine Greaves +1"}
		
	-- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
	sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {head="Vishap Armet +1"})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
    	ammo="Knobkierrie",
    	head="Gleti's Mask", --peltast
    	body="Gleti's Cuirass",
    	hands="Gleti's Gauntlets",
    	legs="Gleti's Breeches",
    	feet="Gleti's Boots",
    	neck="Dragoon's Collar +1",
    	waist="Sailfi Belt +1",
    	left_ear="Thrud Earring",
    	right_ear="Moonshade Earring",
    	left_ring="Sroda Ring",
    	right_ring="Niqmaddu Ring",
    	back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
		
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = {
    	ammo="Knobkierrie",
    	head="Gleti's Mask",
    	body="Nyame Mail",
    	hands="Gleti's Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck="Dragoon's Collar +1",
    	waist="Sailfi Belt +1",
    	left_ear="Sherida Earring",
    	right_ear="Moonshade Earring",
    	left_ring="Sroda Ring",
    	right_ring="Niqmaddu Ring",
    	back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

		-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Gleti's Cuirass",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Dragoon's Collar +1",
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear="Moonshade Earring",
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Dragoon's Collar +1",
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

	sets.precast.WS['Judgment'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Dragoon's Collar +1",
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}


	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
    	ammo="Staunch Tathlum",
    	head="Nyame Helm",
    	body="Nyame Mail",
    	hands="Gleti's Gauntlets",
    	legs="Carmine Cuisses +1",
    	feet="Gleti's Boots",
    	neck="Sanctity Necklace",
    	waist="Chuq'aba Belt",
    	left_ear="Eabani Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Fortified Ring",
    	right_ring="Moonbeam Ring",
    	back="Impassive Mantle",
	}
		
	sets.idle.Refresh = {ammo="Staunch Tathlum",
		head="Jumalik Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Amm Greaves"}

	sets.idle.Weak = set_combine(sets.idle, {head="Crepuscular Helm",body="Crepuscular Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Crepuscular Helm",body="Crepuscular Mail"})
	
	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +2",ring1="Moonbeam Ring",ring2="Moonlight Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Arke Cosc. +1",feet="Amm Greaves"}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Crepuscular Helm",body="Crepuscular Mail"})

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +2",ring1="Moonbeam Ring",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Arke Cosc. +1",feet="Amm Greaves"}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Crepuscular Helm",body="Crepuscular Mail"})
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +2",ring1="Moonbeam Ring",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Arke Cosc. +1",feet="Amm Greaves"}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Reraise = {head="Crepuscular Helm",body="Crepuscular Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.passive.MP = {ear2="Ethereal Earring",waist="Flume Belt +1"}
    sets.passive.Twilight = {head="Crepuscular Helm", body="Crepuscular Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Trishula = {main="Trishula",sub="Utu Grip"}
	sets.weapons.Shining = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Savage = {main="Naegling"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Moonshade Earring",ear2="Sherida Earring",}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {
    	ammo="Coiste Bodhar",
    	head="Hjarrandi Helm",
    	body="Pelt. Plackart +2",
    	hands={ name="Acro Gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+4','DEX+9',}}, --pelt vambraces
    	legs=gear.DRG_RELIC_Legs,
    	feet="Flam. Gambieras +2",
    	neck="Anu Torque", --vim torque
    	waist="Ioskeha Belt +1", --sailfi  fully updated
    	left_ear="Sherida Earring",
    	right_ear="Sroda Earring", 
    	left_ring="Moonbeam Ring",
    	right_ring="Niqmaddu Ring",
    	back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}

		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(5, 13)
end