local Map = {}
Map.__index = Map

local POS_ON_FILE = {}

function Map.new(file, width, height, config)
    local inst = {}
    setmetatable(inst, Map)

    inst.file = file
    inst.width = width
    inst.height = height
    inst.config = config

    POS_ON_FILE.coordinates = 0
    POS_ON_FILE.info = (width * height * 4) + width

    return inst
end

function Map:open()
    if type(self.file) == "string" then
        self.file = io.open(self.file, "rb+") or self.file
        if type(self.file) == "string" then

            print(self.file .. " doesn't exist, creating...")
            self.file = assert(io.open(self.file, "wb"))
            local coordinates = {}
            for i = 1, self.width do
                coordinates[i] = {}
                for j = 1, self.height do
                    coordinates[i][j] = 0
                end
            end
            print( "--- end")

            self:write(coordinates, "coordinates-all")
            self:write("data", "info")
        end
    end
end

function Map:write(data, t)
    if t == "coordinates-all" then
        self.file:seek("set", POS_ON_FILE.coordinates)
        for i = 1, self.width do
            for j = 1, self.height do
                self.file:write(string.format("%03x ", data[i][j]))
            end
            self.file:write("\n")
        end
    elseif t == "info" then
        self.file:seek("set", POS_ON_FILE.info)
        print(data)
        self.file:write(data)
    end
end

function Map:close()
    print(type(self.file))
    assert(self.file:close())
end

return Map;
