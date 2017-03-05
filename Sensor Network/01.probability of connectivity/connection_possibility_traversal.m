
function []= connection_possibility_traversal()
    global visited;
    visited(1 : 100) = 0;
    visited(1) = 1;
    case1();
    case2();
end

function [] = case1()
    n = 10;
    connect = 0;
    chart(1 : 50) = 0;
    for i = 1 : 4
        for k = 1 : 50
            r = k/50;
            for j = 1 : 1000
                graph = spread_nodes(n);  %spread the nodes randomly
                adjacency_table = creat_adjacency_table(n, graph, r);  %creat adjacency matrix
                graph_traversal(1, adjacency_table, n)  %traverse the graph from the 1st node
                if judge(n)  %judge if the graph is connected
                    connect = connect + 1;
                end
            end
            chart(k) = connect/1000;  %save the possibility as y
            connect = 0;
        end
        n = n * 2;
    draw(chart, 1, i)
    chart(1 : 50) = 0;
    end
end

function [] = case2()
    r = 0.05;
    connect = 0;
    chart(1 : 50) = 0;
    for i = 1 : 5
        for k = 1 : 50
            n = k * 2;
            for j = 1 : 1000
                graph = spread_nodes(n);  %spread the nodes randomly
                adjacency_table = creat_adjacency_table(n, graph, r);  %creat adjacency matrix
                graph_traversal(1, adjacency_table, n)  %traverse the graph from the 1st node
                if judge(n)  %judge if the graph is connected
                    connect = connect + 1;
                end
            end
            chart(k) = connect/1000;  %save the possibility as y
            connect = 0;
        end
        r = r + 0.1;
    draw(chart, 2, i)
    chart(1 : 50) = 0;
    end
end

function[graph] = spread_nodes(n)
    graph = rand(n,2);
end

function[adjacency_table] = creat_adjacency_table(n, graph, r)
    adjacency_table(n , n + 1) = 0;
	adjacency_table(:, n + 1) = 1;  %n+1 is a pointer
    for i = 1 : n
        for j = i + 1 : n
            if (sqrt( (graph(i,1)-graph(j,1))^2 + (graph(i,2)-graph(j,2))^2 ) < r);
                adjacency_table(i,adjacency_table(i,n+1) ) = j;
				adjacency_table(i,n+1) = adjacency_table(i,n+1) + 1;
                adjacency_table(j,adjacency_table(j,n+1) ) = i;
				adjacency_table(j,n+1) = adjacency_table(j,n+1) + 1;
            end
            %turn to adjacency matrix
        end
    end
end

function[] = graph_traversal(current_node, adjacency_table, n)
    global visited;
    for i = 1 : adjacency_table(current_node, n+1) - 1
        if visited(adjacency_table(current_node, i)) == 0
            visited(adjacency_table(current_node, i)) = 1;
            graph_traversal(adjacency_table(current_node, i), adjacency_table, n);
        end
    end
end

function[result] = judge(n)
    global visited
    result = 0;
    total_num = 0;
    for i = 1 : n
        total_num = visited(n) + total_num;
        if ~visited(n)
            break
        end
    end
    if total_num == n
        result = 1;
    end
    visited(:) = 0;
    visited(1) = 1;
end

function[] = draw(chart, plot_num, i)
        line = '*^+ox';
		x(1) = 0;
		x(2:51) = 0.02 : 0.02 : 1;
        y(1) = 0;
		y(2:51) = chart(1 : 50);
        subplot(2,1,plot_num);
        plot(x,y,['-',line(i)])
        hold on
end
