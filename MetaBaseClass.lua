-- 我们的类是一个表，它定义了各种属性和方法。
-- 我们的实例也是一个表，然后我们类作为一个元表设置到实例上，并设置类的__index值为自身

-- 访问表的规则/开销所在：
    -- 先在自身表中查找，再到metatable中查找；
    -- 先访问index表，再查找hash表。这个过程类似c++对应的查找方式

MetaBaseClass = {}

function MetaBaseClass:BaseClass()
    local obj = {}
    self.__index = self,
    setmetatable(obj,self)
    return obj
end

function MetaBaseClass:SubClass(class)
    _G[class] = {}
    local obj = _G[class]
    obj.base = self
    obj.__index = self
    setmetatable(obj, self)
end