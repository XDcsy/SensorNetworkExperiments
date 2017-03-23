
function[] = compow()
    n = 10;
    rMax = 0.8;
    graph = spread_nodes(n);
    creat2Tables(graph, n, rMax);
    draw(1, graph);
    minR = reduceR(n);
    ratio = countCoverage(graph, minR, n);
    disp(num2str(ratio));
    disp(num2str(minR));
    draw(2, graph, minR);
    title(['ratio:',num2str(ratio),' minR:',num2str(minR)]);
    clear global;
end

function[graph] = spread_nodes(n)
    graph = rand(n,2);
end

function[] = creat2Tables(graph, n, rMax)
    global adjacency_matrix distanceTable visited;
    visited(1 : n) = 0;
    visited(1) = 1;
    distanceTable(1:n*(n-1)/2, 1:3) = -1;
    adjacency_matrix(n, n) = 0;
    num = 1;
    for i = 1 : n
        for j = i + 1 : n
            distance = sqrt( (graph(i,1)-graph(j,1))^2 + (graph(i,2)-graph(j,2))^2 );
            if (distance <= rMax)
                adjacency_matrix(i,j) = 1;
                adjacency_matrix(j,i) = 1;
                distanceTable(num,1) = distance;
                distanceTable(num,2) = i;
                distanceTable(num,3) = j;
            end
            num = num + 1;
        end
    end
    distanceTable = sortrows(distanceTable,-1);
    graph_traversal(1, n);
    if ~judge()
        error('The graph is not connected even at max communication range.');
    end
end

function[] = graph_traversal(current_node, n)
    global visited adjacency_matrix;
    for next_node = 2 : n
        if ((adjacency_matrix(current_node,next_node) == 1) && (visited(next_node) == 0) && (next_node ~= current_node) )
            visited(next_node) = 1;
            graph_traversal(next_node, n);
        end
    end
end

function[minR] = reduceR(n)
    global adjacency_matrix distanceTable;
    i = 1;
    while 1
        node1 = distanceTable(i,2);
        node2 = distanceTable(i,3);
        adjacency_matrix(node1, node2) = 0;
        adjacency_matrix(node2, node1) = 0;
        graph_traversal(1, n);
        if ~judge()
            minR = distanceTable(i-1,1);
            break;
        end
        i = i + 1;
    end
end

function[result] = judge()
    global visited
    result = 0;
    if isempty(find(visited == 0,1))
        result = 1;
    end
    visited(:) = 0;
    visited(1) = 1;
end

function[] = draw(n, graph, minR)
    global distanceTable
    x = graph(:,1);
    y = graph(:,2);
    subplot(1,2,n);
    plot(x,y,'ro');
    axis square;
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
