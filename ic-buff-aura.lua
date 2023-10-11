-- 提供增益相关
print(">> Script: ic-buff-aura")

ICBuffAura = {}

ICBuffAura.check = 26393

ICBuffAura.ids = {
  23735, -- 塞格的黑暗塔罗牌 of Strength 2小时
  23737, -- 塞格的黑暗塔罗牌 of Stamina
  23738, -- 塞格的黑暗塔罗牌 of Spirit
  23769, -- 塞格的黑暗塔罗牌 of Resistance
  23766, -- 塞格的黑暗塔罗牌 of Intelligence
  23768, -- 塞格的黑暗塔罗牌 of Damage
  23767, -- 塞格的黑暗塔罗牌 of Armor
  23736, -- 塞格的黑暗塔罗牌 of Agility
  26393, -- 艾露恩的祝福 10% Stats 1小时
  48074 -- 精神祷言 精神提高80点。 1h
  -- 43223, -- 强效国王祝福 属性提高10% 30m
  -- 36880, -- 奥术智慧 智力提高100点。30m
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