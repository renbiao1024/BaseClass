require("MetaBaseClass")
require("CopyBaseClass")


MetaFather = MetaBaseClass:BaseClass()
MetaFather.age = 50
MetaFather.name = "father"

CopyFather = {
    age = 50,
    name = "father"
}

function test1(a)
    local t1 = os.clock()
    for i = 0, 100000 do
        if(a == 1)then
            MetaFather:SubClass("meta_class"..tostring(i))
        else
            DeepCopy("copy_class"..tostring(i), CopyFather)
        end
    end
    local t2 = os.clock()
    print(tostring(t2-t1))
end


MetaFather:SubClass("meta_class")
DeepCopy("copy_class", CopyFather)

function test2(a)
    local t1 = os.clock()
    for i = 0, 10000 do
        if(a == 1)then
            meta_class.age = 10
        else
            copy_class.age = 10
        end
    end
    local t2 = os.clock()
    print(tostring(t2-t1))
end

--test1(1)    -- 0.15
--test1(2)    -- 0.4
-- 创建的时候，meta的基类要快于深拷贝的基类
-- 原因是，创建的时候meta只需要引用一个基类表即可，而copy需要将所有的属性和函数都复制一份到新的表。类内容越多创建时间相差的越多



test2(1)
test2(2)
-- 次数         meta平均时长    copy平均时长      rate
--100000000     1.36            1.22            1.115
--1000000       0.0133          0.0123          1.08      

-- 获取属性的时候，meta的基类要慢于深拷贝的基类。但是类内容多的时候，相差的时间不会增加很多，因为开销只是多了一次访问表的操作 
-- 嵌套的类越多，这个查找的消耗就越大