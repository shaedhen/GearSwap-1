function user_job_setup()
include('Kusheline-Items.lua')
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal','DT')
--	state.WeaponsSongMode:options('Always','300','1000','Never')
	state.Weapons:options('None','Kali','DualKali','Tauret','Naegling')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Blurred Harp +1'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Kali = {main="Kali",sub="Genmei Shield"}
	sets.weapons.DualKali = {main="Kali",sub="Kali"}
	sets.weapons.Tauret = {main="Tauret",sub="Blurred Knife"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Knife"}
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main="Kali",
		sub="Kali",
		legs="Doyen Pants",
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {
		main="Kali",
		sub="Kali",
		range="Miracle Cheer",
		legs="Doyen Pants",
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'] = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'] = {range="Blurred Harp +1"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet=gear.BRD_RELIC_Feet}
	sets.precast.JA.Troubadour = {body=gear.BRD_RELIC_Body}
	sets.precast.JA['Soul Voice'] = {legs=gear.BRD_RELIC_Legs}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas",
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +2",
    neck={ name="Bard's Charm", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Eabani Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Ayanmo Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Intarabus's Cape",waist="Witful Belt",legs="Aya. Cosciales",feet="Gende. Galosh. +1"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave"}
	sets.midcast.Lullaby = {range="Marsyas",hands=gear.BRD_AF_Hands}
	sets.midcast['Horde Lullaby'] = {range="Blurred Harp +1",hands=gear.BRD_AF_Hands}
	sets.midcast['Horde Lullaby II'] = {range="Blurred Harp +1",hands=gear.BRD_AF_Hands}

	sets.midcast.Madrigal = {head=gear.BRD_EMPY_Head}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands=gear.BRD_EMPY_Hands}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body=gear.BRD_EMPY_Body}
	sets.midcast.Minne = {legs="Mousai Seraweels +1"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +2"}
	sets.midcast['Magic Finale'] = {range="Marsyas"}
	sets.midcast.Threnody = {body="Mousai Manteel +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
	sets.midcast.Mambo = {head="Mousai Crackows"}
	sets.midcast.Mazurka = {range="Marsyas"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {        
		main="Kali",
        sub="Kali",
		ammo=empty,
		head=gear.BRD_EMPY_Head,
		neck="Mnbw. Whistle",
		ear1="Etiolation Earring",
		ear2="Eabani Earring",
		body=gear.BRD_EMPY_Body,
		hands=gear.BRD_EMPY_Hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Intarabus's Cape",
		waist="Kobo Obi",
		legs="Inyanga Shalwar",
		feet=gear.BRD_AF_Feet
	}
		
	sets.midcast.SongEffect.DW = {
	main="Kali",
	sub="Kali",
			ammo=empty,
		head=gear.BRD_EMPY_Head,
		neck="Mnbw. Whistle",
		ear1="Etiolation Earring",
		ear2="Eabani Earring",
		body=gear.BRD_EMPY_Body,
		hands=gear.BRD_EMPY_Hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Intarabus's Cape",
		waist="Kobo Obi",
		legs="Inyanga Shalwar",
		feet=gear.BRD_AF_Feet
	}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {	
	main="Kali",
	sub="Ammurapi Shield",
    range="Gjallarhorn",
	ammo=empty,
    head=gear.BRD_AF_Head,
    body=gear.BRD_AF_Body,
    hands=gear.BRD_AF_Hands,
    legs=gear.BRD_AF_Legs,
    feet=gear.BRD_AF_Feet,
    neck="Mnbw. Whistle",
    waist="Acuity Belt +1",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back=gear.BRD_FC_Cape
	}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",range="Terpander",ammo=empty,
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Intarabus's Cape",waist="Witful Belt",legs="Fili Rhingrave +2",feet="Aya. Gambieras +2"}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
        head="Kaykaus Mitra +1",
		neck="Incanter's Torque",
		ear1="Gifted Earring",
		ear2="Calamitous Earring",
        body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		ring1="Stikini Ring",
		ring2="Mephitas Ring +1",
        back="Aurist's Cape +1",
		waist="Shinjutsu-No-Obi +1",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1"
		}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Pukulatmuj +1",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Intarabus's Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
	sets.idle = {        
	ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet=gear.BRD_EMPY_Feet,
    neck="Warder's Charm +1",
    waist="Carrier's Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Purity Ring",
    back=gear.BRD_Idle_Cape,}
	
		
	sets.idle.DW = {
	ammo="Staunch Tathlum +1",
    head="Bunzi's Hat",
    body="Bunzi's Robe",
    hands="Bunzi's Gloves",
    legs="Bunzi's Pants",
    feet="Fili Cothurnes +2",
    neck="Warder's Charm +1",
    waist="Carrier's Sash",
    left_ear="Etiolation Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Purity Ring",
    back=gear.BRD_Idle_Cape,}
		

	sets.Kiting = {feet="Fili Cothurnes"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	--sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas",
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +2",
    neck={ name="Bard's Charm", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Eabani Earring",
    right_ear="Suppanomimi",
    left_ring="Ayanmo Ring",
    right_ring="Inyanga Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	}
	
	sets.engaged.DW = {	
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas",
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +2",
    neck={ name="Bard's Charm", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Eabani Earring",
    right_ear="Suppanomimi",
    left_ring="Ayanmo Ring",
    right_ring="Inyanga Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 14)
end