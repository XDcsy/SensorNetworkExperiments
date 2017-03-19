function[] = exact_compow()
    n = 10;
    rMax = 0.8;
    graph = spread_nodes(n);
    creat2Tables(graph, n, rMax);
    draw(1, graph);
    minR = reduceR();
    draw(2, graph, minR);
    ratio = countCoverage(graph, minR, n);
    disp(num2str(ratio));
    clear global;
end

function[graph] = spread_nodes(n)
    graph = rand(n,2);
end

function[] = creat2Tables(graph, n, rMax)
    global connectionTable distanceTable;
    connectionTable(1 : n) = 0;       %store the counts of each node's neighbour
    distanceTable(1:n*(n-1)/2, 1:3) = -1;  %1:store distance, 2&3:nodes
    num = 1;
    for i = 1 : n
        for j = i + 1 : n
            distance = sqrt( (graph(i,1)-graph(j,1))^2 + (graph(i,2)-graph(j,2))^2 );
            if distance <= rMax && distance >= 0
                distanceTable(num,1) = distance;
                distanceTable(num,2) = i;
                distanceTable(num,3) = j;
                connectionTable(i) = connectionTable(i) + 1;
                connectionTable(j) = connectionTable(j) + 1;
            end
            num = num + 1;
        end
    end
    distanceTable = sortrows(distanceTable,-1);
    if ~isempty(find(connectionTable == 0,1));
        error('The graph is not connected even at max communication range.');
    end
end

function[minR] = reduceR()
    global distanceTable connectionTable;
    i = 1;
    while 1
        node1 = distanceTable(i,2);
        node2 = distanceTable(i,3);
        connectionTable(node1) = connectionTable(node1) - 1;
        connectionTable(node2) = connectionTable(node2) - 1;
        if connectionTable(node1) <=0 || connectionTable(node2) <=0
            minR = distanceTable(i-1,1);
            break;
        end
        i = i + 1;
    end
end

function[] = draw(n, graph, minR)
    global distanceTable
    x = graph(:,1);
    y = graph(:,2);
    subplot(2,1,n);
    plot(x,y,'ro');
    i = 1;
    if n==2
        while distanceTable(i,1) > minR
            i = i+1;
        end
    end
    node1 = distanceTable(i,2);
    node2 = distanceTable(i,3);
    while node1 ~=-1
        hold on;
        line ([x(node1) x(node2)],[y(node1) y(node2)]);
        i = i+1;
        node1 = distanceTable(i,2);
        node2 = distanceTable(i,3);
    end
end

function[ratio] = countCoverage(graph, minR, n)
    coveredNodes = 0;
    for x = 0 : 0.01 : 1
        for y = 0 : 0.01 : 1
            for node = 1 : n
                if sqrt( (graph(node,1)-x)^2 + (graph(node,2)-y)^2 ) < minR
                    coveredNodes = coveredNodes + 1;
                    break;
                end
            end
        end
    end
    ratio = coveredNodes/(101*101);
end