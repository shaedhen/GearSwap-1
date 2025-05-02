function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.WeaponskillMode:options('Match','Normal','Acc')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('GAxe','Naegling','Greatsword','Spear','Club')

	gear.da_jse_back = {name="Cichol's Mantle",augments={'DEX+30','Accuracy+20 Attack+20','"Dbl.Atk."+10'}}
	gear.wsd_jse_back = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
    sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Twilight = {head="Crepuscular Helm",body="Crepuscular Mail"}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {back="Cichol's Mantle", feet= "Agoge Calligae +2"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +2"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge lorica +2"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {hands="Pummeler's Mufflers +2"}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
                  
                   
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    	ammo="Knobkierrie",
    	head="Sakpata's Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Sakpata's Gauntlets",
    	legs="Boii Cuisses +2",
    	feet="Sulev. Leggings +2",
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Thrud Earring",
    	left_ring="Karieyh Ring",
    	right_ring="Niqmaddu Ring",
    	back=gear.wsd_jse_back 
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Savage Blade'] = {
    	ammo="Knobkierrie",
    	head="Nyame Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Nyame Gauntlets",
    	legs="Boii Cuisses +2",
    	feet="Nyame Sollerets",
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Thrud Earring",
    	left_ring="Karieyh Ring", -- regal ?
    	right_ring="Niqmaddu Ring",
    	back=gear.wsd_jse_back 
	}

    sets.precast.WS['Upheaval'] = {
    	ammo="Knobkierrie",
    	head="Nyame Helm",
    	body={ name="Nyame Mail", augments={'Path: B',}},
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Thrud Earring",
    	left_ring="Karieyh Ring", -- regal ?
    	right_ring="Niqmaddu Ring",
    	back=gear.wsd_jse_back 
	}
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Impulse Drive'] = {
    	ammo="Knobkierrie",
    	head="Nyame Helm", -- boii
    	body="Hjarrandi Breast.",
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Thrud Earring",
    	left_ring="Karieyh Ring", -- regal ?
    	right_ring="Niqmaddu Ring",
    	back=gear.wsd_jse_back 
	}

	sets.precast.WS['Judgment'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="War. Beads +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Karieyh Ring", -- regal ?
		right_ring="Regal Ring",
		back=gear.wsd_jse_back 
	}


	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	
	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Idle sets
	sets.idle = {   --use volte for regen, sacro breastplate, macabre gauntlets +1
		ammo="Staunch Tathlum",
		head="Sakpata's Helm",
		neck="Loricate Torque +1",
		ear1="Genmei Earring",
		ear2="Odnowa Earring +1",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Defending Ring",
		ring2="Chirich Ring +1",
		back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	}
		
	sets.idle.Weak = set_combine(sets.idle, {head="Crepuscular Helm",body="Crepuscular Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Crepuscular Helm",body="Crepuscular Mail"})
	
	-- Defense sets


	sets.Kiting = {}
	sets.Reraise = {head="Crepuscular Helm",body="Crepuscular Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
     
            -- Engaged sets
	sets.engaged = {    
		ammo="Coiste Bodhar",
    	head="Hjarrandi Helm", --boii
    	body="Hjarrandi Breast.",
    	hands="Sakpata's Gauntlets",
    	legs="Pumm. Cuisses +2",
    	feet="Flam. Gambieras +2", --pummeler
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Ioskeha Belt +1", --sailfi +1 fully augmented
    	left_ear="Brutal Earring",
    	right_ear="Schere Earring",
    	left_ring="Moonbeam Ring", -- petrov
    	right_ring="Niqmaddu Ring",
    	back=gear.da_jse_back 
	}

	sets.engaged.Acc = {    
		ammo="Coiste Bodhar",
    	head="Sakpata's Helm",
    	body="Sakpata's Plate",
    	hands="Sakpata's Gauntlets",
    	legs="Sakpata's Cuisses",
    	feet="Sakpata's Leggings", --pummeler
    	neck={ name="War. Beads +1", augments={'Path: A',}},
    	waist="Ioskeha Belt +1", --sailfi +1 fully augmented
    	left_ear="Brutal Earring",
    	right_ear="Schere Earring",
    	left_ring="Moonbeam Ring", -- petrov
    	right_ring="Niqmaddu Ring",
    	back=gear.da_jse_back 
	}

	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.GAxe = {main="Chango",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.Greatsword = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.Spear = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Club = {main="Loxotic Mace +1",sub="Blurred Shield +1"}
	
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(3, 3)
end
