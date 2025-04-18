function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','Tank')
    state.MagicalDefenseMode:options('BDT','AegisMDT','OchainMDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','PDT','MDT','Refresh','Reraise')
	state.Weapons:options('None','Naegling','Tanky')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}}

	-- Additional local binds
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {    
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},    
		legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},    
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    	neck="Moonbeam Necklace",
    	waist="Creed Baudrier",
    	left_ear="Friomisi Earring",
    	right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    	left_ring="Eihwaz Ring",
    	right_ring="Vexer Ring",
    	back=gear.enmity_jse_back,
	}
		
    sets.Enmity.SIRD = {
		ammo="Staunch Tathlum",
		head="Souveran Schaller +1",
		neck="Moonbeam Necklace",
		ear1="Friomisi Earring",
		ear2="Trux Earring",
		body="Souv. Cuirass +1",
		hands="Souv. Handsch. +1",
		ring1="Evanescence Ring",
		ring2="Moonbeam Ring",
		back=gear.enmity_jse_back,
		waist="Rumination Sash",
		legs="Carmine Cuisses +1",
		feet="Odyssean Greaves"
	}				
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +2"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{ head="Cab. Coronet +1" })
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat"}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +2"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{ head="Cab. Coronet +1" })
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat "})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Sulevia's Mask +2",
		neck="Phalaina Locket",
		ear1="Nourish. Earring",
		ear2="Nourish. Earring +1",
		body="Rev. Surcoat +3",
		hands="Cab. Gauntlets +2",
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back=gear.enmity_jse_back,
		waist="Luminary Sash",
		legs="Carmine Cuisses +1",
		feet="Carmine Greaves +1"
	}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		head="Carmine Mask +1",
		neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Rev. Surcoat +3",
		hands="Leyline Gloves",
		ring1="Lebeche Ring",
		ring2="Kishar Ring",
		back=gear.fastcast_jse_back,
		waist="Flume Belt +1",
		legs=gear.odyssean_fc_legs,
		feet="Odyssean Greaves"
	}		
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, 
	{neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Paeapua",
		head="Nyame Helm",
		neck="Asperity Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Regal Ring",
		ring2="Rufescent Ring",
		back="Bleating Mantle",
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
		

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {ammo="Paeapua",
        head="Chev. Armet +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Rev. Surcoat +3",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
        waist="Tempus Fugit",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
		
	sets.midcast.FastRecast.DT = {ammo="Staunch Tathlum",
        head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonbeam Ring",
        back="Moonlight Cape",waist="Creed Baudrier",legs="Souv. Diechlings",feet="Souveran Schuhs +1"}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Solemnity Cape",waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
    sets.midcast.Cure.SIRD = {ammo="Staunch Tathlum",
		head="Souveran Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring",ear2="Chevalier Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Evanescence Ring",
		back="Solemnity Cape",waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}		
		
    sets.midcast.Reprisal = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonbeam Ring",
        back="Moonlight Cape",waist="Creed Baudrier",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}

	sets.Self_Healing = {ammo="Staunch Tathlum",
		head="Souv. Schaller +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonbeam Ring",
		back="Moonlight Cape",waist="Creed Baudrier",legs="Souv. Diechlings",feet="Souveran Schuhs +1"}
		
	sets.Self_Healing.SIRD = {ammo="Staunch Tathlum",
		head="Souv. Schaller +1",neck="Moonbeam Necklace",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Founder's Hose",feet="Odyssean Greaves"}		

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {main="Colada",ammo="Staunch Tathlum",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Shab. Cuirass +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
    sets.midcast['Enhancing Magic'].SIRD = {main="Colada",ammo="Staunch Tathlum",
		head="Souv. Schaller +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Etiolation Earring",
		body="Shab. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Rev. Leggings +3",feet="Odyssean Greaves"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {hands="Souv. Handsch. +1",back="Weard Mantle",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {hands="Souv. Handsch. +1",back="Weard Mantle",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Warder's Charm",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Fucho-no-obi",legs="Sulev. Cuisses +2",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {    
		ammo="Staunch Tathlum",
    	head="Sakpata's Helm",
    	body="Sakpata's Plate",
    	hands="Regal Gauntlets",
    	legs="Sakpata's Cuisses",
    	feet="Sakpata's Leggings",
    	neck="Unmoving Collar +1",
    	waist="Asklepian Belt",
    	left_ear="Etiolation Earring",
    	right_ear="Odnowa Earring +1",
    	left_ring="Moonbeam Ring",
    	right_ring="Defending Ring",
    	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
	}
		
		
	sets.idle.Refresh = {ammo="Homiliary",
		head="Jumalik Helm",neck="Warder's Charm",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Souv. Diechlings",feet="Cab. Leggings +1"}

	sets.idle.Tank = {ammo="Staunch Tathlum",
		head="Souveran Schaller +1",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Moonbeam Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Asklepian Belt",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}
		
	sets.idle.KiteTank = {ammo="Staunch Tathlum",
		head="Souveran Schaller +1",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Moonbeam Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Asklepian Belt",legs="Carmine Cuisses +1",feet="Sakpata's Leggings"}
		
    sets.idle.Reraise = {ammo="Staunch Tathlum",
		head="Crepuscular Helm",neck="Moonbeam Necklace",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Crepuscular Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Warder's Charm",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +1",neck="Warder's Charm",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Crepuscular Helm", body="Crepuscular Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.Tanky = {main="Sakpata's Sword",sub="Priwen"}
    
    sets.defense.PDT = {main="Mafic Cudgel",sub="Ochain",ammo="Staunch Tathlum",
		head="Chev. Armet +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Warden's Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Souv. Diechlings",feet="Souveran Schuhs +1"}		
		
    sets.defense.PDT_Reraise = {ammo="Staunch Tathlum",
        head="Crepuscular Helm",neck="Moonbeam Necklace",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Crepuscular Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}
		
    sets.defense.MDT_Reraise = {main="Mafic Cudgel",sub="Aegis",ammo="Staunch Tathlum",
        head="Crepuscular Helm",neck="Moonbeam Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Crepuscular Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Engulfer Cape +1",waist="Flume Belt +1",legs=gear.odyssean_fc_legs,feet="Cab. Leggings +1"}

	sets.defense.BDT = {main="Mafic Cudgel",sub="Aegis",ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Asklepian Belt",legs="Sulev. Cuisses +2",feet="Amm Greaves"}
		
	sets.defense.Tank = {ammo="Staunch Tathlum",
		head="Chev. Armet +1",neck="Moonbeam Necklace",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Chev. Cuisses +1",feet="Souveran Schuhs +1"}
		
	sets.defense.MEVA = {main="Malignance Sword",sub="Aegis",ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Hippo. Socks +1"}
		
	sets.defense.Death = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Moonbeam Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Warden's Ring",ring2="Shadow Ring",
        back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
		
	sets.defense.Charm = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back="Solemnity Cape",waist="Asklepian Belt",legs="Souv. Diechlings",feet="Odyssean Greaves"}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {sub="Aegis",ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Chev. Cuisses +1",feet="Chev. Sabatons +1"}
		
    sets.defense.AegisMDT = {sub="Aegis",ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}	

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo="Staunch Tathlum",
		head="Souveran Schaller +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Sakpata's Plate",
		hands="Regal Gauntlets",
		ring1="Moonbeam Ring",
		ring2="Petrov Ring",
		back="Rudianos's Mantle",
		waist="Asklepian Belt",
		legs="Souveran Diechlings",
		feet="Sakpata's Leggings"
	}

	sets.engaged.Tank = {
		ammo="Staunch Tathlum",
		head="Souveran Schaller +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Sakpata's Plate",
		hands="Regal Gauntlets",
		ring1="Moonbeam Ring",
		ring2="Petrov Ring",
		back="Rudianos's Mantle",
		waist="Asklepian Belt",
		legs="Souveran Diechlings",
		feet="Sakpata's Leggings"
	}
		
	sets.engaged.BreathTank = {
		ammo="Staunch Tathlum",
		head="Loess Barbuta +1",
		neck="Moonbeam Necklace",
		ear1="Thureous Earring",
		ear2="Etiolation Earring",
		body="Tartarus Platemail",
		hands="Sulev. Gauntlets +2",
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back="Engulfer Cape +1",
		waist="Creed Baudrier",
		legs="Sulev. Cuisses +2",
		feet="Amm Greaves"
	}		
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(2, 4)
end