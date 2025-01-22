--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--
--	Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
--
--	Editing this file will cause you to be unable to use Github Desktop to update!
--
--	Any changes you wish to make in this file you should be able to make by overloading. That is Re-Defining the same variables or functions in another file, by copying and
--	pasting them to a file that is loaded after the original file, all of my library files, and then job files are loaded first.
--	The last files to load are the ones unique to you. User-Globals, Charactername-Globals, Charactername_Job_Gear, in that order, so these changes will take precedence.
--
--	You may wish to "hook" into existing functions, to add functionality without losing access to updates or fixes I make, for example, instead of copying and editing
--	status_change(), you can instead use the function user_status_change() in the same manner, which is called by status_change() if it exists, most of the important 
--  gearswap functions work like this in my files, and if it's unique to a specific job, user_job_status_change() would be appropriate instead.
--
--  Variables and tables can be easily redefined just by defining them in one of the later loaded files: autofood = 'Miso Ramen' for example.
--  States can be redefined as well: state.HybridMode:options('Normal','PDT') though most of these are already redefined in the gear files for editing there.
--	Commands can be added easily with: user_self_command(commandArgs, eventArgs) or user_job_self_command(commandArgs, eventArgs)
--
--	If you're not sure where is appropriate to copy and paste variables, tables and functions to make changes or add them:
--		User-Globals.lua - 			This file loads with all characters, all jobs, so it's ideal for settings and rules you want to be the same no matter what.
--		Charactername-Globals.lua -	This file loads with one character, all jobs, so it's ideal for gear settings that are usable on all jobs, but unique to this character.
--		Charactername_Job_Gear.lua-	This file loads only on one character, one job, so it's ideal for things that are specific only to that job and character.
--
--
--	If you still need help, feel free to contact me on discord or ask in my chat for help: https://discord.gg/ug6xtvQ
--  !Please do NOT message me in game about anything third party related, though you're welcome to message me there and ask me to talk on another medium.
--
--  Please do not edit this file!							Please do not edit this file!							Please do not edit this file!
-- __________.__                                ________                          __               .__.__  __      __  .__    .__           _____.__.__              
-- \______   |  |   ____ _____    ______ ____   \______ \   ____     ____   _____/  |_    ____   __| _|___/  |_  _/  |_|  |__ |__| ______ _/ ____|__|  |   ____      
--  |     ___|  | _/ __ \\__  \  /  ____/ __ \   |    |  \ /  _ \   /    \ /  _ \   __\ _/ __ \ / __ ||  \   __\ \   __|  |  \|  |/  ___/ \   __\|  |  | _/ __ \     
--  |    |   |  |_\  ___/ / __ \_\___ \\  ___/   |    `   (  <_> ) |   |  (  <_> |  |   \  ___// /_/ ||  ||  |    |  | |   Y  |  |\___ \   |  |  |  |  |_\  ___/     
--  |____|   |____/\___  (____  /____  >\___  > /_______  /\____/  |___|  /\____/|__|    \___  \____ ||__||__|    |__| |___|  |__/____  >  |__|  |__|____/\___  > /\ 
--                     \/     \/     \/     \/          \/              \/                   \/     \/                      \/        \/                      \/  \/ 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
	state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
	state.Stance = M{['description']='Stance','Hasso','Seigan','None'}

	autows = 'Tachi: Fudo'
	rangedautows = "Apex Arrow"
	autofood = 'Soy Ramen'

	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode",},{"AutoBuffMode","AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' and state.AutoBuffMode.value ~= 'Off' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if player.tp > 1850 and abil_recasts[140] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Sekkanoki" <me>')
			windower.chat.input:schedule(1.1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			add_tick_delay(1.1)
			return
		elseif abil_recasts[134] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Meditate" <me>')
			windower.chat.input:schedule(1.1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			add_tick_delay(1.1)
			return
		elseif player.tp < 1500 and not buffactive['Sekkanoki'] and abil_recasts[54] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Hagakure" <me>')
			windower.chat.input:schedule(1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			add_tick_delay(1.1)
			return
		end
	end

end

function job_filtered_action(spell, eventArgs)
	if spell.type == 'WeaponSkill' then
		local available_ws = S(windower.ffxi.get_abilities().weapon_skills)
		-- WS 112 is Double Thrust, meaning a Spear is equipped.
		if available_ws:contains(112) then
            if spell.english == "Tachi: Fudo" then
				windower.chat.input('/ws "Stardiver" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Tachi: Shoha" then
                send_command('@input /ws "Impulse Drive" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Tachi: Rana" then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Tachi: Gekko" then
                send_command('@input /ws "Sonic Thrust" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Tachi: Hobaku" then
                send_command('@input /ws "Leg Sweep" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end
        end
	end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then

		local WSset = standardize_set(get_precast_set(spell, spellMap))
		local wsacc = check_ws_acc()
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if get_effective_player_tp(spell, WSset) > 3200 then
				if spell.skill == 25 then
					if wsacc:contains('Acc') and sets.RangedAccMaxTP then
						equip(sets.RangedAccMaxTP)
					elseif sets.RangedMaxTP then
						equip(sets.RangedMaxTP)
					else
					end
				else
					if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
						local AccMaxTPset = standardize_set(sets.AccMaxTP)

						if (AccMaxTPset.ear1:startswith("Lugra Earring") or AccMaxTPset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayMaxTPWSEars then
							equip(sets.AccDayMaxTPWSEars[spell.english] or sets.AccDayMaxTPWSEars)
						else
							equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
						end
					elseif sets.MaxTP then
						local MaxTPset = standardize_set(sets.MaxTP)
						if (MaxTPset.ear1:startswith("Lugra Earring") or MaxTPset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayMaxTPWSEars then
							equip(sets.DayMaxTPWSEars[spell.english] or sets.DayMaxTPWSEars)
						else
							equip(sets.MaxTP[spell.english] or sets.MaxTP)
						end
					else
					end
				end
			else
				if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
					equip(sets.AccDayWSEars[spell.english] or sets.AccDayWSEars)
				elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
					equip(sets.DayWSEars[spell.english] or sets.DayWSEars)
				end
			end
		elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn then
			if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccDayWSEars then
				equip(sets.AccDayWSEars[spell.english] or sets.AccDayWSEars)
			elseif sets.DayWSEars then
				equip(sets.DayWSEars[spell.english] or sets.DayWSEars)
			end
		end
		
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end

	end

end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.Buff.Hasso and state.DefenseMode.value == 'None' and state.OffenseMode.value ~= 'FullAcc' then
		meleeSet = set_combine(meleeSet, sets.buff.Hasso)
	elseif state.Buff.Seigan and state.Buff['Third Eye'] and not state.OffenseMode.value:contains('Acc') then
		meleeSet = set_combine(meleeSet, sets.buff['Third Eye'])
    end

    return meleeSet
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise'  or
	(state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'PDTReraise') or
    (state.DefenseMode.value == 'Magical' and state.MagicalDefenseMode.value == 'MDTReraise') then
        equip(sets.Reraise)
    end
end

function job_aftercast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if player.tp < 750 and state.Buff['Meikyo Shisui'] then
			send_command('cancel Meikyo Shisui')
		end
    elseif spell.english == "Meikyo Shisui" and not spell.interrupted and sets.buff['Meikyo Shisui'] then
		equip(sets.buff['Meikyo Shisui'])
		disable('feet')
	end
end

function job_self_command(commandArgs, eventArgs)

end

function job_tick()
	if check_hasso() then return true end
	if job_check_buff() then return true end
	return false
end

function job_buff_change(buff, gain)
    if buff == 'Meikyo Shisui' and not gain then
		enable('feet')
    end

	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_melee_groups()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	
    if data.areas.adoulin:contains(world.area) and buffactive.Ionis then
		classes.CustomMeleeGroups:append('Adoulin')
    end

	if player.equipment.main then
		if player.equipment.main == "Kogarasumaru" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

function check_hasso()
 	if player.status == 'Engaged' and wielding() == 'Two-Handed' and state.Stance.value =~ 'None' and not (state.Buff.Hasso or state.Buff.Seigan or state.Buff['SJ Restriction'] or silent_check_amnesia()) then

		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if state.Stance.value == 'Hasso' and abil_recasts[138] < latency then
			windower.chat.input('/ja "Hasso" <me>')
			add_tick_delay()
			return true
		elseif state.Stance.value == 'Seigan' and abil_recasts[139] < latency then
			windower.chat.input('/ja "Seigan" <me>')
			add_tick_delay()
			return true
		else
			return false
		end
	end

	return false
end

function job_check_buff()
	if state.AutoBuffMode.value ~= 'Off' and in_combat and not state.Buff['SJ Restriction'] then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if player.sub_job == 'DRK' and not buffactive['Last Resort'] and abil_recasts[87] < latency then
			windower.chat.input('/ja "Last Resort" <me>')
			add_tick_delay()
			return true
		elseif player.sub_job == 'WAR' and not buffactive.Berserk and abil_recasts[1] < latency then
			windower.chat.input('/ja "Berserk" <me>')
			add_tick_delay()
			return true
		elseif player.sub_job == 'WAR' and not buffactive.Aggressor and abil_recasts[4] < latency then
			windower.chat.input('/ja "Aggressor" <me>')
			add_tick_delay()
			return true
		else
			return false
		end
	end
		
	return false
end