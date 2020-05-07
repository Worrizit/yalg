local ContainerBase = require("ContainerBase")

local HDiv = ContainerBase:extend()
HDiv.type = "HDiv"

HDiv.baseStyle = {
    placement = "fill",
}
setmetatable(HDiv.baseStyle, {__index=ContainerBase.baseStyle})

function HDiv:getContentDimensions()
    local maxW = 0
    local maxH = 0
    for _, W in ipairs(self.items) do
        local w, h = W:getMinDimensions()
        maxW = math.max(maxW, w)
        maxH = math.max(maxH, h)
    end
    return maxW * #self.items + self.style.gap*(#self.items - 1), maxH
end


function HDiv:calculateGeometry(x, y, w, h)
    ContainerBase.calculateGeometry(self, x, y, w, h)
    local gap = self.style.gap
    local xB, yB, wB, hB = self:getContentBox()
    local cellW = (wB+gap) / #self.items - gap
    local cellH = hB
    for i, W in ipairs(self.items) do
        W:calculateGeometry(xB+(i-1)*(cellW + gap), yB, cellW, cellH)
    end
end

return HDiv
