-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Pet','DT','Normal')
    state.WeaponskillMode:options('Match','Normal')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal','PDT','Refresh')
	state.Weapons:options('None','Godhands','PetWeapons')
	state.PetMode = M{['description']='Pet Mode', 'None','Melee','Ranged','HybridRanged','Bruiser','Tank','LightTank','Magic','Heal','Nuke'}
	state.AutoRepairMode = M(false, 'Auto Repair Mode')
	state.AutoDeployMode = M(true, 'Auto Deploy Mode')
	state.AutoPetMode 	 = M(false, 'Auto Pet Mode')
	state.PetWSGear		 = M(false, 'Pet WS Gear')
	state.PetEnmityGear	 = M(false, 'Pet Enmity Gear')
	
    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=1},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=0},
		},
		Bruiser = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Water Maneuver',   Amount=1},
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=0},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=3},
			{Name='Fire Maneuver',	  Amount=0},
			{Name='Light Maneuver',	  Amount=0},
			{Name='Thunder Maneuver', Amount=0},
		},
		HybridRanged = {
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		Tank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		LightTank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Nuke = {
			{Name='Ice Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
	}

	deactivatehpp = 85
	
    select_default_macro_book()
end

-- Define sets used by this job file.
function init_gear_sets()
        
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3",feet="Foire Babouches +1"} 
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

    sets.precast.JA.Maneuver = {back="Visucius's Mantle",hands="Foire Dastanas +1"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        main="Godhands",
        range="Em. Animator",
        ammo="Automat. Oil +3",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck={ name="Pup. Collar", augments={'Path: A',}},
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Petrov Ring",
        right_ring="Karieyh Ring",
        back="Visucius's Mantle",
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {body="Abnoba Kaftan"})
	
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {body="Abnoba Kaftan"})
	
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
	
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})

    -- Midcast Sets

    sets.midcast.FastRecast = {}
	
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {
        neck="Adad Amulet",
        ear1="Enmerkar Earring",
        ear2="Handler's Earring +1",
        body=gear.taeon_pet_body,
        hands="Regimen Mittens",
        ring1="Varar Ring +1",
        ring2="Varar Ring +1",
        waist="Incarnation Sash",
        legs="Tali'ah Sera. +2"
    }

    sets.midcast.Pet['Elemental Magic'] = {
        neck="Adad Amulet",
        ear1="Enmerkar Earring",
        ear2="Handler's Earring +1",
        body=gear.taeon_pet_body,
        hands="Regimen Mittens",
        ring1="Varar Ring +1",
        ring2="Varar Ring +1",
        waist="Incarnation Sash",
        legs="Tali'ah Sera. +2"
    }
	
	-- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
	-- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
	sets.midcast.Pet.PetEnmityGear = {}
	sets.midcast.Pet.PetWSGear = {
        head="Mpaca's Cap",
        neck="Shulmanu Collar",
        ear1="Enmerkar Earring",
        ear2="Domesticator's Earring",
        body=gear.taeon_pet_body,
        hands="Mpaca's Gloves",
        ring1="Varar Ring +1",
        ring2="C. Palug Ring",
        back="Visucius's Mantle",
        waist="Incarnation Sash",
        legs="Taeon Tights",
        feet="Mpaca's Boots"
    }
	
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Bruiser = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    
	-- Currently broken, preserved in case of future functionality.
	--sets.midcast.Pet.WeaponSkill = {}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets

    sets.idle = {
        range="Em. Animator",
        ammo="Automat. Oil +3",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck="Adad Amulet",
        waist="Carrier's Sash",
        left_ear="Eabani Earring",
        right_ear="Odnowa Earring",
        left_ring="Defending Ring",
        right_ring="Warden's Ring",
        back="Visucius's Mantle",
	}
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {
        head="Anwig Salade",
        neck="Loricate Torque +1",
        ear1="Enmerkar Earring",
        ear2="Handler's Earring +1",
        body=gear.taeon_pet_body,
        hands="Taeon Gloves",
        ring1="Defending Ring",
        ring2="Dark Ring",
        back="Moonlight Cape",
        waist="Isa Belt",
        legs="Tali'ah Sera. +2",
        feet="Taeon Boots"
    }

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        head="Anwig Salade",
        neck="Shulmanu Collar",
        ear1="Enmerkar Earring",
        ear2="Crepuscular Earring",
        body=gear.taeon_pet_body,
        hands="Taeon Gloves",
        ring1="Varar Ring +1",
        ring2="C. Palug Ring",
        back="Visucius's Mantle",
        waist="Incarnation Sash",
        legs="Taeon Tights",
        feet="Taeon Boots"
    }

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {waist="Isa Belt",ear2="Handler's Earring +1"})
	sets.idle.Pet.Engaged.Bruiser = set_combine(sets.idle.Pet.Engaged, {hands="Mpaca's Gloves",feet="Mpaca's Boots"})
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {waist="Isa Belt",ear2="Handler's Earring +1"})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        range="Em. Animator",
        ammo="Automat. Oil +3",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck={ name="Pup. Collar", augments={'Path: A',}},
        waist="Grunfeld Rope",
        left_ear="Sroda Earring",
        right_ear="Schere Earring",
        left_ring="Defending Ring",
        right_ring="Petrov Ring",
        back="Visucius's Mantle",
    }

    sets.engaged.DT = {
          range="Em. Animator",
        ammo="Automat. Oil +3",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck={ name="Pup. Collar", augments={'Path: A',}},
        waist="Grunfeld Rope",
        left_ear="Sroda Earring",
        right_ear="Schere Earring",
        left_ring="Defending Ring",
        right_ring="Petrov Ring",
        back="Visucius's Mantle",
    }

    sets.engaged.Pet = {
        range="Em. Animator",
        ammo="Automat. Oil +3",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck={ name="Pup. Collar", augments={'Path: A',}},
        waist="Grunfeld Rope",
        left_ear="Sroda Earring",
        right_ear="Schere Earring",
        left_ring="Defending Ring",
        right_ring="Petrov Ring",
        back="Visucius's Mantle",
    }
		
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands",range="Animator P +1",}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(2, 20)
end