-- 首次登录奖励
print(">> Script: ic-first-reward")

local function onPlayerFirstLogin(event, player)
  -- 虚空幼龙
  player:LearnSpell(28828)
  -- 4个20格包包
  player:AddItem(41599, 4)
  -- 海狼之戒 戒指装备：通过杀死怪物和完成任务获得的经验值提高5%。
  player:AddItem(50255, 1)
  -- 骑术
  -- player:LearnSpell(33388)
  -- player:LearnSpell(33391)
  -- player:LearnSpell(34090)
  -- player:LearnSpell(54197)
  -- player:LearnSpell(34091)
end

RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, onPlayerFirstLogin)