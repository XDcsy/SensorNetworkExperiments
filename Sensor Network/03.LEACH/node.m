classdef node < handle
    %UNTITLED3 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        coordinate;
        randnum;
        ishead;
        wasElected;
        head;
        power;
    end
    
    methods
        function[obj] = node(pow)
            obj.coordinate = rand(1,2);
            obj.randnum = rand();
            obj.ishead = 0;
            obj.wasElected = 0;
            obj.power = pow;
        end
        function[] = reSet(obj)
            obj.head = [];
            obj.randnum = rand();
        end
        function[] = elect(obj, T)
            if obj.ishead == 1  %清空上一轮的簇头
                obj.ishead = 0;
                return;
            end
            if ((obj.wasElected == 0) && (obj.randnum < T))  %满足被选为簇头的条件
                obj.ishead = 1;
                obj.wasElected = 1;
            end
        end
        function[] = findhead(obj, headnodes, range, cost)
            distance = 2;
            for i = 1 : length(headnodes)
                tmp = sqrt(sum((obj.coordinate - headnodes(i).coordinate).^2));
                if tmp < distance
                    distance = tmp;
                    obj.head = headnodes(i);
                end
                if distance < range  %距离小于通信距离时，节点接收到信号
                    obj.recive(cost);
                end
            end
        end
        function[] = send(obj, cost)
            obj.power = obj.power - cost;
        end
        function[] = recive(obj, cost)
            obj.power = obj.power - cost;
        end
    end
    
end

