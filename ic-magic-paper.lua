-- https://github.com/michaelbirdtx/lua_scripts/blob/main/magicSlate.lua

-- require("ic-ambush")
-- require("ic-buff-aura")
-- require("ic-level-up")

print(">> Script: ic-magic-paper")

local PAPER_ENTRY = 25750

local function OnLogin(event, player)
    if (event) then
        player:SendBroadcastMessage("ICWOW模块 |cff4CFF00便利图纸|r 已运行.")
    end
    if (not player:HasItem(PAPER_ENTRY)) then
        player:AddItem(PAPER_ENTRY)
        player:SendBroadcastMessage("便利图纸已经发放到背包.")
    end
    
end

local function onHelloMagicSlate(event, player, object)
    player:GossipClearMenu()
    player:GossipSetText("\"如意如意，随我心意，快快显灵...\"")
    player:GossipMenuAddItem(6, "\"...查看银行.\"", 1, 1)
    player:GossipMenuAddItem(7, "\"...怪物伏击开关(当前: ".. (player:GetData("Ambush.state") or "off") ..").\"", 1, 2)
    player:GossipMenuAddItem(4, "\"...我是速成鸡(直接 "..ICLvup.MaxPlayerLevel.." 级).\"", 1, 3)
    player:GossipMenuAddItem(2, "\"...请赐予我力量吧!\"", 1, 4)
    player:GossipSendMenu(0x7FFFFFFF, player, PAPER_ENTRY)
    player:PlayDirectSound(12889, player)
end

local function onSelectMagicSlate(event, player, object, sender, intid, code, menu_id)
    player:GossipComplete()
    if intid == 1 then
        player:SendShowBank(player)
    elseif intid == 2 then
        -- player:SendShowMailBox(player:GetGUID())
        if (player:GetData("Ambush.state") or "off") == "off" then
            Ambush.LoopFight({20000, 40000}, player)
        else
            player:SetData("Ambush.state", "off")
        end
    elseif intid == 3 then
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
        player:SendBroadcastMessage("如你所愿～你这只鸡比KFC还早熟")
    elseif intid == 4 then
        ICBuffAura.add(player)
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
RegisterItemGossipEvent(PAPER_ENTRY, 1, onHelloMagicSlate)
RegisterPlayerGossipEvent(PAPER_ENTRY, 2, onSelectMagicSlate)

