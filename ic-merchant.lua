print(">> Script: ic-merchant")

ICMerchant = {}

-- 商人NPC
ICMerchant.entry = 190099
ICMerchant.name = "IC随身商人"
ICMerchant.keepTime = 90

-- 随机的话
ICMerchant.says = {"我的货物不打折的哦", "慢慢看，我的货物在其他地方买不到。",
                   "我的时间可不多，你要快点买。", "你应该需要更换你的雕文。"}

-- 货物清单
ICMerchant.goods = {
    [0] = { -- 主菜单
    {"雕文", 1},
    {"随机武器护甲", 11},{"消耗品", 22}},
    [1] = { -- 雕文
    {"盗贼雕文", 1 + 0x10}, {"德鲁伊雕文", 1 + 0x20}, {"法师雕文", 1 + 0x30}, {"猎人雕文", 1 + 0x40},
    {"牧师雕文", 1 + 0x50}, {"骑士雕文", 1 + 0x60}, {"萨满雕文", 1 + 0x70}, {"术士雕文", 1 + 0x80},
    {"死骑雕文", 1 + 0x90}, {"战士雕文", 1 + 0xa0}},
    [1 + 0x10] = { -- 盗贼
    42954, -- 冲动雕文
    42955, -- 伏击雕文
    42956, -- 背刺雕文
    42957, -- 剑刃乱舞雕文
    42958, -- 减速药膏雕文
    42959, -- 致命投掷雕文
    42960, -- 闪避雕文
    42961, -- 刺骨雕文
    42962, -- 破甲雕文
    42963, -- 佯攻雕文
    42964, -- 锁喉雕文
    42965, -- 鬼魅攻击雕文
    42966, -- 凿击雕文
    42967, -- 出血雕文
    42968, -- 伺机待发雕文
    42969, -- 割裂雕文
    42970, -- 闷棍雕文
    42971, -- 精力雕文
    42972, -- 影袭雕文
    42973, -- 切割雕文
    42974, -- 疾跑雕文
    43343, -- 妙手空空雕文
    43376, -- 扰乱雕文
    43377, -- 开锁雕文
    43378, -- 安全降落雕文
    43379, -- 水上漂雕文
    43380, -- 消失雕文
    45761, -- 血之饥渴雕文
    45762, -- 杀戮盛筵雕文
    45764, -- 暗影之舞雕文
    45766, -- 刀扇雕文
    45767, -- 嫁祸诀窍雕文
    45768, -- 毁伤雕文
    45769, -- 暗影斗篷雕文
    45908 -- 毒伤雕文
    },
    [1 + 0x20] = { -- 德鲁伊
    40896, -- 狂暴回复雕文
    40897, -- 重殴雕文
    40899, -- 低吼雕文
    40900, -- 裂伤雕文
    40901, -- 撕碎雕文
    40902, -- 割裂雕文
    40903, -- 斜掠雕文
    40906, -- 迅捷治愈雕文
    40908, -- 激活雕文
    40909, -- 复生雕文
    40912, -- 愈合雕文
    40913, -- 回春雕文
    40914, -- 治疗之触雕文
    40915, -- 生命绽放雕文
    40916, -- 星火雕文
    40919, -- 虫群雕文
    40920, -- 飓风雕文
    40921, -- 星辰坠落雕文
    40922, -- 愤怒雕文
    40923, -- 月火雕文
    40924, -- 纠缠根须雕文
    43316, -- 水栖形态雕文
    43331, -- 无忧复生雕文
    43332, -- 荆棘雕文
    43334, -- 挑战咆哮雕文
    43335, -- 野性雕文
    43674, -- 急奔雕文
    44922, -- 台风雕文
    44928, -- 专注雕文
    45601, -- 狂暴雕文
    45602, -- 野性成长雕文
    45603, -- 滋养雕文
    45604, -- 野蛮咆哮雕文
    45622, -- 季风雕文
    45623, -- 树皮雕文
    46372 -- 生存本能雕文
    },
    [1 + 0x30] = { -- 法师
    42734, -- 魔爆雕文
    42735, -- 奥术飞弹雕文
    42736, -- 奥术强化雕文
    42737, -- 闪现雕文
    42738, -- 唤醒雕文
    42739, -- 火球雕文
    42740, -- 火焰冲击雕文
    42741, -- 冰霜新星雕文
    42742, -- 寒冰箭雕文
    42743, -- 冰甲雕文
    42744, -- 寒冰屏障雕文
    42745, -- 冰枪雕文
    42746, -- 冰冷血脉雕文
    42747, -- 强化灼烧雕文
    42748, -- 隐形雕文
    42749, -- 法师护甲雕文
    42750, -- 法力宝石雕文
    42751, -- 熔岩护甲雕文
    42752, -- 变形雕文
    42753, -- 解除诅咒雕文
    42754, -- 水元素雕文
    43339, -- 奥术智慧雕文
    43357, -- 防护火焰结界雕文
    43359, -- 霜甲雕文
    43360, -- 防护冰霜结界雕文
    43361, -- 企鹅雕文
    43362, -- 小熊雕文
    43364, -- 缓落雕文
    44684, -- 霜火雕文
    44920, -- 冲击波雕文
    44955, -- 奥术冲击雕文
    45736, -- 深度冻结雕文
    45737, -- 活动炸弹雕文
    45738, -- 奥术弹幕雕文
    45739, -- 镜像雕文
    45740 -- 寒冰护体雕文
    },
    [1 + 0x40] = { -- 猎人
    42897, -- 瞄准射击雕文
    42898, -- 奥术射击雕文
    42899, -- 野兽雕文
    42900, -- 治愈雕文
    42901, -- 蝰蛇守护雕文
    42902, -- 狂野怒火雕文
    42903, -- 威慑雕文
    42904, -- 逃脱雕文
    42905, -- 冰冻陷阱雕文
    42906, -- 冰霜陷阱雕文
    42907, -- 猎人印记雕文
    42908, -- 献祭陷阱雕文
    42909, -- 雄鹰雕文
    42910, -- 多重射击雕文
    42911, -- 急速射击雕文
    42912, -- 毒蛇钉刺雕文
    42913, -- 毒蛇陷阱雕文
    42914, -- 稳固射击雕文
    42915, -- 强击光环雕文
    42917, -- 翼龙钉刺雕文
    43338, -- 复活宠物雕文
    43350, -- 治疗宠物雕文
    43351, -- 假死雕文
    43354, -- 支配之力雕文
    43355, -- 豹群雕文
    43356, -- 恐吓野兽雕文
    45625, -- 奇美拉射击雕文
    45731, -- 爆炸射击雕文
    45732, -- 杀戮射击雕文
    45733, -- 爆炸陷阱雕文
    45734, -- 驱散射击雕文
    45735 -- 猛禽一击雕文
    },
    [1 + 0x50] = { -- 牧师
    42396, -- 治疗之环雕文
    42397, -- 驱散魔法雕文
    42398, -- 渐隐雕文
    42399, -- 防护恐惧结界雕文
    42400, -- 快速治疗雕文
    42401, -- 神圣新星雕文
    42402, -- 心灵之火雕文
    42403, -- 光明之泉雕文
    42404, -- 群体驱散雕文
    42405, -- 精神控制雕文
    42406, -- 精神鞭笞雕文
    42407, -- 暗影雕文
    42408, -- 真言术：盾雕文
    42409, -- 治疗祷言雕文
    42410, -- 心灵尖啸雕文
    42411, -- 恢复雕文
    42412, -- 天谴禁锢雕文
    42414, -- 暗言术：灭雕文
    42415, -- 暗言术：痛雕文
    42416, -- 惩击雕文
    42417, -- 拯救之魂雕文
    43342, -- 渐隐雕文
    43370, -- 漂浮雕文
    43371, -- 坚韧雕文
    43372, -- 防护暗影雕文
    43373, -- 束缚亡灵雕文
    43374, -- 暗影魔雕文
    45753, -- 消散雕文
    45755, -- 守护之魂雕文
    45756, -- 苦修雕文
    45757, -- 精神灼烧雕文
    45758, -- 希望圣歌雕文
    45760 -- 痛苦压制雕文
    },
    [1 + 0x60] = { -- 骑士
    41092, -- 审判雕文
    41094, -- 命令圣印雕文
    41095, -- 制裁之锤雕文
    41096, -- 灵魂协调雕文
    41097, -- 愤怒之锤雕文
    41098, -- 十字军打击雕文
    41099, -- 奉献雕文
    41100, -- 正义防御雕文
    41101, -- 复仇者之盾雕文
    41102, -- 超度邪恶雕文
    41103, -- 驱邪雕文
    41104, -- 清洁雕文
    41105, -- 圣光闪现雕文
    41106, -- 圣光雕文
    41107, -- 复仇之怒雕文
    41108, -- 圣洁雕文
    41109, -- 智慧圣印雕文
    41110, -- 光明圣印雕文
    43340, -- 力量祝福雕文
    43365, -- 王者祝福雕文
    43366, -- 智慧祝福雕文
    43367, -- 圣疗雕文
    43368, -- 感知亡灵雕文
    43369, -- 智者雕文
    43867, -- 鲜血圣印雕文
    43868, -- 正义圣印雕文
    43869, -- 复仇圣印雕文
    45741, -- 圣光道标雕文
    45742, -- 正义之锤雕文
    45743, -- 神圣风暴雕文
    45744, -- 正义盾击雕文
    45745, -- 神圣恳求雕文
    45746, -- 神圣震击雕文
    45747 -- 拯救雕文
    },
    [1 + 0x70] = { -- 萨满
    41517, -- 治疗链雕文    
    41518, -- 闪电链雕文
    41524, -- 熔岩雕文
    41526, -- 震击雕文
    41527, -- 大地生命武器雕文
    41529, -- 火焰元素图腾雕文
    41530, -- 火焰新星图腾雕文
    41531, -- 烈焰震击雕文
    41532, -- 火舌武器雕文
    41533, -- 治疗之泉图腾雕文
    41534, -- 治疗波雕文
    41535, -- 次级治疗波雕文
    41536, -- 闪电箭雕文
    41537, -- 闪电之盾雕文
    41538, -- 法力潮汐图腾雕文
    41539, -- 风暴打击雕文
    41540, -- 熔岩猛击雕文
    41541, -- 水之掌握雕文
    41542, -- 风怒武器雕文
    41547, -- 冰霜震击雕文
    41552, -- 元素掌握雕文
    43344, -- 水下呼吸雕文
    43381, -- 星界传送雕文
    43385, -- 新生雕文
    43386, -- 水之护盾雕文
    43388, -- 水上行走雕文
    43725, -- 幽灵狼雕文
    44923, -- 雷霆风暴雕文
    45770, -- 雷霆雕文
    45771, -- 野性狼魂雕文
    45772, -- 激流雕文
    45775, -- 大地之盾雕文
    45776, -- 天怒图腾雕文
    45777, -- 妖术雕文
    45778 -- 石爪图腾雕文
    },
    [1 + 0x80] = { -- 术士
    42453, -- 烧尽雕文    
    42454, -- 燃烧雕文
    42455, -- 腐蚀雕文
    42456, -- 痛苦诅咒雕文
    42457, -- 死亡缠绕雕文
    42458, -- 恐惧雕文
    42459, -- 恶魔卫士雕文
    42460, -- 地狱猎犬雕文
    42461, -- 生命通道雕文
    42462, -- 治疗石雕文
    42463, -- 恐惧嚎叫雕文
    42464, -- 献祭雕文
    42465, -- 小鬼雕文
    42466, -- 灼热之痛雕文
    42467, -- 暗影箭雕文
    42468, -- 暗影灼烧雕文
    42469, -- 生命虹吸雕文
    42470, -- 灵魂石雕文
    42471, -- 魅魔雕文
    42472, -- 痛苦无常雕文
    42473, -- 虚空行者雕文
    43389, -- 水下呼吸雕文
    43390, -- 吸取灵魂雕文
    43391, -- 基尔罗格雕文
    43392, -- 疲劳诅咒雕文
    43393, -- 奴役恶魔雕文
    43394, -- 灵魂雕文
    45779, -- 鬼影缠身雕文
    45780, -- 恶魔变形雕文
    45781, -- 混乱之箭雕文
    45782, -- 恶魔法阵雕文
    45783, -- 暗影烈焰雕文
    45785, -- 生命分流雕文
    45789 -- 灵魂链接雕文
    },
    [1 + 0x90] = { -- 死骑
    43533, -- 反魔法护罩雕文    
    43534, -- 心脏打击雕文
    43535, -- 鲜血分流雕文
    43536, -- 白骨之盾雕文
    43537, -- 寒冰锁链雕文
    43538, -- 黑暗命令雕文
    43539, -- 死亡之拥雕文
    43541, -- 死亡之握雕文
    43542, -- 死亡凋零雕文
    43543, -- 冰霜打击雕文
    43544, -- 寒冬号角雕文
    43545, -- 冰封之韧雕文
    43546, -- 冰冷触摸雕文
    43547, -- 湮没雕文
    43548, -- 瘟疫打击雕文
    43549, -- 食尸鬼雕文
    43550, -- 符文打击雕文
    43551, -- 天谴打击雕文
    43552, -- 绞杀雕文
    43553, -- 铜墙铁壁雕文
    43554, -- 吸血鬼之血雕文
    43671, -- 邪爆雕文
    43672, -- 传染雕文
    43673, -- 亡者复生雕文
    43825, -- 符文分流雕文
    43826, -- 鲜血打击雕文
    43827, -- 死亡打击雕文
    45799, -- 符文刃舞雕文
    45800, -- 饥饿之寒雕文
    45803, -- 邪恶虫群雕文
    45804, -- 黑暗死亡雕文
    45805, -- 疾病雕文
    45806 -- 凛风冲击雕文
    },
    [1 + 0xa0] = { -- 战士
    43395, -- 战斗雕文    
    43396, -- 血性狂暴雕文
    43397, -- 冲锋雕文
    43398, -- 惩戒痛击雕文
    43399, -- 雷霆一击雕文
    43400, -- 持久追击雕文
    43412, -- 嗜血雕文
    43413, -- 疾速冲锋雕文
    43414, -- 顺劈斩雕文
    43415, -- 毁灭打击雕文
    43416, -- 斩杀雕文
    43417, -- 断筋雕文
    43418, -- 英勇打击雕文
    43419, -- 援护雕文
    43420, -- 野蛮侵犯雕文
    43421, -- 致死打击雕文
    43422, -- 压制雕文
    43423, -- 撕裂雕文
    43424, -- 复仇雕文
    43425, -- 格挡雕文
    43426, -- 破釜沉舟雕文
    43427, -- 破甲雕文
    43428, -- 横扫攻击雕文
    43429, -- 嘲讽雕文
    43430, -- 共鸣雕文
    43431, -- 乘胜追击雕文
    43432, -- 旋风斩雕文
    45790, -- 利刃风暴雕文
    45792, -- 震荡波雕文
    45793, -- 警戒雕文
    45794, -- 狂怒回复雕文
    45797 -- 盾墙雕文
    }
}

-- 召唤
function ICMerchant.SummonNPC(player)
    -- local guid = player:GetGUIDLow()
    local nowTime = os.time()
    local lastTime = player:GetData("ICMerchant.createTime")
    print("nowTime:"..tostring(nowTime).."|lastTime:"..tostring(lastTime))

    if player:IsInCombat() then
        player:SendAreaTriggerMessage("战斗结束后才可以执行此操作")
    else
        if lastTime == nil or nowTime > lastTime then
            local map = player:GetMap()
            if map then
                -- player:SendAreaTriggerMessage(map:GetName())
                local x, y, z = player:GetX(), player:GetY(), player:GetZ()
                local nz = map:GetHeight(x, y)
                if (nz > z and nz < (z + 5)) then
                    z = nz
                end
                local NPC = player:SpawnCreature(ICMerchant.entry, x, y, z, 0, 3, ICMerchant.keepTime * 1000)
                if NPC then
                    -- player:SendAreaTriggerMessage("召唤成功")
                    NPC:SetFacingToObject(player)
                    NPC:SendUnitSay(string.format("%s你好, 有何贵干", player:GetName()), 0)
                    player:SetData("ICMerchant.createTime", nowTime + ICMerchant.keepTime)
                else
                    player:SendAreaTriggerMessage("召唤操作失败")
                end
            end
        else
            player:SendAreaTriggerMessage("操作不能太频繁, 等待: " .. lastTime - nowTime .. " 秒")
        end
    end
end

function ICMerchant.AddMenu(player, creature, id)
    player:GossipClearMenu() -- 清除菜单
    local menus = ICMerchant.goods[id]
    for k, v in pairs(menus) do
        player:GossipMenuAddItem(v[3] or GOSSIP_ICON_VENDOR, v[1] or "???", 0, (v[2] or k))
    end
    player:GossipSendMenu(1, creature) -- 发送菜单
end

function ICMerchant.Book(event, player, creature) -- 显示菜单
    ICMerchant.AddMenu(player, creature, 0)
end

function ICMerchant.Select(event, player, creature, sender, intid, code, menu_id) -- 添加货物
    local playerLevel = player:GetLevel()
    local text = ICMerchant.says[math.random(1, #ICMerchant.says)] or nil
    if (text) then
        creature:SendUnitSay(text, 0)
    end
    player:GossipComplete() -- 关闭菜单

    -- 消耗品
    if intid == 22 then
        VendorRemoveAllItems(ICMerchant.entry)
        -- 箭矢
        AddVendorItem(ICMerchant.entry, 2512, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 2515, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 3030, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 11285, 0, 0, 0)
        -- 子弹
        AddVendorItem(ICMerchant.entry, 2516, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 2519, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 3033, 0, 0, 0)
        AddVendorItem(ICMerchant.entry, 11284, 0, 0, 0)
        -- 治疗
        AddVendorItem(ICMerchant.entry, 19028, 0, 0, 0)
        player:SendListInventory(creature)
        return
    end

    -- 随机武器装甲
    if intid == 11 then
        VendorRemoveAllItems(ICMerchant.entry)
        local equipSql = [[
            SELECT `entry`, `name` FROM item_template 
            WHERE `Quality` > 1 AND `Quality` < 6 
                AND `ItemLevel` <= ]]..(playerLevel + 3)..[[ 
                AND `ItemLevel` >= ]]..(playerLevel - 1)..[[     
                AND (`class` = 2 OR `class` = 4)
            ORDER BY RAND() 
            LIMIT 20;
        ]]
        local equipQ = WorldDBQuery(equipSql)

        if equipQ then
            repeat
                local equipRow = equipQ:GetRow()
                AddVendorItem(ICMerchant.entry, equipRow['entry'], 0, 0, 0)
            until not equipQ:NextRow()
        else
            creature:SendUnitSay("没有找到适合你的武器装备", 0)
        end
        player:SendListInventory(creature)
        return
    end

    if (intid < 0x10) then
        ICMerchant.AddMenu(player, creature, intid)
    else
        -- 先清除生物身上原有的物品，再添加新物品
        VendorRemoveAllItems(ICMerchant.entry)
        local goods = ICMerchant.goods[intid] or {}
        for k, v in pairs(goods) do
            -- print("add item: "..tostring(v))
            AddVendorItem(ICMerchant.entry, v, 0, 0, 0)
        end
        player:SendListInventory(creature)
    end
end

math.randomseed(os.time())
RegisterCreatureGossipEvent(ICMerchant.entry, GOSSIP_EVENT_ON_HELLO, ICMerchant.Book)
RegisterCreatureGossipEvent(ICMerchant.entry, GOSSIP_EVENT_ON_SELECT, ICMerchant.Select)
