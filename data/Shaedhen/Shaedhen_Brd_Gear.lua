function user_job_setup()
include('Shaedhen-Items.lua')
	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Normal', 'Capped')
    state.CastingMode:options('Normal','Resistant','AoE','Enmity','LongBallad')
    state.IdleMode:options('Normal','DT')
--	state.WeaponsSongMode:options('Always','300','1000','Never')
	state.Weapons:options('None','Carnwenhan','DualCarnwenhan','Kali','Gleti','DualNaegling','DualNaegAcc','DualTauret','DualAE')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
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
	sets.weapons.Carnwenhan = {main="Carnwenhan",sub="Genmei Shield"}
	sets.weapons.DualCarnwenhan = {main="Carnwenhan",sub="Gleti's Knife"}
	sets.weapons.Kali = {main="Kali",sub="Genmei Shield"}
	sets.weapons.Gleti = {main="Gleti's Knife",sub="Genmei Shield"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Fusetto +2"}
	sets.weapons.DualNaegAcc = {main="Naegling",sub="Gleti's Knife"}
	sets.weapons.DualTauret = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.DualAE = {main="Carnwenhan",sub="Malevolence"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main="Carnwenhan",
		sub="Genmei Shield",
		ammo="Impatiens",
		head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gendewitha Gages +1",
		ring1="Kishar Ring",
		ring2="Weatherspoon Ring +1",
		back=gear.BRD_FC_Cape,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet="Gende. Galosh. +1"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {
		main="Carnwenhan",
		sub="Genmei Shield",
		range="Gjallarhorn",
		ammo=empty,
		head=gear.BRD_EMPY_Head,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Fili Earring +1",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		ring1="Kishar Ring",
		ring2="Defending Ring",
		back=gear.BRD_Idle_Cape,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet=gear.BRD_EMPY_Feet
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Daurdabla"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Aria of Passion'] = set_combine(sets.precast.FC.BardSong,{range="Loughnashade"})
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
		ammo=gear.Linus_WS,
		head="Aya. Zucchetto +2",
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Metamorph Ring +1",
		ring2="Ilabrat Ring",
		back=gear.BRD_WS1_Cape,
		waist="Grunfeld Rope",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	}
	
	sets.precast.WS['Evisceration'] = 
	{
    range=gear.Linus_WS,
    head="Blistering Sallet +1",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Mache Earring +1",
    body=gear.BRD_RELIC_Body,
    hands="Nyame Gauntlets",
    ring1="Ilabrat Ring",
    ring2="Begrudging Ring",
    back=gear.BRD_WS1_Cape,
    waist="Fotia Belt",
    legs="Jokushu Haidate",
    feet=gear.BRD_RELIC_Feet
	}
	
	sets.precast.WS['Evisceration'].Capped = 
	{
    ammo="Crepuscular Pebble",
    head="Blistering Sallet +1",
    neck="Bard's Charm +2",
    ear1="Mache Earring +1",
    ear2="Mache Earring +1",
    body="Bunzi's Robe",
    hands="Nyame Gauntlets",
    ring1="Ilabrat Ring",
    ring2="Cacoethic Ring +1",
    back=gear.BRD_WS1_Cape,
    waist="Fotia Belt",
    legs="Jokushu Haidate",
    feet=gear.BRD_RELIC_Feet
	}
	
		sets.precast.WS["Rudra's Storm"] = 
	{
    range=gear.Linus_WS,
    head="Nyame Helm",
    neck="Bard's Charm +2",
    ear1="Moonshade Earring",
    ear2="Mache Earring +1",
    body="Bihu Justaucorps +3",
    hands="Nyame Gauntlets",
    ring1="Epaminondas's Ring",
    ring2="Ilabrat Ring",
    back=gear.BRD_WS1_Cape,
    waist="Kentarch Belt +1",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets"
}

	sets.precast.WS["Rudra's Storm"].Capped = 
	{
    range=gear.Linus_WS,
    head="Nyame Helm",
    neck="Bard's Charm +2",
    ear1="Moonshade Earring",
    ear2="Mache Earring +1",
    body="Bihu Justaucorps +3",
    hands="Nyame Gauntlets",
    ring1="Epaminondas's Ring",
    ring2="Ilabrat Ring",
    back=gear.BRD_WS1_Cape,
    waist="Kentarch Belt +1",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets"
	}
	
	sets.precast.WS['Mordant Rime'] = 
	{
    range=gear.Linus_WS,
    neck="Bard's Charm +2",
    ear1="Regal Earring",
    ear2="Ishvara Earring",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Bihu Justaucorps +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    ring1="Metamor. Ring +1",
    ring2="Cornelia's Ring",
    back=gear.BRD_WS1_Cape,
    waist="Sailfi Belt +1",
	}
	
	sets.precast.WS['Mordant Rime'].Capped = 
	{
    range=gear.Linus_WS,
    neck="Bard's Charm +2",
    ear1="Regal Earring",
    ear2="Ishvara Earring",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Bunzi's Robe",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    ring1="Metamor. Ring +1",
    ring2="Cornelia's Ring",
    back=gear.BRD_WS1_Cape,
    waist="Sailfi Belt +1",
	}
	
		sets.precast.WS['Exenterator'] = 
	{
    range=gear.Linus_WS,
    head="Bihu Roundlet +3",
    neck="Fotia Gorget",
    ear1="Brutal Earring",
    ear2="Mache Earring +1",
    body="Ayanmo Corazza +2",
    hands="Bihu Cuffs +3",
    ring1="Petrov Ring",
    ring2="Ilabrat Ring",
    back=gear.BRD_WS1_Cape,
    waist="Fotia Belt",
    legs="Telchine Braconi",
    feet="Bihu Slippers +3"
}
	
		sets.precast.WS['Aeolian Edge'] = 
	{
    range=gear.Linos_AE,
	head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sibyl Scarf",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Shiva Ring +1",
    ring2="Epaminondas's Ring",
    back=gear.BRD_WS1_Cape,
    waist="Orpheus's Sash",
}
	
	sets.precast.WS['Savage Blade'] = 
	{
    range=gear.Linus_WS,
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Bihu Justaucorps +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Republican Platinum Medal",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Cornelia's Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

	sets.precast.WS['Savage Blade'].Capped = 
	{
    range=gear.Linus_WS,
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Bard's Charm +2",
    waist={ name="Kentarch Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Cornelia's Ring",
    right_ring="Sroda Ring",
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
		back="Intarabus's Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Gende. Galosh. +1"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +2"}
	sets.midcast.Ballad.LongBallad = {legs="Inyanga Shalwar +2"}
	sets.midcast.Lullaby = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Marsyas",
		ammo=empty,
		head=gear.BRD_AF_Head,
		body=gear.BRD_EMPY_Body,
		hands=gear.BRD_AF_Hands,
		legs=gear.BRD_AF_Legs,
		feet=gear.BRD_AF_Feet,
		neck="Mnbw. Whistle +1",
		waist="Acuity Belt +1",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=gear.BRD_FC_Cape
	}
	sets.midcast.Lullaby.Resistant = set_combine(sets.midcast.Lullaby,{})
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.Lullaby,{})
	sets.midcast['Horde Lullaby'].Resistant = set_combine(sets.midcast.Lullaby,{})
	sets.midcast['Horde Lullaby II'] = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Daurdabla",
		ammo=empty,
		head=gear.BRD_AF_Head,
		body=gear.BRD_EMPY_Body,
		hands="Inyanga Dasatanas +2",
		legs=gear.BRD_AF_Legs,
		feet=gear.BRD_Relic_Feet,
		neck="Mnbw. Whistle +1",
		waist="Acuity Belt +1",
		left_ear="Digni. Earring", --Gersemi earring ?
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=gear.BRD_FC_Cape
	}
	sets.midcast['Horde Lullaby II'].Resistant = set_combine(sets.midcast['Horde Lullaby II'],{})
	sets.midcast['Horde Lullaby II'].AoE = set_combine(sets.midcast['Horde Lullaby II'],{})
	sets.midcast['Horde Lullaby'].AoE = set_combine(sets.midcast['Horde Lullaby II'],{})

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
	sets.midcast.Mambo = {feet="Mousai Crackows +1"}
	sets.midcast.Mazurka = {range="Marsyas"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {        
		main="Carnwenhan",
        sub="Kali",
		ammo=empty,
		head=gear.BRD_EMPY_Head,
		neck="Mnbw. Whistle +1",
		ear1="Etiolation Earring",
		ear2="Fili Earring +1",
		body=gear.BRD_EMPY_Body,
		hands=gear.BRD_EMPY_Hands,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Intarabus's Cape",
		waist="Kobo Obi",
		legs="Inyanga Shalwar +2",
		feet=gear.BRD_AF_Feet
	}
		
	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {	
	main="Carnwenhan",
	sub="Ammurapi Shield",
    range="Gjallarhorn",
	ammo=empty,
    head=gear.BRD_AF_Head,
    body=gear.BRD_Empy_Body,
    hands=gear.BRD_EMPY_Hands,
    legs=gear.BRD_EMPY_Legs,
    feet=gear.BRD_AF_Feet,
    neck="Mnbw. Whistle +1",
    waist="Acuity Belt +1",
    left_ear="Regal Earring",
    right_ear="Fili Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Metamorph Ring +1",
    back=gear.BRD_FC_Cape
	}
		
	
		sets.midcast.SongEffect.Enmity = {        
    head="Halitus Helm",
    body="Emet Harness +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Zoar Subligar +1", augments={'Path: A',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Unmoving Collar",
    waist="Trance Belt",
    left_ear="Etiolation Earring",
    right_ear="Cryptic Earring",
    left_ring="Provocare Ring",
    right_ring="Petrov Ring",
	}
	
	sets.midcast.SongDebuff.Enmity = set_combine(sets.midcast.SongEffect.Enmity)


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
		ring1="Stikini Ring +1",
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
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Intarabus's Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ombre Tathlum +1",
		head=empty,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Cohort Cloak +1",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ombre Tathlum +1",
		head=empty,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Cohort Cloak +1",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	-- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Enki Strap",ammo="Staunch Tathlum +1",
		head=empty,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Respite Cloak",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Purity ring",
		back="Umbra Cape",waist="Carrier's sash",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
	
	sets.idle = { 
		main="Sangoma",
		sub="Genmei Shield",       
		ammo="Staunch Tathlum +1", --idle linos ?
    	head={ name="Nyame Helm", augments={'Path: B',}},
    	body="Bunzi's Robe",
    	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    	legs={ name="Nyame Flanchard", augments={'Path: B',}},
    	feet=gear.BRD_EMPY_Feet,
    	neck="Warder's Charm +1", --bathy choker ?
    	waist="Carrier's Sash",
    	left_ear="Etiolation Earring", --areta del luna
    	right_ear="Odnowa Earring +1",
    	left_ring="Defending Ring",
    	right_ring="Purity Ring",
    	back=gear.BRD_Idle_Cape,
	}		
		
	sets.idle.DT = {    
		main="Sangoma",
		sub="Genmei Shield", 
    	ammo="Staunch Tathlum +1",
    	head={ name="Nyame Helm", augments={'Path: B',}},
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    	legs={ name="Nyame Flanchard", augments={'Path: B',}},
    	feet={ name="Nyame Sollerets", augments={'Path: B',}},
    	neck={ name="Loricate Torque +1", augments={'Path: A',}},
    	waist="Carrier's Sash",
    	left_ear="Etiolation Earring",
    	right_ear="Odnowa Earring +1",
    	left_ring="Defending Ring",
    	right_ring="Paguroidea Ring",
    	back=gear.BRD_Idle_Cape,
	}	

	sets.Kiting = {feet="Fili Cothurnes +3"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	--sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {range=gear.Linos_TP,
		head="Bunzi's Hat",neck="Bard's Charm +2",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ashera Harness",hands="Bunzi's gloves",ring1="Petrov Ring",ring2="Defending Ring",
		back=gear.BRD_TP_Cape,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.engaged.DW = {range=gear.Linos_TP,  --Volte harness ? check
		head="Bunzi's Hat",neck="Bard's Charm +2",ear1="Dedition Earring",ear2="Brutal Earring",
		body="Ashera Harness",hands="Bunzi's gloves",ring1="Petrov Ring",ring2="Crepuscular Ring",
		back="Null Shawl",waist="Reiki Yotai",legs="Zoar Subligar +1",feet=gear.Chiro_Quad_feet}
	sets.engaged.DW.DT = {range=gear.Linos_TP,
		head="Bunzi's Hat",neck="Bard's Charm +2",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ashera Harness",hands="Bunzi's gloves",ring1="Defending Ring",ring2="Chirich Ring +1",
		back=gear.BRD_TP_Cape,waist="Windbuffet Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 14)
end