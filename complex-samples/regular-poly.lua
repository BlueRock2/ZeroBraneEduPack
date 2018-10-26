local turtle  = require("turtle")
local complex = require("complex")
local common  = require("common")
local col     = require("colormap")
local crt     = require("chartmap")

local nSides = 5 -- The sides that the polygon has
local dX, dY = 1,1
local W ,  H = 600, 600
local minX, maxX = -5, 5
local minY, maxY = -5, 5
local greyLevel  = 200
local intX  = crt.New("interval","WinX", minX, maxX, 0, W)
local intY  = crt.New("interval","WinY", minY, maxY, H, 0)
local clGry = colr(greyLevel,greyLevel,greyLevel)
local clB = colr(col.getColorBlueRGB())
local clR = colr(col.getColorRedRGB())
local clBlk = colr(col.getColorBlackRGB())
local scOpe = crt.New("scope"):setInterval(intX, intY):setBorder(minX, maxX, minY, maxY)
      scOpe:setSize(W, H):setColor(clBlk, clGry):setDelta(dX, dY)
local cO = complex.getNew()
local tV = complex.getRegularPolygon(cO, nSides, ((maxX-minX)/(2*nSides))*5)
if(tV) then
  
  common.logStatus("The distance between every grey line on X is: "..tostring(dX))
  common.logStatus("The distance between every grey line on Y is: "..tostring(dY))

  open("Complex regular polygon")
  size(W,H); zero(0, 0); updt(false) -- disable auto updates

  local cM = cO:Mean(tV); for i = 1, #tV do tV[i]:Sub(cM) end
  scOpe:Draw(true, true, true):drawComplexPolygon(tV)
  scOpe:drawComplexCircle(cO:CenterOuterCircle(tV), cO:getSub(tV[1]):getNorm())
  scOpe:drawComplexCircle(cO:CenterInnerCircle(tV), cO:getProjectLine(tV[1], tV[2]):Sub(cO):getNorm())
  wait()
else
  common.logStatus("Your poly parameters are invalid !")
end