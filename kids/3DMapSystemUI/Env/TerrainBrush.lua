--[[
Title: TerrainBrush
Author(s): LiXizhi
Date: 2009/1/31
Desc: terrain form brush data structure only. Keeping the dafault brush settings. 
use the lib:
------------------------------------------------------------
NPL.load("(gl)script/kids/3DMapSystemUI/Env/TerrainBrush.lua");
brush = Map3DSystem.App.Env.TerrainBrush:new({})
-- well known brushes
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["GaussionHill"]
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["Flatten"]
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["RadialScale"]
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["Roughen_Smooth"]
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["SetHole"]
brush = Map3DSystem.App.Env.TerrainBrush.Brushes["Ramp"]
------------------------------------------------------------
]]

NPL.load("(gl)script/kids/3DMapSystemUI/Env/TerrainBrushMarker.lua");
local TerrainBrushMarker = Map3DSystem.App.Env.TerrainBrushMarker;

local TerrainBrush = {
	filtername = nil,
	BrushSize = 10, 
	BrushStrength = 0.1,
	BrushSoftness = 0.5,
	
	FlattenOperation = 2,
	Elevation = 0,
	gaussian_deviation = 0.9,
	HeightScale = 3,
};
commonlib.setfield("Map3DSystem.App.Env.TerrainBrush", TerrainBrush)

function TerrainBrush:new (o)
	o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

-- refresh the terrain marker
function TerrainBrush:RefreshMarker()
	if(self.filtername ~= nil) then
		TerrainBrushMarker.DrawBrush({x=self.x,y=self.y,z=self.z,radius=self.BrushSize});
	end	
end

-- clear the terrain marker
function TerrainBrush:ClearMarker()
	TerrainBrushMarker.Clear();
end

-- some known brushes
TerrainBrush.Brushes= {
	["GaussionHill"] = TerrainBrush:new({
			filtername = "GaussianHill",
			BrushSize = 10, 
			BrushStrength = 0.1,
			BrushSoftness = 0.5,
			gaussian_deviation = 0.9,
			HeightScale = 3,
		}),
	["Flatten"] = TerrainBrush:new({
			filtername = "Flatten",
			BrushSize = 5, 
			BrushStrength = 0.1,
			BrushSoftness = 0.5,
			
			FlattenOperation = 2,
			Elevation = 0,
		}),
	["Roughen_Smooth"] = TerrainBrush:new({
			filtername = "Roughen_Smooth",
			BrushSize = 4, 
			BrushStrength = 0.1,
			BrushSoftness = 0.5,
		}),
	["RadialScale"] = TerrainBrush:new({
			filtername = "RadialScale",
			BrushSize = 20, 
			BrushStrength = 0.1,
			BrushSoftness = 0.5,
			HeightScale = 3,
		}),
	["SetHole"] = TerrainBrush:new({
			filtername = "SetHole",
			BrushSize = 2, 
			BrushStrength = 0.1,
			BrushSoftness = 0.5,
		}),
	["Ramp"] = TerrainBrush:new({
			filtername = "SetHole",
			filtername = "Ramp",
			BrushSize = 5, 
			BrushStrength = 0.3,
			BrushSoftness = 0.1,
		}),	
}

-- overwrite the marker function
function TerrainBrush.Brushes.Ramp:RefreshMarker()
	if(self.filtername ~= nil) then
		TerrainBrushMarker.DrawRamp({x1=self.x1,z1=self.z1,x=self.x,z=self.z,radius=self.BrushSize});
	end	
end