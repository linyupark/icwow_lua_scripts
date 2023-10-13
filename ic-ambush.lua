---------------------------------------------------------------------------------------------------
-- https://github.com/gabrilend/wow-chat/blob/main/ambush.lua

print(">> Script: ic-ambush")

Movement = {}

function Movement.getCircleSpawnPosition(originX, originY, minDist, maxDist)
    local theta = math.random(0, 6.28)
    local radius = math.random(minDist, maxDist)
    x = originX + math.cos(theta) * radius
    y = originY + math.sin(theta) * radius
    return x, y
end

function Movement.getBoxSpawnPosition(originX, originY, minDist, maxDist)
    randInt = math.random(1, 4)
    if randInt == 1 then
        x = originX + math.random( minDist,  maxDist)
        y = originY + math.random(-maxDist,  maxDist)
    elseif randInt == 2 then
        x = originX + math.random(-maxDist, -minDist)
        y = originY + math.random(-maxDist,  maxDist)
    elseif randInt == 3 then
        x = originX + math.random(-maxDist,  maxDist)
        y = originY + math.random( minDist,  maxDist)
    elseif randInt == 4 then
        x = originX + math.random(-maxDist,  maxDist)
        y = originY + math.random(-maxDist, -minDist)
    end

    return x, y
end

-- this should make a rough circle around the player
-- it's more like a plus shape but that's close enough
function Movement.getPlusSpawnPosition(originX, originY, minDist, maxDist)
    randInt = math.random(1, 4)
    if randInt == 1 then
        x = originX + math.random( minDist,  maxDist)
        y = originY + math.random(-minDist,  minDist)
    elseif randInt == 2 then
        x = originX + math.random(-maxDist, -minDist)
        y = originY + math.random(-minDist,  minDist)
    elseif randInt == 3 then
        x = originX + math.random(-minDist,  minDist)
        y = originY + math.random( minDist,  maxDist)
    elseif randInt == 4 then
        x = originX + math.random(-minDist,  minDist)
        y = originY + math.random(-maxDist, -minDist)
    end

    return x, y
end

function Movement.getLazyDistance(x1, y1, x2, y2)
    local dist = math.abs(x1 - x2) + math.abs(y1 - y2)
    local dx = math.abs(x1 - x2)
    local dy = math.abs(y1 - y2)
    return dist, dx, dy
end

function Movement.getInitialAngle(originX, originY, monsterX, monsterY)
    -- Calculate the difference in x and y coordinates
    local dx = monsterX - originX
    local dy = monsterY - originY

    -- Use atan2 to get the angle in radians
    local angle = math.atan2(dy, dx)

    return angle
end

function Movement.getOrbitPosition(originX, originY, radius, speed, dt, initialAngle)
    -- Calculate the angular speed based on the monster's linear speed and the radius of the circle
    local angular_speed = speed / radius

    -- Compute the new angle after dt seconds
    local new_angle = initialAngle + angular_speed * dt

    -- Calculate the new position
    local x = originX + math.cos(new_angle) * radius
    local y = originY + math.sin(new_angle) * radius

    return x, y
end

-- calculates a position on the exact opposite side of the given position
-- x1 and y1 are the pivot point
-- x2 and y2 are the initial point
-- diagram:
-- (initialX, initialY) ---------> (pivotX, pivotY) ---------> (x, y)
function Movement.getPositionOppositePoint(initialX, initialY, pivotX, pivotY)
    x = initialX + ((pivotX - initialX) * 2)
    y = initialY + ((pivotY - initialY) * 2)

    return x, y
end

function Movement.getMidpoint(x1, y1, x2, y2)
    x = (x1 + x2) / 2
    y = (y1 + y2) / 2

    return x, y
end

-- function to calculate the squared distance between two points
function Movement.squaredDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return dx * dx + dy * dy
end

-- function to normalize a vector
function Movement.normalize(dx, dy)
    local length = math.sqrt(dx * dx + dy * dy)
    return dx / length, dy / length
end

-- function to find the closest point on the circle to the given point
function Movement.nearestPointOnCircle(circleX, circleY, circleRadius, pointX, pointY)
    -- calculate the direction vector from the circle center to the point
    local dx, dy = pointX - circleX, pointY - circleY

    -- normalize the direction vector
    dx, dy = normalize(dx, dy)

    -- scale the direction vector by the radius of the circle
    dx, dy = dx * circleRadius, dy * circleRadius

    -- calculate the coordinates of the nearest point on the circle
    local nearestX, nearestY = circleX + dx, circleY + dy

    return nearestX, nearestY
end

function Movement.isCloseEnough(x1, y1, x2, y2, dist)
    return Movement.squaredDistance(x1, y1, x2, y2) <= dist * dist
end

Ambush = {} -- table to hold the functions.
-- local AmbushQueues = {} -- table to hold monsters that are queued to attack.

-- -- 纪录已经刷出且没有死亡的生物，要是玩家死亡需要手动清除这些生物
-- Ambush.SpawnedCreatures = {}

-- 纪录战斗回合（只有战斗胜利才加1）
Ambush.BattleRounds = 0

-- 战斗回合胜利奖励(按顺序)
Ambush.BattleRoundsReward = {}

-- add more when you find them
-- 7074 and 7073 are maybes, try fighting them and see if they're too hard
-- 11141 on thin ice
Ambush.BANNED_CREATURE_IDS = { 17887, 19416, 2673,  3569,  16422, 16423, -- {{{
                               16437, 16438, 17206, 1946,  5893,  4789,
                               5894,  7050,  7067,  7310,  7849,  5723,
                               11876, 17207, 2794,  11560, 11195, 13736,
                               7767,  6388,  14638, 14639, 14603, 14604,
                               14640, 8608,  1800,  1801,  4476,  22408,
                               13022, 13279, 7149,  10940, 10943, 14467,
                               28654, 28768, 10387, 10836, 11076, 18978,
                               10479, 10482, 11078, 19136, 14385, 16141,
                               16298, 16299, 16043, 20145, 20496, 22461,
                               16992, 17399, 17477, 19016, 16939, 20680,
                               21040, 20498, 20918, 21233, 21817, 21820,
                               21821, 19493, 19494, 19757, 19760, 19966,
                               19971, 20480, 20927, 20983, 22025, 25296,
                               19759, 21778, 21779, 25382, 26224, 18605,
                               18606, 19967, 20310, 20311, 20312, 20313,
                               20320, 20321, 20323, 20643, 20655, 21531,
                               21552, 21554, 21555, 21646, 21916, 22009,
                               22201, 22202, 22286, 22289, 23100, 23386,
                               24564, 24597, 24598, 24599, 24600, 24602,
                               24603, 24604, 24621, 24622, 24623, 24624,
                               24625, 24626, 24627, 25766, 30763, 30773,
                               18614, 20309, 20322, 20784, 20789, 22221,
                               22327, 22392, 24029, 24790, 26045, 26225,
                               27513, 25678, 25682, 26490, 26517, 26573,
                               26966, 25712, 25716, 26232, 26518, 26526,
                               26702, 26703, 26811, 26812, 27614, 27821,
                               29117, 29118, 26872, 28750, 28006, 28170,
                               28669, 28320, 28875, 28752, 30633, 26536,
                               30053, 30432, 31812, 33499, 29775, 30055,
                               30791, 30843, 30902, 30921, 30957, 30958,
                               30960, 31042, 31141, 31274, 31321, 31325,
                               31326, 31327, 31468, 31554, 31555, 31671,
                               31681, 31692, 31798, 32161, 32767, 32769,
                               33289
                             } -- }}}

Ambush.BANNED_RARE_IDS = { 0, -- {{{
                         } -- }}}

---------------------------------------------------------------------------------------------------

function Ambush.spawnAndAttackPlayer(_eventID, _delay, _repeats, player) -- {{{
    local next = next
    if next(player:GetData("Ambush.queue") or {}) == nil then
        if next(player:GetData("Ambush.rare-queue") or {}) == nil then
            if player:IsInGroup() then
                -- 组队的情况（精英为主）
                if player:GetGroup():GetMembersCount() > 2 then
                    -- 组队中就刷稀有精英（ > 2人）
                    print("Ambush.setupAmbushQueue(2=rare elite) when group member > 2")
                    Ambush.setupAmbushQueue(player, math.random(2, 4))
                else
                    -- 一般精英（2人）
                    print("Ambush.setupAmbushQueue(4=rare) when group member == 2")
                    Ambush.setupAmbushQueue(player, 1)
                end
                -- 新生成的精英怪，开刷
                Ambush.randomSpawn(player, true)
            else
                -- 单刷，普通为主，19%概率给精英
                local rate = math.random(0, 10)
                if (rate > 8) then
                    Ambush.setupAmbushQueue(player, 1)
                    Ambush.randomSpawn(player, true)
                else
                    Ambush.setupAmbushQueue(player, 0)
                    Ambush.randomSpawn(player, false)
                end
            end
        else
            -- 有精英怪队列，开刷
            Ambush.randomSpawn(player, true)
        end
    else
        -- 普通怪有队列，开刷
        Ambush.randomSpawn(player, false)
    end
end -- }}}

---------------------------------------------------------------------------------------------------

-- 改成非异步查询
function Ambush.setupAmbushQueue(player, rank) -- {{{
    local playerLevel = player:GetLevel()
    local LEVEL_RANGE = 0
    
    if playerLevel >= 10 then
        LEVEL_RANGE = math.random(math.floor(playerLevel) / 5, math.floor(playerLevel / 3))
    end
    
    local query = WorldDBQuery([[
        SELECT `entry`, `minlevel`, `maxlevel`, `rank` 
        FROM creature_template 
        WHERE `minlevel` >= ]] .. playerLevel - LEVEL_RANGE .. [[ 
        AND `maxlevel` <= ]] .. playerLevel + 1 .. [[ 
        AND `rank` = ]] .. rank .. [[ 
        AND `npcflag` = 0 
        AND `lootid` != 0 
        AND `type` IN (2, 3, 4, 5, 6, 9, 10) 
        ORDER BY RAND() 
        LIMIT 50;
    ]])

    Ambush.pushToAmbushQueue(query, player)
end -- }}}

-- this function builds an Ambush queue based on the results of the sql query
function Ambush.pushToAmbushQueue(query, player) -- {{{
    local isRare = false
    local MaxQueueSize = 10
    local playerLevel = player:GetLevel()

    if playerLevel == 0 then
        print("Ambush.pushToAmbushQueue player level == 0 终止")
        return
    end

    local creatures = {}
    if query then
        if query:GetUInt32(3) ~= 0 then
            isRare = true
        else 
            isRare = false
        end
        repeat
            local creature = {
                id       = query:GetUInt32(0),
                minLevel = query:GetUInt32(1),
                maxLevel = query:GetUInt32(2),
            }
            if not Ambush.isCreatureBanned(creature.id, isRare) then
                table.insert(creatures, creature)
            end
        until not query:NextRow()
    else
        print("Ambush.pushToAmbushQueue 没有找到合适的生物")
        return
    end

    if #creatures > MaxQueueSize then
        print("找到匹配生物数: "..#creatures.."|缩编到数量: "..MaxQueueSize)
        local tempTable = {}
        local creature
        for i = 1, MaxQueueSize do
            creature = table.remove(creatures, math.random(#creatures))
            table.insert(tempTable, creature)
        end
        creatures = tempTable
    end

    for _, creature in ipairs(creatures) do
        if playerLevel >= creature.minLevel then
            if isRare then
                tempTable = player:GetData("Ambush.rare-queue") or {}
                table.insert(tempTable, creature.id)
                player:SetData("Ambush.rare-queue", tempTable)
            else
                tempTable = player:GetData("Ambush.queue") or {}
                table.insert(tempTable, creature.id)
                player:SetData("Ambush.queue", tempTable)
            end
        end
    end
end -- }}}

-- slower than regenerating the queue all at once
function Ambush.addCreatureToQueue(player, creatureId, minLevel, maxLevel, isRare) -- {{{
    local queueType
    if isRare then queueType = "Ambush.rare-queue"
              else queueType = "Ambush.queue"
    end
    local creature = { id       = creatureId,
                       minLevel = minLevel,
                       maxLevel = maxLevel,
                     }
    local tempTable = {}
    tempTable[1] = creature
    for k, v in player:GetData(queueType) do
        tempTable[k + 1] = v
    end
    player:SetData(queueType, tempTable)

end -- }}}

---------------------------------------------------------------------------------------------------

-- make sure this function is in the async callback function... it might take
-- a while depending on how many banned creatures there are.
function Ambush.isCreatureBanned(creatureId, isRare) -- {{{

    if isRare then
        for _, id in ipairs(Ambush.BANNED_RARE_IDS) do
            if creatureId == id then return true end end

    else -- if not rare
    for _, id in ipairs(Ambush.BANNED_CREATURE_IDS) do
        if creatureId == id then return true end end
    end
    return false -- if not banned
end -- }}}

---------------------------------------------------------------------------------------------------

function Ambush.randomSpawn(player, isRare) -- {{{
    local ambush_min_distance = 60
    local ambush_max_distance = 75
    local queueType
    local corpseDespawnType
    local corpseDespawnTimer

    if isRare then
        queueType = "Ambush.rare-queue"
        -- corpseDespawnType  = 8
        corpseDespawnType = 4 -- despawns after a specified time after the creature is out of combat
        corpseDespawnTimer = 60 * 1000 * 5
    else
        queueType = "Ambush.queue"
        -- corpseDespawnType  = 6
        corpseDespawnType = 4 -- despawns after a specified time after the creature is out of combat
        corpseDespawnTimer = 60 * 1000 -- 60 seconds
    end

    local  playerID   = player:GetGUID()
    local playerQueue = player:GetData(queueType) or {}
    if #playerQueue == 0 then
        return
    end
    local   randInt   = math.random(1, #playerQueue)
    local creatureId  = table.remove(playerQueue, randInt)
    player:SetData(queueType, playerQueue)

    -- icwow 通过生物id获取中文名
    local row = WorldDBQuery("SELECT `Name` FROM creature_template_locale WHERE `entry` = ".. creatureId .." AND `locale` = 'zhCN' LIMIT 1;")

    if isRare then
        player:SendBroadcastMessage("这次的敌人不简单，它是：" .. row:GetString(0) .. "!")
    else
        player:SendBroadcastMessage("来了，伏击者是：" .. row:GetString(0) .. "!")
    end

    if creatureId ~= 0 then
        local x, y, z, o = player:GetLocation()
              x, y       = Movement.getPlusSpawnPosition(x, y, ambush_min_distance, ambush_max_distance)
                    z    = player:GetMap():GetHeight(x, y)
                       o = math.random(0, 6.28)

        -- 刷怪了
        local creature = player:SpawnCreature(creatureId, x, y, z, o,
                                              corpseDespawnType,
                                              corpseDespawnTimer)
        if creature then
            -- check and make sure the creature did not spawn in the water
            -- if it did, then try 3 times to find a new spawn location.
            -- if one cannot be found, then just give up and despawn the creature
            -- is-in-water check {{{
            local tries = 0
            while creature:IsInWater() and tries < 3 do
                tries = tries + 1
                x, y = Movement.getPlusSpawnPosition(x, y, ambush_min_distance, ambush_max_distance)
                z    = player:GetMap():GetHeight(x, y)
                creature:NearTeleport(x, y, z, o)
            end
            if tries == 3 then
                creature:DespawnOrUnsummon(0)
                return
            end
            --- }}}

            creature:SetData("Ambush.chase-target", playerID)
            creature:SetData("Ambush.max-distance", ambush_max_distance)
            if isRare then 
                player:SetData("Ambush.is-in-boss-fight", true)
            end 
            
            creature:RegisterEvent(Ambush.chasePlayer, 1000, 1)
        end
    end
end -- }}}

---------------------------------------------------------------------------------------------------

function Ambush.chasePlayer(_eventID, _delay, _repeats, creature) -- {{{
    if creature:IsDead() then
        return
    end
                                      -- DISTNACE FROM THE MIDPOINT BETWEEN THE PLAYER AND THE
                                      -- CREATURE
    local     CREATURE_MAX_DISTANCE    = creature:GetData("Ambush.max-distance") or 60
    local         WANDER_RADIUS        = creature:GetData("Ambush.wander-radius") or 30
    local     WANDER_ROTATION_DELAY    = 2000 -------- time between each new waypoint on the circle
    local            playerID          = creature:GetData("Ambush.chase-target") -- required
    local            player            = GetPlayerByGUID(playerID)
    local            playerX,
                     playerY           = player:GetLocation()
    local           creatureX,
                    creatureY,
                    creatureZ,
                    creatureO          = creature:GetLocation()
    

    if player:IsDead() or not player:IsStandState() then -- {{{
        print("orbiting")
        creature:MoveClear()
        creature:SetHomePosition(creatureX, creatureY, creatureZ, creatureO)
        local angle = Movement.getInitialAngle(playerX, playerY, creatureX, creatureY)
        local x, y  = Movement.getOrbitPosition( playerX, playerY,
                                                 WANDER_RADIUS,
                                                 creature:GetSpeed(1),
                                                 WANDER_ROTATION_DELAY,
                                                 angle
                                               )
        creature:MoveTo(math.random(0, 4294967295), x, y, creature:GetMap():GetHeight(x, y))
        creature:RegisterEvent(Ambush.chasePlayer, WANDER_ROTATION_DELAY, 1)
        return
    end -- }}}

    if Movement.isCloseEnough(creatureX, creatureY, playerX, playerY, 5) then
        -- 开打
        player:SetData("Ambush.num-ambushers", (player:GetData("Ambush.num-ambushers") or 0) + 1)
        print(player:GetName().."剩余敌人数: "..player:GetData("Ambush.num-ambushers"))
        creature:SetHomePosition(creatureX, creatureY, creatureZ, creatureO)
        creature:AttackStart(player)
    else
        -- 距离不够打架
        local targetX, targetY = Movement.getMidpoint(
            creature:GetX(),
            creature:GetY(),
            playerX,
            playerY
        )
        if player:GetMapId() ~= creature:GetMapId() then
            player:SendBroadcastMessage("伏击者被送到了另外一个平行宇宙...")
            Ambush.addCreatureToQueue(player, creature:GetEntry(), creature:GetLevel(), creature:GetLevel(), false) -- setting isRare to false because it doesn't matter which queue the creature spawns in
            creature:DespawnOrUnsummon(0)
            -- player:SetData("Ambush.num-ambushers", (player:GetData("Ambush.num-ambushers") or 1) - 1)
            return
        end -- }}}
        if Movement.getLazyDistance(creatureX, creatureY, targetX, targetY) > CREATURE_MAX_DISTANCE then
            player:SendBroadcastMessage("伏击者迷路了...")
            -- print(Movement.getLazyDistance(creatureX, creatureY, targetX, targetY) .." yards is too far away, despawning")
            creature:DespawnOrUnsummon(0)
            -- player:SetData("Ambush.num-ambushers", (player:GetData("Ambush.num-ambushers") or 1) - 1)
            return
        end
        -- 尝试接近玩家
        local targetZ = creature:GetMap():GetHeight(targetX, targetY)
        creature:MoveTo(math.random(0, 4294967295), targetX, targetY, targetZ)
        creature:RegisterEvent(Ambush.chasePlayer, 1000, 1)
    end
end -- }}}

function Ambush.onCreatureDeath(event, killer, creature) -- {{{
    local owning_player_ID = creature:GetData("Ambush.chase-target") or nil
    if owning_player_ID then
        local player = GetPlayerByGUID(owning_player_ID)
        if player then
            if player:GetData("Ambush.is-in-boss-fight") then
                -- print("player no longer in a boss fight")
                player:SetData("Ambush.is-in-boss-fight", false)
            end
            local ambushersNum = player:GetData("Ambush.num-ambushers") or 1
            if ambushersNum > 0 then
                player:SetData("Ambush.num-ambushers", ambushersNum - 1)
            end
            print(player:GetName().."剩余敌人数: "..ambushersNum)
            Ambush.BattleRounds = Ambush.BattleRounds + 1
            player:SendBroadcastMessage("哎哟不错哦，击杀 " .. Ambush.BattleRounds .. " 轮!")
        end
    end
end -- }}}

---------------------------------------------------------------------------------------------------

Ambush.LoopFightCancel = nil

function Ambush.onFinishReward(player)
    local playerLevel = player:GetLevel()

    -- 停止放怪事件轮播
    if Ambush.LoopFightCancel ~= nil then
        player:RemoveEventById(Ambush.LoopFightCancel)
    end
    Ambush.LoopFightCancel = nil

    -- 结束提示
    player:SendBroadcastMessage("伏击结束...一共击杀 "..Ambush.BattleRounds.." 轮!")
    player:SendAreaTriggerMessage("伏击系统状态自动切换为 (off: 关闭)")

    -- 奖励结算
    if Ambush.BattleRounds > 0 then

        -- 经验奖励 等级*等级*轮次
        local giveXP = playerLevel * playerLevel * Ambush.BattleRounds
        player:GiveXP(giveXP)
        player:SendBroadcastMessage("经验奖励: "..giveXP.." xp!")

        -- 物品奖励（可堆叠的随机）
        -- - 0: 灰色 (Poor) - 普通物品，通常没有实用价值。 
        -- - 1: 白色 (Common) - 普通物品，通常没有特殊属性或效果。 
        -- - 2: 绿色 (Uncommon) - 较为罕见的物品，通常具有一些额外属性或效果。 
        -- - 3: 蓝色 (Rare) - 稀有物品，通常具有较高的属性或效果。 
        -- - 4: 紫色 (Epic) - 史诗物品，通常具有非常强大的属性或效果。 
        -- - 5: 橙色 (Legendary) - 传奇物品，通常是游戏中最稀有和强大的物品。 
        -- - 6: 粉色 (Artifact) - 神器物品，通常是游戏中最珍贵和具有传奇故事的物品。 
        -- - 7: 金色 (Heirloom) - 传家宝物品，可以通过角色间继承。 
        -- - 8: 灰色 (WoW Token) - 代表游戏内交易的代币。 
        local rewardItemQ = WorldDBQuery([[
            SELECT `entry`, `name` FROM azcore.item_template 
            WHERE `Quality` > 1 AND `Quality` < 5  
                AND `ItemLevel` <= ]]..(playerLevel + 3)..[[ 
                AND `ItemLevel` >= ]]..(playerLevel - 3)..[[     
                AND `stackable` = 20 
            ORDER BY RAND() ASC 
            LIMIT ]]..Ambush.BattleRounds..[[;
        ]])
        if rewardItemQ then
            repeat
                local item = {
                    entry = rewardItemQ:GetUInt32(0),
                    name = rewardItemQ:GetString(1),
                }
                player.addItem(item.entry)
                player:SendBroadcastMessage("物品奖励: "..item.name.." !")
            until not rewardItemQ:NextRow()
        end
        -- 装备奖励(击杀超过10轮)
        if Ambush.BattleRounds >= 10 then
            local rewardEquipQ = WorldDBQuery([[
                SELECT `entry`, `name` FROM azcore.item_template 
                WHERE `Quality` > 1 AND `Quality` < 5 
                    AND `ItemLevel` <= ]]..(playerLevel + 3)..[[ 
                    AND `ItemLevel` >= ]]..(playerLevel - 3)..[[     
                    AND (`class` = 2 OR `class` = 4)
                ORDER BY RAND() ASC 
                LIMIT 1;
            ]])
            if rewardEquipQ then
                repeat
                    local equip = {
                        entry = rewardEquipQ:GetUInt32(0),
                        name = rewardEquipQ:GetString(1),
                    }
                    player.addItem(equip.entry)
                    player:SendBroadcastMessage("装备奖励: "..equip.name.." !")
                until not rewardEquipQ:NextRow()
            end
        end
    end
    -- 奖励结束

    -- 初始化系统
    Ambush.setupPlayer(nil, player)
end

function Ambush.onStartFight(_eventid, _delay, _repeats, player)

    -- 关闭开关
    if (player:GetData("Ambush.state") or "off") == "off" then
        Ambush.onFinishReward(player)
        return
    end

    if player:IsDead() then
        player:SendBroadcastMessage("死人还逞强...以后再来吧...")
        Ambush.onFinishReward(player)
        return
    end
    if not player:IsStandState() then
        player:SendBroadcastMessage("你坐着准备挨打么??请站起来...")
        return
    end
    if player:IsInWater() then
        player:SendBroadcastMessage("伏击者都是旱鸭子...我们上岸开战...")
        return
    end
    if player:GetData("Ambush.is-in-boss-fight") or (player:GetData("Ambush.num-ambushers") or 0) >= 2 then
        player:SendBroadcastMessage("伏击者表示我们不欺负人...先等你会儿...")
        return
    end
    
    Ambush.spawnAndAttackPlayer(nil, nil, nil, player)
end

function Ambush.LoopFight(delay, player)
    player:SendBroadcastMessage("伏击者们正在向你袭来...请做好迎战准备...")
    player:SetData("Ambush.state", "on")
    
    -- 延迟冲击
    Ambush.LoopFightCancel = player:RegisterEvent(Ambush.onStartFight, delay, 0)
    -- 先立马冲一波
    Ambush.onStartFight(nil, nil, nil, player)
end

---------------------------------------------------------------------------------------------------

function Ambush.setupPlayer(event, player)
    player:SetData("Ambush.queue", {})
    player:SetData("Ambush.rare-queue", {})
    player:SetData("Ambush.num-ambushers", 0)
    player:SetData("Ambush.state", "off")
    Ambush.BattleRounds = 0
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN,  Ambush.setupPlayer)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_CREATURE, Ambush.onCreatureDeath, 0)

---------------------------------------------------------------------------------------------------