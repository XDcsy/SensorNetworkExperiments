clear;
energyLeft = 1;
round = 0;
num = 100;  %节点数目
pow = 5000;  %总能量
P = 0.1;
range = 1;  %节点接收此范围内的簇头广播
times = 10;  %每轮发送数据次数
sendCost = 2;  %节点间发送一次数据的能量消耗
receiveCost = 1;  %节点间接收一次数据的能量消耗
broadcastCost = 4;  %簇头节点向周围广播的能量消耗
remoteRransmitCost = 100;  %簇头节点远距离通信的能量消耗

for i = 1 : num
    nodes(i) = node(pow);
end
while energyLeft
    if mod(round,1/P) == 0 && round ~= 0  %在1/p轮后，所有节点再次可以被选为簇头
        for i = 1 : num
            nodes(i).wasElected = 0;
        end
    end
    
    T = P/(1-P*mod(round,1/P));
    headnodes = [];
    nothaednodes = [];
    for i = 1 : num  %每一轮开始时清空上一轮的簇头记录，并且重新产生随机数
        nodes(i).reSet();
    end
    for i = 1 : num  %选举簇头
        nodes(i).elect(T);
        if nodes(i).ishead
            headnodes = [headnodes nodes(i)];
        else
            nothaednodes = [nothaednodes nodes(i)];
        end
    end
    for i = 1 : length(headnodes)  %簇头广播
        headnodes(i).send(broadcastCost);
    end
    for i = 1 : num  %各节点接收广播信号，找到所属簇头
        nodes(i).findhead(headnodes, range, receiveCost)
    end
    for i = 1 : length(nothaednodes)  %非簇头节点通知各自簇头，各簇头接收
        nothaednodes(i).send(sendCost);
        nothaednodes(i).head.recive(receiveCost);
    end
    for i = 1 : times  %完成一轮的数据收发
        for j = 1 : length(nothaednodes)  %非簇头节点发送，各簇头接收
            nothaednodes(j).send(sendCost);
            nothaednodes(j).head.recive(receiveCost);
        end
        for j = 1 : length(headnodes)  %簇头节点远程发送
            headnodes(j).send(remoteRransmitCost);
        end
    end
    for i = 1 : num  %检查各节点剩余能量
        if nodes(i).power <= 0
            energyLeft = 0;
            break;
        end
    end
    figure();
    for i = 1 : num
        if nodes(i).ishead  %将此轮的簇头、曾当选过簇头的节点和其他节点分别表示
            plot(nodes(i).coordinate(1),nodes(i).coordinate(2),'ro');
        else
            if nodes(i).wasElected
                plot(nodes(i).coordinate(1),nodes(i).coordinate(2),'r+');
            else
                plot(nodes(i).coordinate(1),nodes(i).coordinate(2),'r.');
            end
        end
        line ([nodes(i).coordinate(1) nodes(i).head.coordinate(1)],[nodes(i).coordinate(2) nodes(i).head.coordinate(2)]);
        hold on;
    end
    axis square;
    title(['Round ',num2str(round)]);
    round = round + 1;
end
disp(round);
