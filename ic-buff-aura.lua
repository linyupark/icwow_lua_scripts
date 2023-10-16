-- 提供增益相关
print(">> Script: ic-buff-aura")

ICBuffAura = {}

ICBuffAura.check = 12178

ICBuffAura.ids = {
  26393, -- 艾露恩的祝福 10% Stats 1小时
  48074, -- 精神祷言 精神提高80点。 1h
  -- 43223, -- 强效国王祝福 属性提高10% 30m
  -- 36880, -- 奥术智慧 智力提高100点。30m
  10669, -- 厚甲蝎之击使用后敏捷提高25点，效果持续60分钟。战斗药剂。
  10693, -- 精神矍铄 使用后精神提高25点，效果持续60分钟。守护药剂。
  12178, -- 使目标的耐力提高25点，持续30 分钟。
}


function ICBuffAura.add(player)
  if not player:HasAura(ICBuffAura.check) then
    for k, v in pairs(ICBuffAura.ids) do
      player:AddAura(v, player)
    end
    player:SendBroadcastMessage("你感觉到充满了力量...")
  else
    player:SendBroadcastMessage("你的力量还没有消失...")
  end
end