print(">> Script: ic-stone")

ICStone = {}

-- 触发物品
ICStone.entry = 6948

-- 功能集合
ICStone.func = {
    -- 回家
    goHome = function(player)
        player:CastSpell(player, 8690, true)
        player:ResetSpellCooldown(8690, true)
        -- player:SendBroadcastMessage("已经回到家")
    end,
    -- 设置当前位置为家
    setHome = function(player)
        local x, y, z, mapId, areaId = player:GetX(), player:GetY(), player:GetZ(), player:GetMapId(),
            player:GetAreaId()
        player:SetBindPoint(x, y, z, mapId, areaId)
        player:SendBroadcastMessage("已将当前位置设为家")
    end,
    -- 打开银行
    openBank = function(player)
        player:SendShowBank(player)
    end,
    -- 移除复活虚弱
    weakOut = function(player)
        if player:HasAura(15007) then
            player:RemoveAura(15007) -- 移除复活虚弱
            player:SetHealth(player:GetMaxHealth())
            -- self:RemoveAllAuras()    --移除所有状态
            player:SendBroadcastMessage("你身上的复活虚弱状态已被移除")
        else
            player:SendBroadcastMessage("你身上没有复活虚弱状态")
        end
    end,
    -- 脱离战斗
    outCombat = function(player)
        if player:IsInCombat() then
            player:ClearInCombat()
            player:SendAreaTriggerMessage("你已脱离战斗")
            -- player:SendBroadcastMessage("你已脱离战斗")
        else
            player:SendAreaTriggerMessage("你并没有在战斗")
            -- player:SendBroadcastMessage("你并没有在战斗")
        end
    end,
    -- 技能熟练度 max
    skillsToMax = function(player)
        player:AdvanceSkillsToMax()
        player:SendBroadcastMessage("技能熟练度已经达到最大值")
    end,
    -- 回复生命
    healthToMax = function(player)
        player:SetHealth(player:GetMaxHealth())
        player:SendBroadcastMessage("生命值已满")
    end,
    -- 重置天赋
    resetTalents = function(player)
        player:ResetTalents(true) -- 免费
        player:SendBroadcastMessage("已重置天赋")
    end,
    -- 重置宠物天赋
    resetPetTalents = function(player)
        player:ResetPetTalents()
        player:SendBroadcastMessage("已重置宠物天赋")
    end,
    -- 刷新冷却
    resetAllCD = function(player)
        player:ResetAllCooldowns()
        player:SendBroadcastMessage("已重置物品和技能冷却")
    end,
    -- 修理装备
    repairAll = function(player)
        player:DurabilityRepairAll(true, 1, false)
        player:SendBroadcastMessage("修理完所有装备")
    end,
    -- 保存数据
    saveToDB = function(player)
        player:SaveToDB()
        -- player:SendAreaTriggerMessage("保存数据完成")
        player:SendBroadcastMessage("保存数据完成")
    end,
    -- 副本解绑
    unBindInstance = function(player)
        local Instances = { -- 副本表
        {249, 0}, {249, 1}, {269, 1}, {309, 0}, {409, 0}, {469, 0}, {509, 0}, {531, 0}, {532, 0}, {533, 0}, {533, 1},
        {534, 0}, {540, 1}, {542, 1}, {543, 1}, {544, 0}, {545, 1}, {546, 1}, {547, 1}, {548, 0}, {550, 0}, {552, 1},
        {553, 1}, {554, 1}, {555, 1}, {556, 1}, {557, 1}, {558, 1}, {560, 1}, {564, 0}, {565, 0}, {568, 0}, {574, 1},
        {575, 1}, {576, 1}, {578, 1}, {580, 0}, {585, 1}, {595, 1}, {598, 1}, {599, 1}, {600, 1}, {601, 1}, {602, 1},
        {603, 0}, {603, 1}, {604, 1}, {608, 1}, {615, 0}, {615, 1}, {616, 0}, {616, 1}, {619, 1}, {624, 0}, {624, 1},
        {631, 0}, {631, 1}, {631, 2}, {631, 3}, {632, 1}, {649, 0}, {649, 1}, {649, 2}, {649, 3}, -- 十字军的试炼
        {650, 1}, {658, 1}, {668, 1}, {724, 0}, {724, 1}, {724, 2}, {724, 3}}
        local nowmap = player:GetMapId()
        for k, v in pairs(Instances) do
            local mapid = v[1]
            if (mapid ~= nowmap) then
                player:UnbindInstance(v[1], v[2])
            else
                player:SendBroadcastMessage("你所在的当前副本无法解除绑定")
            end
        end
        player:SendAreaTriggerMessage("已解除所有副本的绑定")
        player:SendBroadcastMessage("已解除所有副本的绑定")
    end,
    -- ic buff 增强
    icBuffAura = function(player)
        ICBuffAura.add(player)
    end,
    -- ic 只升一级
    icLvUpOne = function(player)
        local oldLevel = player:GetLevel()
        if (oldLevel >= 80) then
            player:SendBroadcastMessage("你已经足够强壮")
            return
        end
        player:SetLevel(oldLevel + 1)
        -- -- dk 单独处理 (80 满级 51，出生 55级)
        -- if player:GetClass() == 6 then
        --     player:ResetTalents(true)
        --     player:SetFreeTalentPoints(26 + (ICLvup.MaxPlayerLevel - 55))
        -- end
        player:SendBroadcastMessage("如你所愿...")
    end,
    -- ic 一键升级
    icLvUp = function(player)
        local oldLevel = player:GetLevel()
        if (oldLevel >= ICLvup.MaxPlayerLevel) then
            player:SendBroadcastMessage("你已经足够强壮")
            return
        end
        player:SetLevel(ICLvup.MaxPlayerLevel)
        -- -- dk 单独处理 (80 满级 51，出生 55级)
        -- if player:GetClass() == 6 then
        --     player:ResetTalents(true)
        --     player:SetFreeTalentPoints(26 + (ICLvup.MaxPlayerLevel - 55))
        -- end
        player:SendBroadcastMessage("如你所愿...你这只鸡比KFC还早熟")
    end,
    -- ic 伏击系统开关
    icAmbush = function(player)
        if (player:GetData("Ambush.state") or "off") == "off" then
            player:SendAreaTriggerMessage("伏击系统状态手动切换为 (on: 开启)")
            Ambush.LoopFight(player)
        else
            player:SetData("Ambush.state", "off")
            player:SendAreaTriggerMessage("伏击系统状态手动切换为 (off: 关闭)")
            Ambush.onStartFight(nil, nil, nil, player)
        end
    end,
    -- ic 自动完成任务
    icQuestAC = function(player)
        ICQuestAC.complete(player)
    end,
    -- 打印当前地图+坐标方便加新的传送点
    icMappin = function(player)
        local map = player:GetMap()
        local mapName = map:GetName()
        local mapId = map:GetMapId()
        local msg = mapName .. " | " .. tostring(mapId) .. ", " .. player:GetX() .. ", " .. player:GetY() .. ", " ..
                        player:GetZ() .. ", " .. player:GetO()
        print(msg)
        player:SendBroadcastMessage(msg)
    end
}

-- 交互菜单
ICStone.menu = {
    [1] = { -- 主菜单
    {1, "怪物随机伏击系统开关.", ICStone.func.icAmbush, GOSSIP_ICON_BATTLE, false,
     "确定切换伏击状态 ?"},
    {1, "立即升级", ICStone.func.icLvUpOne, GOSSIP_ICON_CHAT, false, "是否要立即|cFFF0F000加一级|r ?"},
    {1, "记录位置", ICStone.func.setHome, GOSSIP_ICON_CHAT, false, "是否设置当前位置为|cFFF0F000家|r ?"},
    {1, "传送回家", ICStone.func.goHome, GOSSIP_ICON_CHAT, false, "是否传送回|cFFF0F000家|r ?"},
    {1, "当前位置坐标信息", ICStone.func.icMappin, GOSSIP_ICON_CHAT},
    {1, "打开银行", ICStone.func.openBank, GOSSIP_ICON_MONEY_BAG},
    {1, "召唤商人", ICMerchant.SummonNPC, GOSSIP_ICON_MONEY_BAG}, {2, "地图传送", 2, GOSSIP_ICON_BATTLE},
    {1, "免费重置天赋", ICStone.func.resetTalents, GOSSIP_ICON_TRAINER, false, "确认重置天赋 ?"},
    {1, "修理所有装备", ICStone.func.repairAll, GOSSIP_ICON_VENDOR, false, "确认花钱修理全部装备 ?"},
    {1, "请赐予我力量吧!", ICStone.func.icBuffAura, GOSSIP_ICON_VENDOR},
    {1, "完成当前所有未完成的任务", ICStone.func.icQuestAC, GOSSIP_ICON_CHAT, false,
     "确定消费1%的钱来省事|r ?"}},
    [2] = { -- 地图传送
    {2, "主要城市", 2 + 0x10, GOSSIP_ICON_BATTLE}, {2, "东部王国", 2 + 0x20, GOSSIP_ICON_BATTLE},
    {2, "卡利姆多", 2 + 0x30, GOSSIP_ICON_BATTLE}, {2, "外域", 2 + 0x40, GOSSIP_ICON_BATTLE},
    {2, "诺森德", 2 + 0x50, GOSSIP_ICON_BATTLE}, {2, "经典旧世界地下城", 2 + 0x60, GOSSIP_ICON_BATTLE},
    {2, "燃烧的远征地下城", 2 + 0x70, GOSSIP_ICON_BATTLE},
    {2, "巫妖王之怒地下城", 2 + 0x80, GOSSIP_ICON_BATTLE}, {2, "团队地下城", 2 + 0x90, GOSSIP_ICON_BATTLE},
    {2, "风景传送", 2 + 0xa0, GOSSIP_ICON_BATTLE}, {2, "其他传送", 2 + 0xb0, GOSSIP_ICON_BATTLE},
    {2, "野外BOSS传送", 2 + 0xc0, GOSSIP_ICON_BATTLE}},
    [2 + 0x10] = { -- 主要城市
    {3, "暴风城", 0, -8842.09, 626.358, 94.0867, 3.61363, TEAM_ALLIANCE},
    {3, "达纳苏斯", 1, 9869.91, 2493.58, 1315.88, 2.78897, TEAM_ALLIANCE},
    {3, "铁炉堡", 0, -4900.47, -962.585, 501.455, 5.40538, TEAM_ALLIANCE},
    {3, "埃索达", 530, -3864.92, -11643.7, -137.644, 5.50862, TEAM_ALLIANCE},
    {3, "奥格瑞玛", 1, 1601.08, -4378.69, 9.9846, 2.14362, TEAM_HORDE},
    {3, "雷霆崖", 1, -1274.45, 71.8601, 128.159, 2.80623, TEAM_HORDE},
    {3, "幽暗城", 0, 1633.75, 240.167, -43.1034, 6.26128, TEAM_HORDE},
    {3, "银月城", 530, 9738.28, -7454.19, 13.5605, 0.043914, TEAM_HORDE},
    {3, "[诺森德]达拉然", 571, 5809.55, 503.975, 657.526, 2.38338},
    {3, "[外域]沙塔斯", 530, -1887.62, 5359.09, -12.4279, 4.40435},
    {3, "[中立]藏宝海湾", 0, -14281.9, 552.564, 8.90422, 0.860144},
    {3, "[中立]棘齿城", 1, -955.21875, -3678.92, 8.29946, 0},
    {3, "[中立]加基森", 1, -7122.79834, -3704.82, 14.0526, 0}},
    [2 + 0x20] = { -- 东部王国
    {3, "[矮人]国王谷", 0, -5891.2045898438, -2635.6938476562, 310.86532592773, 5.4926061630249},
    {3, "[矮人]铁环挖掘场", 0, -5706.921875, -3788.8317871094, 322.83383178711, 1.0492267608643},
    {3, "艾尔文森林", 0, -9449.06, 64.8392, 56.3581, 3.0704},
    {3, "永歌森林", 530, 9024.37, -6682.55, 16.8973, 3.1413},
    {3, "丹莫罗", 0, -5603.76, -482.704, 396.98, 5.2349},
    {3, "提瑞斯法林地", 0, 2274.95, 323.918, 34.1137, 4.2436},
    {3, "幽魂之地", 530, 7595.73, -6819.6, 84.3718, 2.5656},
    {3, "洛克莫丹", 0, -5405.85, -2894.15, 341.972, 5.4823},
    {3, "银松森林", 0, 505.126, 1504.63, 124.808, 1.7798},
    {3, "西部荒野", 0, -10684.9, 1033.63, 32.5389, 6.0738},
    {3, "赤脊山", 0, -9447.8, -2270.85, 71.8224, 0.28385},
    {3, "暮色森林", 0, -10531.7, -1281.91, 38.8647, 1.5695},
    {3, "希尔斯布莱德丘陵", 0, -385.805, -787.954, 54.6655, 1.0392},
    {3, "湿地", 0, -3517.75, -913.401, 8.86625, 2.6070},
    {3, "奥特兰克山脉", 0, 275.049, -652.044, 130.296, 0.50203}, {2, "下一页", 2 + 0x120, GOSSIP_ICON_CHAT}},
    [2 + 0x120] = { -- 东部王国    2
    {3, "阿拉希高地", 0, -1581.45, -2704.06, 35.4168, 0.490373},
    {3, "荆棘谷", 0, -11921.7, -59.544, 39.7262, 3.7357}, {3, "荒芜之地", 0, -6782.56, -3128.14, 240.48, 5.6591},
    {3, "悲伤沼泽", 0, -10368.6, -2731.3, 21.6537, 5.2923},
    {3, "辛特兰", 0, 112.406, -3929.74, 136.358, 0.981903},
    {3, "灼热峡谷", 0, -6686.33, -1198.55, 240.027, 0.91688},
    {3, "诅咒之地", 0, -11184.7, -3019.31, 7.29238, 3.20542},
    {3, "燃烧平原", 0, -7979.78, -2105.72, 127.919, 5.10148},
    {3, "西瘟疫之地", 0, 1743.69, -1723.86, 59.6648, 5.23722},
    {3, "东瘟疫之地", 0, 2280.64, -5275.05, 82.0166, 4.747},
    {3, "奎尔丹纳斯岛", 530, 12806.5, -6911.11, 41.1156, 2.2293}},
    [2 + 0x30] = { -- 卡利姆多
    {3, "[精灵]多兰纳尔", 1, 9847.5380859375, 969.68896484375, 1306.3482666016, 3.6988995075226},
    {3, "秘蓝岛", 530, -4192.62, -12576.7, 36.7598, 1.62813}, {3, "秘血岛", 530, -2721.67, -12208.90, 9.08, 0},
    {3, "达希尔", 1, 9889.03, 915.869, 1307.43, 1.9336},
    {3, "杜隆塔尔", 1, 228.978, -4741.87, 10.1027, 0.416883},
    {3, "莫高雷", 1, -2473.87, -501.225, -9.42465, 0.6525},
    {3, "秘血岛", 530, -2095.7, -11841.1, 51.1557, 6.19288}, {3, "黑海岸", 1, 6463.25, 683.986, 8.92792, 4.33534},
    {3, "贫瘠之地", 1, -575.772, -2652.45, 95.6384, 0.006469},
    {3, "石爪山脉", 1, 1574.89, 1031.57, 137.442, 3.8013},
    {3, "灰谷森林", 1, 1919.77, -2169.68, 94.6729, 6.14177},
    {3, "千针石林", 1, -5375.53, -2509.2, -40.432, 2.41885},
    {3, "凄凉之地", 1, -656.056, 1510.12, 88.3746, 3.29553},
    {3, "尘泥沼泽", 1, -3350.12, -3064.85, 33.0364, 5.12666},
    {3, "菲拉斯", 1, -4808.31, 1040.51, 103.769, 2.90655},
    {3, "塔纳利斯沙漠", 1, -6940.91, -3725.7, 48.9381, 3.11174},
    {3, "艾萨拉", 1, 3117.12, -4387.97, 91.9059, 5.49897},
    {3, "费伍德森林", 1, 3898.8, -1283.33, 220.519, 6.24307},
    {3, "安戈洛环形山", 1, -6291.55, -1158.62, -258.138, 0.457099},
    {3, "希利苏斯", 1, -6815.25, 730.015, 40.9483, 2.39066},
    {3, "冬泉谷", 1, 6658.57, -4553.48, 718.019, 5.18088}},
    [2 + 0x40] = { -- 外域
    {3, "地狱火半岛", 530, -207.335, 2035.92, 96.464, 1.59676},
    {3, "地狱火半岛-荣耀堡", 530, -683.05, 2657.57, 91.04, 0, TEAM_ALLIANCE},
    {3, "地狱火半岛-萨尔玛", 530, 139.96, 2671.51, 85.509, 0, TEAM_HORDE},
    {3, "赞加沼泽", 530, -220.297, 5378.58, 23.3223, 1.61718},
    {3, "泰罗卡森林", 530, -2266.23, 4244.73, 1.47728, 3.68426},
    {3, "纳格兰", 530, -1610.85, 7733.62, -17.2773, 1.33522},
    {3, "刀锋山", 530, 2029.75, 6232.07, 133.495, 1.30395},
    {3, "虚空风暴", 530, 3271.2, 3811.61, 143.153, 3.44101},
    {3, "影月谷", 530, -3681.01, 2350.76, 76.587, 4.25995}},
    [2 + 0x50] = { -- 诺森德
    {3, "北风苔原", 571, 2954.24, 5379.13, 60.4538, 2.55544},
    {3, "凛风峡湾", 571, 682.848, -3978.3, 230.161, 1.54207},
    {3, "龙骨荒野", 571, 2678.17, 891.826, 4.37494, 0.101121},
    {3, "灰熊丘陵", 571, 4017.35, -3403.85, 290, 5.35431},
    {3, "祖达克", 571, 5560.23, -3211.66, 371.709, 5.55055},
    {3, "索拉查盆地", 571, 5614.67, 5818.86, -69.722, 3.60807},
    {3, "水晶之歌森林", 571, 5411.17, -966.37, 167.082, 1.57167},
    {3, "风暴峭壁", 571, 6120.46, -1013.89, 408.39, 5.12322},
    {3, "冰冠冰川", 571, 8323.28, 2763.5, 655.093, 2.87223},
    {3, "冬拥湖", 571, 4522.23, 2828.01, 389.975, 0.215009}},
    [2 + 0x60] = { -- 经典旧世界地下城
    {3, "诺莫瑞根", 0, -5163.54, 925.423, 257.181, 1.57423},
    {3, "死亡矿井", 0, -11209.6, 1666.54, 24.6974, 1.42053},
    {3, "暴风城监狱", 0, -8799.15, 832.718, 97.6348, 6.04085, TEAM_ALLIANCE},
    {3, "怒焰裂谷", 1, 1811.78, -4410.5, -18.4704, 5.20165, TEAM_HORDE},
    {3, "剃刀高地", 1, -4657.3, -2519.35, 81.0529, 4.54808},
    {3, "剃刀沼泽", 1, -4470.28, -1677.77, 81.3925, 1.16302},
    {3, "血色修道院", 0, 2873.15, -764.523, 160.332, 5.10447},
    {3, "影牙城堡", 0, -234.675, 1561.63, 76.8921, 1.24031},
    {3, "哀嚎洞穴", 1, -731.607, -2218.39, 17.0281, 2.78486},
    {3, "黑暗深渊", 1, 4249.99, 740.102, -25.671, 1.34062},
    {3, "黑石深渊", 0, -7179.34, -921.212, 165.821, 5.09599},
    {3, "黑石塔", 0, -7527.05, -1226.77, 285.732, 5.29626},
    {3, "厄运之槌", 1, -3520.14, 1119.38, 161.025, 4.70454},
    {3, "玛拉顿", 1, -1421.42, 2907.83, 137.415, 1.70718},
    {3, "通灵学院", 0, 1269.64, -2556.21, 93.6088, 0.620623},
    {3, "斯坦索姆", 0, 3352.92, -3379.03, 144.782, 6.25978},
    {3, "沉没的神庙", 0, -10177.9, -3994.9, -111.239, 6.01885},
    {3, "奥达曼", 0, -6071.37, -2955.16, 209.782, 0.015708},
    {3, "祖尔法拉克", 1, -6801.19, -2893.02, 9.00388, 0.158639}},
    [2 + 0x70] = { -- 燃烧的远征地下城
    {3, "奥金顿", 530, -3324.49, 4943.45, -101.239, 4.63901},
    {3, "时光之穴", 1, -8369.65, -4253.11, -204.272, -2.70526},
    {3, "盘牙水库", 530, 738.865, 6865.77, -69.4659, 6.27655},
    {3, "地狱火堡垒", 530, -347.29, 3089.82, 21.394, 5.68114},
    {3, "魔导师平台", 530, 12884.6, -7317.69, 65.5023, 4.799},
    {3, "风暴要塞", 530, 3100.48, 1536.49, 190.3, 4.62226}},
    [2 + 0x80] = { -- 巫妖王之怒地下城
    {3, "艾卓-尼鲁布", 571, 3707.86, 2150.23, 36.76, 3.22},
    {3, "斯坦索姆的抉择", 1, -8756.39, -4440.68, -199.489, 4.66289},
    {3, "冠军的试炼", 571, 8590.95, 791.792, 558.235, 3.13127},
    {3, "达克萨隆堡垒", 571, 4765.59, -2038.24, 229.363, 0.887627},
    {3, "古达克", 571, 6722.44, -4640.67, 450.632, 3.91123},
    {3, "冰冠城塞", 571, 5643.16, 2028.81, 798.274, 4.60242},
    {3, "魔枢", 571, 3782.89, 6965.23, 105.088, 6.14194},
    {3, "紫罗兰监狱", 571, 5693.08, 502.588, 652.672, 4.0229},
    {3, "闪电大厅", 571, 9136.52, -1311.81, 1066.29, 5.19113},
    {3, "石头大厅", 571, 8922.12, -1009.16, 1039.56, 1.57044},
    {3, "乌特加德城堡", 571, 1203.41, -4868.59, 41.2486, 0.283237},
    {3, "乌特加德之巅", 571, 1267.24, -4857.3, 215.764, 3.22768}},
    [2 + 0x90] = { -- 团队地下城
    {3, "黑暗神庙", 530, -3649.92, 317.469, 35.2827, 2.94285},
    {3, "黑翼之巢", 229, 152.451, -474.881, 116.84, 0.001073},
    {3, "海加尔山之巅", 1, -8177.89, -4181.23, -167.552, 0.913338},
    {3, "毒蛇神殿", 530, 797.855, 6865.77, -65.4165, 0.005938},
    {3, "十字军的试炼", 571, 8515.61, 714.153, 558.248, 1.57753},
    {3, "格鲁尔的巢穴", 530, 3530.06, 5104.08, 3.50861, 5.51117},
    {3, "玛瑟里顿的巢穴", 530, -336.411, 3130.46, -102.928, 5.20322},
    {3, "冰冠城塞", 571, 5855.22, 2102.03, 635.991, 3.57899},
    {3, "卡拉赞", 0, -11118.9, -2010.33, 47.0819, 0.649895},
    {3, "熔火之心", 230, 1126.64, -459.94, -102.535, 3.46095},
    {3, "纳克萨玛斯", 571, 3668.72, -1262.46, 243.622, 4.785},
    {3, "奥妮克希亚的巢穴", 1, -4708.27, -3727.64, 54.5589, 3.72786},
    {3, "安其拉废墟", 1, -8409.82, 1499.06, 27.7179, 2.51868}, {2, "下一页", 2 + 0x190, GOSSIP_ICON_BATTLE}},
    [2 + 0x190] = { -- 团队地下城2
    {3, "太阳井高地", 530, 12574.1, -6774.81, 15.0904, 3.13788},
    {3, "风暴要塞", 530, 3088.49, 1381.57, 184.863, 4.61973},
    {3, "安其拉神殿", 1, -8240.09, 1991.32, 129.072, 0.941603},
    {3, "永恒之眼", 571, 3784.17, 7028.84, 161.258, 5.79993},
    {3, "黑曜石圣殿", 571, 3472.43, 264.923, -120.146, 3.27923},
    {3, "奥杜尔", 571, 9222.88, -1113.59, 1216.12, 6.27549},
    {3, "阿尔卡冯的宝库", 571, 5453.72, 2840.79, 421.28, 0},
    {3, "祖尔格拉布", 0, -11916.7, -1215.72, 92.289, 4.72454},
    {3, "祖阿曼", 530, 6851.78, -7972.57, 179.242, 4.64691}},
    [2 + 0xa0] = { -- 风景传送
    -- {3, "GM之岛", 1, 16222.1, 16252.1, 12.5872, 0}, 
    {3, "时光之穴", 1, -8173.93018, -4737.46387, 33.77735, 0},
    {3, "双塔山", 1, -3331.35327, 2225.72827, 30.9877, 0},
    {3, "梦境之树", 1, -2914.7561, 1902.19934, 34.74103, 0},
    {3, "恐怖之岛", 1, 4603.94678, -3879.25097, 944.18347, 0},
    {3, "天涯海滩", 1, -9851.61719, -3608.47412, 8.93973, 0},
    {3, "安戈洛环形山", 1, -8562.09668, -2106.05664, 8.85254, 0},
    {3, "石堡瀑布", 0, -9481.49316, -3326.91528, 8.86435, 0},
    {3, "暴雪建设公司路障", 1, 5478.06006, -3730.8501, 1593.44, 0}},
    [2 + 0xb0] = { -- 其他传送
    {3, "古拉巴什竞技场", 0, -13181.8, 339.356, 42.9805, 1.18013}, -- Alliance
    {3, "奥特兰战场", 0, 5.599396, -308.73822, 132.26651, 0, TEAM_ALLIANCE},
    {3, "阿拉希战场", 0, -1229.860352, -2545.07959, 21.180079, 0, TEAM_ALLIANCE}, -- Horde
    {3, "阿拉希战场", 0, -847.953491, -3519.764893, 72.607727, 0, TEAM_HORDE},
    {3, "奥特兰战场", 0, 396.471863, -1006.229126, 111.719086, 0, TEAM_HORDE},
    {3, "战歌峡谷", 1, 1036.794800, -2106.138672, 122.94553, 0, TEAM_HORDE}},
    [2 + 0xc0] = { -- 野外BOSS传送
    {3, "暮色森林", 0, -10526.16895, -434.996796, 50.8948, 0},
    {3, "辛特兰", 0, 759.605713, -3893.341309, 116.4753, 0},
    {3, "灰谷", 1, 3120.289307, -3439.444336, 139.5663, 0},
    {3, "艾萨拉", 1, 2622.219971, -5977.930176, 100.5629, 0},
    {3, "菲拉斯", 1, -2741.290039, 2009.481323, 31.8773, 0}, {3, "诅咒之地", 0, -12234, -2474, -3, 0},
    {3, "水晶谷", 1, -6292.463379, 1578.029053, 0.1553, 0}}
}

function ICStone.AddGossip(player, item, id)
    player:GossipClearMenu() -- 清除菜单
    local Rows = ICStone.menu[id] or {}
    local Pteam = player:GetTeam()
    local teamStr, team = "", player:GetTeam()
    if (team == TEAM_ALLIANCE) then
        teamStr = "[|cFF0070d0联盟|r]"
    elseif (team == TEAM_HORDE) then
        teamStr = "[|cFFF000A0部落|r]"
    end
    for k, v in pairs(Rows) do
        local mtype, text, icon, intid = v[1], (v[2] or "???"), (v[4] or GOSSIP_ICON_CHAT), (id * 0x100 + k)
        if (mtype == 2) then
            player:GossipMenuAddItem(icon, text, 0, (v[3] or id) * 0x100)

        elseif (mtype == 1) then
            local code, msg, money = v[5], (v[6] or ""), (v[7] or 0)
            if code ~= nil then
                player:GossipMenuAddItem(icon, text, money, intid, code, msg, money)
            else
                player:GossipMenuAddItem(icon, text, 0, intid)
            end
        elseif (mtype == 3) then
            local mteam = v[8] or TEAM_NONE
            if (mteam == Pteam) then
                player:GossipMenuAddItem(GOSSIP_ICON_TAXI, teamStr .. text, 0, intid, false,
                    "是否传送到 |cFFFFFF00" .. text .. "|r ?", 0)
            elseif (mteam == TEAM_NONE) then
                player:GossipMenuAddItem(GOSSIP_ICON_TAXI, text, 0, intid, false,
                    "是否传送到 |cFFFFFF00" .. text .. "|r ?", 0)
            end
        else
            player:GossipMenuAddItem(icon, text, 0, intid)
        end
    end
    if (id > 0) then -- 添加返回上一页菜单
        local length = string.len(string.format("%x", id))
        if (length > 1) then
            local temp = bit_and(id, 2 ^ ((length - 1) * 4) - 1)
            if (temp ~= 1) then
                player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "上一页", 0, temp * 0x100)
            end
        end
    end
    if (id ~= 1) then -- 添加返回主菜单
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "主菜单", 0, 1 * 0x100)
    end

    player:GossipSendMenu(1, item) -- 发送菜单
end

function ICStone.ShowGossip(event, player, item)
    player:MoveTo(0, player:GetX(), player:GetY(), player:GetZ() + 0.01) -- 移动就停止当前施法
    ICStone.AddGossip(player, item, 1)
end

function ICStone.SelectGossip(event, player, item, sender, intid, code, menu_id)
    local menuid = math.modf(intid / 0x100) -- 菜单组
    local rowid = intid - menuid * 0x100 -- 第几项
    if (rowid == 0) then
        ICStone.AddGossip(player, item, menuid)
    else
        player:GossipComplete() -- 关闭菜单
        local v = ICStone.menu[menuid] and ICStone.menu[menuid][rowid]
        if (v) then -- 如果找到菜单项
            local mtype = v[1] or 2
            if (mtype == 2) then
                ICStone.AddGossip(player, item, (v[3] or 1))
            elseif (mtype == 1) then -- 功能
                local f = v[3]
                if (f) then
                    player:ModifyMoney(-sender) -- 扣费
                    f(player, code)
                end
            elseif (mtype == 3) then -- 传送
                local map, mapid, x, y, z, o = v[2], v[3], v[4], v[5], v[6], v[7] or 0
                local pname = player:GetName() -- 得到玩家名
                if (player:Teleport(mapid, x, y, z, o, TELE_TO_GM_MODE)) then -- 传送
                    local Nplayer = GetPlayerByName(pname) -- 根据玩家名得到玩家
                    if (Nplayer) then
                        Nplayer:SendBroadcastMessage("已经到达 " .. map)
                        Nplayer:ModifyMoney(-sender) -- 扣费
                    end
                else
                    print(">>Eluna Error: Teleport Stone : Teleport To " .. mapid)
                end
            end
        end
    end
end

local function onLogin(event, player)
    -- print("GM Rank: "..tostring(player:GetGMRank()))
    if player:GetGMRank() > 0 then
        ICStone.func.resetAllCD(player)
    end
    -- 没有炉石的给一下
    if not player:HasItem(ICStone.entry, 1, true) then
        player:AddItem(ICStone.entry, 1)
    end
    -- 补学
    -- if not player:HasSpell(33388) then
    --     player:LearnSpell(33388)
    --     player:LearnSpell(33391)
    --     player:LearnSpell(34090)
    --     player:LearnSpell(54197)
    --     player:LearnSpell(34091)
    -- end
end

-- <非满级玩家死亡等待等级对应秒后自动复活>

local function resurrectPlayer(_eventid, _delay, _repeats, player)
    -- 复活+物理保护15秒（保护祝福 41450）
    player:ResurrectPlayer(100)
    player:AddAura(41450, player)
    ICStone.func.icBuffAura(player)
end

local function onKilledByCreature(event, killer, player)
    local level = player:GetLevel()
    if level >= 80 then
        -- player:Say("【"..player:GetName().."】死了！")
        return
    end
    -- 多少级死了自动复活就需要等多少秒
    -- player:Say("【"..player:GetName().."】死了！但会在 "..level.." 秒后自动复活")
    player:SendBroadcastMessage("你将在 " .. level .. " 秒后自动复活")
    player:RegisterEvent(resurrectPlayer, level * 1000, 1)
end

-- </非满级玩家死亡等待等级对应秒后自动复活>

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, onLogin)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILLED_BY_CREATURE, onKilledByCreature)
RegisterItemGossipEvent(ICStone.entry, 1, ICStone.ShowGossip)
RegisterItemGossipEvent(ICStone.entry, 2, ICStone.SelectGossip)
