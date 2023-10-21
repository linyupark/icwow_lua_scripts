SET
@Entry 				:= 190099,
@Model1 			:= 25635,
@Name 				:= "随身商人",
@SubName			:= "小圆圆",
@IconName			:= "Buy",
@Faction			:= 35,
@Npcflag			:= 4995
;

DELETE FROM acore_world.creature_template WHERE entry = @Entry;
INSERT INTO acore_world.creature_template
	(`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`speed_swim`,`speed_flight`,`detection_range`,`scale`,`rank`,`dmgschool`,`DamageModifier`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`HoverHeight`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`ExperienceModifier`,`RacialLeader`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`spell_school_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`)
	-- VALUES (@Entry, 0, 0, 0, 0, 0, @Model1, 0, 0, 0, @Name, @SubName, @IconName, 0, 80, 80, 2, 35, 1, 1, 1.14286, 1, 1, 1, 1.00, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
	VALUES (@Entry, 0, 0, 0, 0, 0, @Model1, 0, 0, 0, @Name, @SubName, @IconName, 0, 80, 80, 0, @Faction, @Npcflag, 1, 1.14286, 1, 1, 1, 1.00, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
SELECT * FROM acore_world.creature_template WHERE entry = @Entry;

-- 14624,0,0,0,0,0,14652,0,0,0,Master Smith Burninate,The Thorium Brotherhood,,5962,52,52,0,1475,4995,1,1.14286,1,1,18,1,0,0,1,2000,2000,1,1,1,768,2048,0,0,0,0,0,0,7,134217728,0,0,0,0,0,0,0,,0,1,1.35,1,1,1,0,0,1,0,0,2,,12340