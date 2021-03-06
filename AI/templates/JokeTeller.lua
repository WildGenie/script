--[[ template<waitseconds = nil> SimpleSayHello character
author: WangTian
date: 2006.9.9
desc: Joke teller
usage:
==On_Load==
;NPL.load("(gl)script/AI/AndyTemplates/JokeTeller.lua");_AI_templates.JokeTeller.On_Load();

==On_EnterSentientArea==
;NPL.load("(gl)script/AI/AndyTemplates/JokeTeller.lua");_AI_templates.JokeTeller.On_EnterSentientArea();

==On_LeaveSentientArea==
;NPL.load("(gl)script/AI/AndyTemplates/JokeTeller.lua");_AI_templates.JokeTeller.On_LeaveSentientArea();

==On_Click==[optional]
;NPL.load("(gl)script/AI/AndyTemplates/JokeTeller.lua");_AI_templates.JokeTeller.On_Click();

]]

NPL.load("(gl)script/ide/headon_speech.lua");

if(not _AI_templates) then _AI_templates={}; end
if(not _AI_templates.JokeTeller) then _AI_templates.JokeTeller={}; end

--[[ optional
tell every one "I can tell jokes" every 10 seconds using sequence controller
@param waitseconds: if nil, it will be 10.
]]
function _AI_templates.JokeTeller.On_Load(waitseconds)
	local player = ParaScene.GetObject(sensor_name);
	if(player:IsValid() == true) then 
		local playerChar = player:ToCharacter();
		playerChar:AssignAIController("face", "true");
		
		local att = player:GetAttributeObject();
		att = player:GetAttributeObject();
		att:SetField("Sentient Radius", 10);
	
		if(waitseconds == nil) then
			waitseconds = 10;	
		end
		
		-- Set Sentient Radius
		
		-- tell every one "I can tell jokes" every 10 seconds
		local s = playerChar:GetSeqController();
		-- delete all previous keys
		s:DeleteKeysRange(0,-1);
		s:SetStartFacing(0);
		-- add keys
		s:BeginAddKeys();
		s:Lable("start");
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "小朋友, 我会讲笑话, 想听就过来 ^_^", 3);]], sensor_name));
		s:Goto("start");
		s:EndAddKeys();
	end
end

--[[
Speek "Hello" for 4 seconds, when the character perceives another character for waitseconds long. It will wait another 10 seconds before speeking again.
@remark: AI memory is used and demostrated here.
@param waitseconds: if nil, it will be 5 seconds.
]]
function _AI_templates.JokeTeller.On_EnterSentientArea(waitseconds)
	local player = ParaScene.GetObject(sensor_name);
	if(player:IsValid() == true) then 
		local playerChar = player:ToCharacter();
		
		if(waitseconds == nil) then
			waitseconds = 5;	
		end
		
		-- tell one piece of joke every 5 seconds
		local s = playerChar:GetSeqController();
					
		-- delete all previous keys
		s:DeleteKeysRange(0,-1);
		s:SetStartFacing(0);
		-- add keys
		s:BeginAddKeys();
					
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "你好！", 3);]], sensor_name));
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "来听我讲的笑话吧", 3);]], sensor_name));
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "不要乱动, 乱动可要重讲哦", 3);]], sensor_name));
		s:Wait(waitseconds);
		
		
		local period = 10;
		-- add Joke1 keys
		Joke1(s, period);
					
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "怎么样, 这个笑话有意思么", 3);]], sensor_name));
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "我再给你讲一个: ", 3);]], sensor_name));
		s:Wait(waitseconds);
		
		-- add Joke2 keys
		Joke2(s, period);
					
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "我的笑话讲完了", 3);]], sensor_name));
		s:Wait(waitseconds);
		s:Exec(string.format([[;headon_speech.Speek("%s", "欢迎下次再来听哦 :)", 3);]], sensor_name));
		
					
		s:EndAddKeys();
	end -- if(player:IsValid() == true) then
end

function _AI_templates.JokeTeller.On_LeaveSentientArea()
	local player = ParaScene.GetObject(sensor_name);
	if(player:IsValid() == true) then
		-- delete all previous keys
		local playerChar = player:ToCharacter();
		local s = playerChar:GetSeqController();
		s:DeleteKeysRange(0,-1);
		headon_speech.Speek(sensor_name, "我的笑话有意思么, 下次再来听笑话 :)", 4);
		
		-- delete all previous keys
		s:DeleteKeysRange(0,-1);
		s:SetStartFacing(0);
		-- add keys
		s:BeginAddKeys();
		s:Lable("start");
		s:Wait(10);
		s:Exec(string.format([[;headon_speech.Speek("%s", "小朋友, 我会讲笑话, 想听就过来 ^_^", 3);]], sensor_name));
		s:Goto("start");
		s:EndAddKeys();
	end
end

-- just say something
function _AI_templates.JokeTeller.On_Click()
	headon_speech.Speek(sensor_name, "你叫我有事么！我在讲笑话", 4);
end

function Joke1(s, waitseconds)
	s:Exec(string.format([[;headon_speech.Speek("%s", "11111", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "22222", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "33333", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "44444", 5);]], sensor_name));
end

function Joke2(s, waitseconds)
	s:Exec(string.format([[;headon_speech.Speek("%s", "55555", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "66666", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "77777", 5);]], sensor_name));
	s:Wait(waitseconds);
	s:Exec(string.format([[;headon_speech.Speek("%s", "88888", 5);]], sensor_name));
end