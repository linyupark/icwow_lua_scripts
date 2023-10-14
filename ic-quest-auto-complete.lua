print(">> Script: ic-quest-auto-complete")

ICQuestAC = {}
ICQuestAC.cost = 0.01 -- Set the amount of gold you want to take from the player (0.025 = 2.5%)

function ICQuestAC.complete(player)
    local playerName = player:GetName()
    local playerGold = player:GetCoinage()
    local goldToDeduct = math.floor(playerGold * ICQuestAC.cost)

    local incompleteQuests = {}

    -- Find all incomplete quests for the player
    local questQuery = WorldDBQuery(
        "SELECT `ID`, `LogTitle` FROM  quest_template WHERE ID IN (SELECT quest FROM acore_characters.character_queststatus WHERE guid = " ..
            player:GetGUIDLow() .. " AND status = " .. QUEST_STATUS_INCOMPLETE .. ");")
    if questQuery then
        repeat
            local questRow = questQuery:GetRow()
            local questId = tonumber(questRow["ID"])
            local questTitle = questRow["LogTitle"]

            table.insert(incompleteQuests, {
                id = questId,
                title = questTitle
            })
        until not questQuery:NextRow()
    end

    if #incompleteQuests == 0 then
        player:SendBroadcastMessage(
            "|cFFffffff|cFF00ff00请跑到 |r|cFFffffff 任务附近区域 |cFF00ff00 再试试")
        return
    end

    -- Complete quests and deduce gold for each incomplete quest
    for _, quest in pairs(incompleteQuests) do
        player:CompleteQuest(quest.id)
        player:SendBroadcastMessage(string.format(
            "|cFFffffff|cFF00ff00任务: |r|cFFffffff%s|cFFffffff|cFF00ff00 ID:|r |cFFffffff%d|cFFffffff|cFFffffff 已为你完成",
            quest.title, quest.id))
    end

    -- 设置扣钱的上限不超过1G
    if goldToDeduct > 10000 then
        goldToDeduct = 10000
    end
    player:ModifyMoney(-goldToDeduct)
    player:SendBroadcastMessage("帮助完成任务消耗了你 "..goldToDeduct.." 铜")
end
