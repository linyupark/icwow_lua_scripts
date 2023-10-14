-- 玩家协助战斗ai
print(">> Script: ic-assistant")

ICAssistant = {}

local FAIL_SOUND = 847
local HIRE_AURA = 62109 -- Tails Up: Aura 用一个特殊的光环来判断协助者是否已经被召唤
local ENTRY  = 669003
local WEAPONS = 22799
local SPELLS = {
    {name = 'frostbolt', rank = '1', entry = 837},
    {name = 'frostbolt', rank = '2', entry = 7322},
    {name = 'frostbolt', rank = '3', entry = 8407},
    {name = 'frostbolt', rank = '4', entry = 10179},
    {name = 'frostbolt', rank = '5', entry = 10181},
    {name = 'frostbolt', rank = '6', entry = 27072},
    {name = 'frostbolt', rank = '7', entry = 42841},
    {name = 'frostbolt', rank = '8', entry = 42842},

    {name = 'fireball', rank = '1', entry = 145},
    {name = 'fireball', rank = '2', entry = 8400},
    {name = 'fireball', rank = '3', entry = 8402},
    {name = 'fireball', rank = '4', entry = 10149},
    {name = 'fireball', rank = '5', entry = 10150},
    {name = 'fireball', rank = '6', entry = 27070},
    {name = 'fireball', rank = '7', entry = 42832},
    {name = 'fireball', rank = '8', entry = 42833},

    {name = 'shadowbolt', rank = '1', entry = 695},
    {name = 'shadowbolt', rank = '2', entry = 1106},
    {name = 'shadowbolt', rank = '3', entry = 7641},
    {name = 'shadowbolt', rank = '4', entry = 11659},
    {name = 'shadowbolt', rank = '5', entry = 11661},
    {name = 'shadowbolt', rank = '6', entry = 27209},
    {name = 'shadowbolt', rank = '7', entry = 47808},
    {name = 'shadowbolt', rank = '8', entry = 47809},

    {name = 'arcanemissiles', rank = '1', entry = 5143},
    {name = 'arcanemissiles', rank = '2', entry = 5145},
    {name = 'arcanemissiles', rank = '3', entry = 8417},
    {name = 'arcanemissiles', rank = '4', entry = 10211},
    {name = 'arcanemissiles', rank = '5', entry = 25345},
    {name = 'arcanemissiles', rank = '6', entry = 38699},
    {name = 'arcanemissiles', rank = '7', entry = 42843},
    {name = 'arcanemissiles', rank = '8', entry = 42846},

    {name = 'lightningbolt', rank = '1', entry = 548},
    {name = 'lightningbolt', rank = '2', entry = 943},
    {name = 'lightningbolt', rank = '3', entry = 10391},
    {name = 'lightningbolt', rank = '4', entry = 15207},
    {name = 'lightningbolt', rank = '5', entry = 15208},
    {name = 'lightningbolt', rank = '6', entry = 25449},
    {name = 'lightningbolt', rank = '7', entry = 49237},
    {name = 'lightningbolt', rank = '8', entry = 49238},

    {name = 'earthshield', rank = '1', entry = 974},
    {name = 'earthshield', rank = '2', entry = 974},
    {name = 'earthshield', rank = '3', entry = 974},
    {name = 'earthshield', rank = '4', entry = 974},
    {name = 'earthshield', rank = '5', entry = 32593},
    {name = 'earthshield', rank = '6', entry = 32594},
    {name = 'earthshield', rank = '7', entry = 49283},
    {name = 'earthshield', rank = '8', entry = 49284},

    {name = 'watershield', rank = '1', entry = 52127},
    {name = 'watershield', rank = '2', entry = 52129},
    {name = 'watershield', rank = '3', entry = 52131},
    {name = 'watershield', rank = '4', entry = 52136},
    {name = 'watershield', rank = '5', entry = 52138},
    {name = 'watershield', rank = '6', entry = 24398},
    {name = 'watershield', rank = '7', entry = 33736},
    {name = 'watershield', rank = '8', entry = 57960},

    {name = 'chainheal', rank = '1', entry = 1064},
    {name = 'chainheal', rank = '2', entry = 10622},
    {name = 'chainheal', rank = '3', entry = 10623},
    {name = 'chainheal', rank = '4', entry = 10623},
    {name = 'chainheal', rank = '5', entry = 25422},
    {name = 'chainheal', rank = '6', entry = 25423},
    {name = 'chainheal', rank = '7', entry = 55458},
    {name = 'chainheal', rank = '8', entry = 55459},

    {name = 'flashheal', rank = '1', entry = 2061},
    {name = 'flashheal', rank = '2', entry = 9472},
    {name = 'flashheal', rank = '3', entry = 9473},
    {name = 'flashheal', rank = '4', entry = 9474},
    {name = 'flashheal', rank = '5', entry = 10915},
    {name = 'flashheal', rank = '6', entry = 10916},
    {name = 'flashheal', rank = '7', entry = 10917},
    {name = 'flashheal', rank = '8', entry = 25233},
}
local ATK_SPELL = {
    'frostbolt',
    'fireball',
    'shadowbolt',
    'arcanemissiles',
    'lightningbolt',
}
local HEAL_SPELL = {
    'chainheal',
    'flashheal'
}
local HPPC = 50 -- 低于多少百分比开始加血治疗为主

local onPlayerSpellCastCancel = nil
local fighting = false

local function getRankedSpell(name, caster, stepdown)
    local rank = string.sub(caster:GetLevel(), 1, 1) - stepdown
    if rank < 1 then
        rank = 1
    end
    for i, v in ipairs(SPELLS) do
        if v.name==name and v.rank==tostring(rank) then
            return v.entry
        end
    end
end

local function getBaseStats(hireling)
    local entry = hireling:GetEntry()
    local class = hireling:GetClass()
    local level = hireling:GetLevel()
    local stats = {}
    local qryStats = WorldDBQuery("SELECT `basehp0`, `basemana`, `basearmor`, `attackpower`, `damage_base` FROM creature_classlevelstats WHERE `class` = "..class.." AND level = "..level..";")
    local qryNPC = WorldDBQuery("SELECT `damagemodifier`, `baseattacktime`, `basevariance`, `HealthModifier`, `ManaModifier` FROM creature_template WHERE `entry` = "..entry..";")
    if qryStats and qryNPC then
        stats['damageModifier'] = qryNPC:GetFloat(0)
        stats['baseAttackTime'] = qryNPC:GetInt32(1)
        stats['baseVariance'] = qryNPC:GetFloat(2)
        stats['HealthModifier'] = qryNPC:GetFloat(3)
        stats['ManaModifier'] = qryNPC:GetFloat(4)
        stats['health'] = qryStats:GetInt32(0)*stats['HealthModifier']
        stats['mana'] = qryStats:GetInt32(1)*stats['ManaModifier']
        stats['armor'] = qryStats:GetInt32(2)
        stats['attackPower'] = qryStats:GetInt32(3)
        stats['damageBase'] = qryStats:GetFloat(4)
        stats['minDamage'] = (((stats['damageBase'] + (stats['attackPower'] / 14) * stats['baseVariance']) * stats['damageModifier']) * (stats['baseAttackTime'] / 1000))
        stats['maxDamage'] = ((((stats['damageBase'] * 1.5) + (stats['attackPower'] / 14) * stats['baseVariance']) * stats['damageModifier']) * (stats['baseAttackTime'] / 1000))
    end
    return stats
end

local function initHireling(hireling, player)
    local hLevel = player:GetLevel()
    if hLevel > 80 then
        hLevel = 80
    end
    hireling:SetLevel(hLevel)
    hireling:SetFaction(35)
    local hStats = getBaseStats(hireling)
    hireling:SetMaxHealth(hStats['health'])
    hireling:SetHealth(hStats['health'])
    hireling:SetInt32Value(UNIT_FIELD_MAXPOWER1, hStats['mana']) -- Set max mana
    hireling:SetInt32Value(UNIT_FIELD_POWER1, hStats['mana']) -- Set current mana
    hireling:SetInt32Value(UNIT_FIELD_ATTACK_POWER, hStats['attackPower'])
    hireling:SetFloatValue(70, hStats['minDamage'])
    hireling:SetFloatValue(71, hStats['maxDamage'])
    hireling:SetFlag(79, 2) -- Set trackable on minimap
    hireling:MoveFollow(player, 1.2, 4) -- Distance,Orientation
    hireling:SetEquipmentSlots(WEAPONS, 0, 0)
    hireling:SetSheath(0)
end

local function dismissHireling(player)
    local aura = player:GetAura(HIRE_AURA)
    if aura then
        local hireling = aura:GetCaster()
        if hireling then
            hireling:DespawnOrUnsummon(0)
            -- player:RemoveAura(HIRE_AURA)
        -- else
        --     player:SendBroadcastMessage("Your hireling is too far away to be dismissed.")
        --     player:PlayDirectSound(FAIL_SOUND)
        end
        player:RemoveAura(HIRE_AURA)
        -- 解除战斗状态
        fighting = false
    -- else
    --     player:SendBroadcastMessage("You don't have a hireling.")
    end
end

local function spawnHirelingStats(entry, player)
    local aura = player:GetAura(HIRE_AURA)
    local hireling = nil
    if aura then
        hireling = aura:GetCaster()
        if hireling then
            return hireling
        end
    end
    hireling = PerformIngameSpawn(1, entry, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 4294967295, 1)
    hireling:SetCreatorGUID(player:GetGUID())
    hireling:SetOwnerGUID(player:GetGUID())
    initHireling(hireling, player)
    hireling:SendUnitSay("克赛, 前来拜访！！别怕～"..player:GetName()..".", 0)
    local aura = hireling:AddAura(HIRE_AURA, player)
    aura:SetMaxDuration(2147483647)
    aura:SetDuration(2147483647)
    return hireling
end

function ICAssistant.onPlayerDeath(event, killer, player)
    dismissHireling(player)
    player:RemoveAura(HIRE_AURA)
end

function ICAssistant.onPlayerSpellCast(event, player, playerSpell, _)
    local spell
    local hireling = fighting and spawnHirelingStats(ENTRY, player) or nil
    -- print("fighting"..tostring(fighting))
    -- 死了就不做处理了
    if hireling ~= nil and hireling:IsDead() then
        return
    end
    -- 观察血量
    local playerHpc = player:GetHealthPct()
    -- print("playerHpc: "..playerHpc)
    if playerHpc < HPPC then
        if fighting == false then
            hireling = spawnHirelingStats(ENTRY, player)
            fighting = true
        end
        -- 治疗
        -- spell = getRankedSpell("chainheal", hireling, 0)
        spell = getRankedSpell("flashheal", hireling, 0)
        -- print("chainheal spell: "..tostring(spell))
        if spell then
            hireling:CastSpell(player, spell, false)
        end
    elseif fighting then
        -- 协助杀怪
        if not hireling:IsCasting() then
            local spellIndex = math.random(0, 4)
            for i, name in pairs(ATK_SPELL) do
                if spellIndex == i then
                    -- print("准备释放攻击技能: "..name)
                    spell = getRankedSpell(name, hireling, 0)
                    local target = playerSpell:GetTarget()
                    local enemy
                    if target then
                        enemy = target:ToCreature()
                        -- print("攻击目标是: "..enemy:GetAIName())
                    end
                    if enemy and enemy:IsInCombat() then
                        hireling:CastSpell(enemy, spell, false)
                    end
                end
            end
        end
    end
end

function ICAssistant.onPlayerEnterCombat(event, player, enemy)
    -- 玩家进入战斗后开始观测
    fighting = false
    onPlayerSpellCastCancel = RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, ICAssistant.onPlayerSpellCast)
end

function ICAssistant.onPlayerLeaveCombat(event, player)
    if onPlayerSpellCastCancel ~= nil then
        onPlayerSpellCastCancel()
    end
    dismissHireling(player)
end

local function OnLogin(event, player)
    -- 战斗协助者 进来默认解散
    dismissHireling(player)
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_PLAYER, ICAssistant.onPlayerDeath)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILLED_BY_CREATURE, ICAssistant.onPlayerDeath)
RegisterPlayerEvent(PLAYER_EVENT_ON_ENTER_COMBAT, ICAssistant.onPlayerEnterCombat)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEAVE_COMBAT, ICAssistant.onPlayerLeaveCombat)