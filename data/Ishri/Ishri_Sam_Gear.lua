-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal','DT','Reraise')
    state.WeaponskillMode:options('Match','Normal','Acc','Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'Reraise')
	state.Weapons:options('ShiningOne','Dojikiri')

	gear.ws_jse_back = {name="Smertrios's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.tp_jse_back = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote +3",back=gear.ws_jse_back}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
    -- Ranged snapshot gear
    sets.precast.RA = {}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        sub="Utu Grip",
        ammo="Knobkierrie",
        head={ name="Mpaca's Cap", augments={'Path: A',}},
        body="Sakonji Domaru +3",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Karieyh Ring",
        right_ring="Regal Ring",
        back=gear.ws_jse_back,
    }

    sets.precast.WS['Impulse Drive'] = {
        sub="Utu Grip",
        ammo="Knobkierrie",
        head={ name="Mpaca's Cap", augments={'Path: A',}},
        body="Sakonji Domaru +3",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Karieyh Ring",
        right_ring="Regal Ring",
        back=gear.ws_jse_back,
    }
		

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring",}
					
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Crepuscular Helm",body="Crepuscular Mail"}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
    sets.idle = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist="Ioskeha Belt +1",
        left_ear="Brutal Earring",
        right_ear={ name="Schere Earring", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back=gear.tp_jse_back,
    }
		
	
	sets.DayIdle = {}
	sets.NightIdle = {}
    

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Crepuscular Mail",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Flam. Gambieras +2",
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist="Sweordfaetels +1",
        left_ear="Brutal Earring",
        right_ear="Schere Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Defending Ring",
        back=gear.tp_jse_back,
}
   
    

	-- Weapons sets
	sets.weapons.ShiningOne = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna",sub="Utu Grip"}

	-- Buff sets
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash",legs="Flamma Dirs +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +1"}
    sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(1, 1)
end
