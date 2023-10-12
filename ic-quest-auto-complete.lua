print(">> Script: ic-quest-auto-complete")

ICQuestAC = {}
ICQuestAC.cost = 0.01 -- Set the amount of gold you want to take from the player (0.025 = 2.5%)

function ICQuestAC.complete(player)
    local playerName = player:GetName()
    local playerGold = player:GetCoinage()
    local goldToDeduct = math.floor(playerGold * ICQuestAC.cost)

    local incompleteQuests = {}

    -- Find all incomplete quests for the player
    local questQuery =
    WorldDBQuery(
        "SELECT `ID`, `Title` FROM  acore_world.quest_template_locale WHERE ID IN (SELECT quest FROM acore_characters.character_queststatus WHERE guid = "
        ..player:GetGUIDLow() .. " AND status = " .. QUEST_STATUS_INCOMPLETE .. ") AND `locale` = 'zhCN';"
    )
    if questQuery then
        repeat
            local questRow = questQuery:GetRow()
            local questId = tonumber(questRow["ID"])
            local questTitle = questRow["Title"]

            table.insert(incompleteQuests, { id = questId, title = questTitle })
        until not questQuery:NextRow()
    end

    if #incompleteQuests == 0 then
        player:SendBroadcastMessage(
            "|cFFffffff|cFF00ff00这世上 |r|cFFffffff 还没有你没完成的任务呢. |cFF00ff00"
        )
        return
    end

    -- Complete quests and deduce gold for each incomplete quest
    for _, quest in pairs(incompleteQuests) do
        player:CompleteQuest(quest.id)
        player:ModifyMoney(-goldToDeduct)

        player:SendBroadcastMessage(
            string.format(
                "|cFFffffff|cFF00ff00任务: |r|cFFffffff%s|cFFffffff|cFF00ff00 ID:|r |cFFffffff%d|cFFffffff|cFFffffff 已为你完成"
                ,
                quest.title,
                quest.id
            )
        )
        player:SendBroadcastMessage(
            string.format(
                "|cFFffffff|cFF00ff00无形的手从你身上 |r|cFFffffff 夺取了 |cFFffffff|cFF00ff00%.2f%%|r|cFFffffff 数量的 |cFF00ff00%d|r|cFFffffff 钱"
                ,
                ICQuestAC.cost * 100,
                goldToDeduct
            )
        )
    end
end