
function[] = compow()
    n = 50;
	rMax = 0.5;
	graph = spread_nodes(n);
	creat2Tables(graph, n, rMax);
	draw();
	minR = reduceR();  
	draw();
	countCoverage();
end

function[graph] = spread_nodes(n)
    graph = rand(n,2);
end

function[] = creat2Tables(graph, n, rMax)
    global connectionTable distanceTable;
	connectionTable(1 : n) = 0;       %store the counts of each node's neighbour
	distanceTable(n*(n-1)/2, 3) = 0;  %1:store distance, 2&3:nodes
	for i = 1 : n
        for j = i + 1 : n
		    num = 1;
		    distance = sqrt( (graph(i,1)-graph(j,1))^2 + (graph(i,2)-graph(j,2))^2 );
			if distance < rMax
			    distanceTable(num,1) = distance;
				distanceTable(num,2) = i;
				distanceTable(num,3) = j;
			    connectionTable(i) = connectionTable(i) + 1;
				connectionTable(j) = connectionTable(j) + 1;
			end
		end
	end
end

function[minR] = reduceR()
    global distanceTable;
	sortrows(distanceTable,-1);
	i = 1;
	while 1
	    node1 = distanceTable(i,2);
		node2 = distanceTable(i,3);
		connectionTable(node1) = connectionTable(node1) - 1;
		connectionTable(node2) = connectionTable(node2) - 1;
		if connectionTable(node1) <=0 | connectionTable(node2) <=0
		    minR = distanceTable(i-1,1);
			break;
		end
		i = i + 1;
	end
end
%creat graph
%at max communication range, check whether the graph is connected
%creat a table that includes distance and the node's connected nodes
%sort the table by distance
%form the max distance, remove the connected line and check the num of the 2 nodes' connected nodes. Unitl find a 0.
%creat 100*100 dots and check each one's distance form all nodes. Record if it's covered.
