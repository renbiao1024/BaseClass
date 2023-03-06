-- 遍历父类表的内容，在子类全部创建一份

function DeepCopy(class, baseClass)
    if baseClass == nil then
        baseClass = {}
    end

    _G[class] = clone(baseClass)
    _G[class].base = baseClass
end

function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local newObject = {}
        lookup_table[object] = newObject
        for key, value in pairs(object) do
            newObject[_copy(key)] = _copy(value)
        end
        return setmetatable(newObject, getmetatable(object))
    end
    return _copy(object)
end