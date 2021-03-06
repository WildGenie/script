--[[
Title: 30410_MoneyBox_Dialog
Author(s): Spring
Date: 2012/3/18
use the lib:
------------------------------------------------------------
script/apps/Aries/NPCs/MagicMoneyBox/30410_MoneyBox_Dialog.teen.lua
------------------------------------------------------------
]]

-- create class
local libName = "MoneyBox_Dialog";
local MoneyBox_Dialog=commonlib.gettable("MyCompany.Aries.Quest.NPCs.MoneyBox_Dialog");

local GameObject = MyCompany.Aries.Quest.GameObject;
local NPC = MyCompany.Aries.Quest.NPC;

local ItemManager = System.Item.ItemManager;
local hasGSItem = ItemManager.IfOwnGSItem;
local equipGSItem = ItemManager.IfEquipGSItem;

function MoneyBox_Dialog.main()
	local self = MoneyBox_Dialog; 
end

function MoneyBox_Dialog.energystone_main()	
end

function MoneyBox_Dialog.pocket_main()	
end

function MoneyBox_Dialog.star_main()	
end

function MoneyBox_Dialog.star_PreDialog(instance)		
	NPL.load("(gl)script/apps/Aries/Desktop/CombatCharacterFrame/MagicStarPage.lua");
	local MagicStarPage = commonlib.gettable("MyCompany.Aries.Inventory.MagicStarPage");
	MagicStarPage.ShowPage();
	return true;	
end

function MoneyBox_Dialog.energystone_PreDialog(instance)	
	local gsid=998;
    Map3DSystem.mcml_controls.pe_item.OnClickGSItem(gsid,true);
	return true;			
end


function MoneyBox_Dialog.PreDialog(instance)

end

function MoneyBox_Dialog.ShowPage()
	local self = MoneyBox_Dialog; 
	
	System.App.Commands.Call("File.MCMLWindowFrame", {
	url = "script/apps/Aries/NPCs/MagicMoneyBox/MagicMoneyBox.teen.html", 
	name = "GetPMoneyFromMoneyBox", 
	app_key=MyCompany.Aries.app.app_key, 
	isShowTitleBar = false,
	DestroyOnClose = true, -- prevent many ViewProfile pages staying in memory
	style = CommonCtrl.WindowFrame.ContainerStyle,
	zorder = 1,
	allowDrag = true,
	isTopLevel = true,
	directPosition = true,
		align = "_ct",
		x = -410/2,
		y = -489/2,
		width = 410,
		height = 489,
	})
end
