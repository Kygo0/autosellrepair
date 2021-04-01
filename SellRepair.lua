local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", function()
      local c = 0
      local sold = 0
      for bag=0,4 do
         for slot=1,GetContainerNumSlots(bag) do
            local l = GetContainerItemLink(bag, slot)
            if l then 
               local item,link,quality,a,b,cat,q,stack,c,icon,cost = GetItemInfo(l)
               if link then
                  --local p = select(11, GetItemInfo(l)*x)
                  if quality then
                     if quality == 0 then 
                        local ic,count,w,x,y,z,link2,stuff=GetContainerItemInfo(bag, slot)
                        local cu = GetMoney(); 
                        local coins = GetCoinTextureString(cost*count,"12")
                        print ("Bag "..bag.. " slot "..slot.." sold "..link.."x"..count.." for "..coins)
                        UseContainerItem(bag, slot)
                        PickupMerchantItem()
                        sold = sold+cost*count
                     end
                     
                  end
               end 
            end
         end
      end
      print("Total junk sold: "..GetCoinTextureString(sold,"12"))
      if c>0 then
         F.Print(L.merchantTrashSell.." "..F.FormatMoney(c)..".")
      end
      if CanMerchantRepair() then
         local cost = GetRepairAllCost()
         if GetMoney() > cost then
            RepairAllItems()
            ChatFrame1:AddMessage("Auto-repaired equipment: "..GetCoinTextureString(cost,"12"))
         else
            ChatFrame1:AddMessage("Can not afford repair bill of: "..GetCoinTextureString(cost,"12"))
         end
      end
end)


function SellGreys()
end

if CanMerchantRepair() then
    local cost = GetRepairAllCost()
    if GetGuildBankWithdrawMoney() >= cost then
    RepairAllItems(1)
    ChatFrame1:AddMessage("Auto-repaired (guild) equipment: "..GetCoinTextureString(cost,"12"))
    elseif GetMoney() >= cost then
    RepairAllItems()
    ChatFrame1:AddMessage("Auto-repaired (self) equipment: "..GetCoinTextureString(cost,"12"))
    else
    ChatFrame1:AddMessage("Can not afford repair bill of: "..GetCoinTextureString(cost,"12"))
    
    end
    end