classdef node < handle
    %UNTITLED3 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
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
            if obj.ishead == 1  %�����һ�ֵĴ�ͷ
                obj.ishead = 0;
                return;
            end
            if ((obj.wasElected == 0) && (obj.randnum < T))  %���㱻ѡΪ��ͷ������
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
                if distance < range  %����С��ͨ�ž���ʱ���ڵ���յ��ź�
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

