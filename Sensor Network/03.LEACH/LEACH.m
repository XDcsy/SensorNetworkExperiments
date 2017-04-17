classdef node
    properties
	    coordinate;
        randnum;
		ishead;
        wasElected;
		head;
        power;
	end
	methods
	    function[obj] = node(obj, power)
		    obj.coordinate = rand(1,2);
            obj.randnum = rand();
			obj.ishead = 0;
            obj.wasElected = 0;
            obj.power = power;
		end
		function[] = elect(obj, T)
		    if obj.ishead == 1
                obj.ishead = 0;
            end
            if obj.wasElected == 0 && randnum < T
			    obj.ishead = 1;
                obj.head = obj;
                obj.wasElected = 1;
            else
                findHead(obj);
            end
		end
        function[] = transmit(obj, nodecost, headcost)
            if obj.ishead
                power = power - headcost;
            else
                power = power - nodecost;
	end
end

num = 50;
pow = 100;
nodecost = 1
allnodes(1 : num) = node(pow)