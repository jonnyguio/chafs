local Vector = {}

function Vector.dist(p1, p2)
    return math.pow(math.pow(math.abs(p1.x - p2.x), 2) + math.pow(math.abs(p1.y - p2.y), 2), 1 / 2)
end

return Vector
