
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
	chart(1 : 20) = 0;
	for i = 1 : 4
		for k = 1 : 20
            r = k/20;
			for j = 1 : 1000
				graph = spread_nodes(n);  %spread the nodes randomly
				adjacency_matrix = creat_adjacency_matrix(n, graph, r);  %creat adjacency matrix
                graph_traversal(1, adjacency_matrix, n)  %traverse the graph from the 1st node
                if judge(n)  %judge if the graph is connected
                    connect = connect + 1;
                end
			end
			chart(k) = connect/1000;  %save the possibility as y
            connect = 0;
		end
		n = n * 2;
	draw(chart, 1)
	chart(1 : 20) = 0;
	end
end

function [] = case2()
    r = 0.05;
	connect = 0;
	chart(1 : 20) = 0;
	for i = 1 : 5
		for k = 1 : 20
            n = k * 5;
			for j = 1 : 1000
				graph = spread_nodes(n);  %spread the nodes randomly
				adjacency_matrix = creat_adjacency_matrix(n, graph, r);  %creat adjacency matrix
                graph_traversal(1, adjacency_matrix, n)  %traverse the graph from the 1st node
                if judge(n)  %judge if the graph is connected
                    connect = connect + 1;
                end
			end
			chart(k) = connect/1000;  %save the possibility as y
            connect = 0;
		end
		r = r + 0.1;
	draw(chart, 2)
	chart(1 : 20) = 0;
	end
end

function[graph] = spread_nodes(n)
    graph = rand(n,2);
end

function[adjacency_matrix] = creat_adjacency_matrix(n, graph, r)
	adjacency_matrix(n : n) = 0;
	for i = 1 : n
        for j = 1 : n
		    adjacency_matrix(i,j) = sqrt( (graph(i,1)-graph(j,1))^2 + (graph(i,2)-graph(j,2))^2 );
			%calculate all the distances
			if adjacency_matrix(i,j) <= r
			    adjacency_matrix(i,j) = 1;
			else
			    adjacency_matrix(i,j) = 0;
			end
			%turn to adjacency matrix
        end
	end
end

function[] = graph_traversal(current_node, adjacency_matrix, n)
    global visited;
    for next_node = 2 : n
        if ((adjacency_matrix(current_node,next_node) == 1) && (visited(next_node) == 0) && (next_node ~= current_node) )
		    visited(next_node) = 1;
			graph_traversal(next_node, adjacency_matrix, n);
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

function[] = draw(chart, plot_num)
	    x = 0.05 : 0.05 : 1;  
	    y = chart(1 : 20);  
	    subplot(2,1,plot_num);
		plot(x,y)
		hold on
end
