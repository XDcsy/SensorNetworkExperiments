clear;
energyLeft = 1;
round = 0;
num = 100;  %�ڵ���Ŀ
pow = 5000;  %������
P = 0.1;
range = 1;  %�ڵ���մ˷�Χ�ڵĴ�ͷ�㲥
times = 10;  %ÿ�ַ������ݴ���
sendCost = 2;  %�ڵ�䷢��һ�����ݵ���������
receiveCost = 1;  %�ڵ�����һ�����ݵ���������
broadcastCost = 4;  %��ͷ�ڵ�����Χ�㲥����������
remoteRransmitCost = 100;  %��ͷ�ڵ�Զ����ͨ�ŵ���������

for i = 1 : num
    nodes(i) = node(pow);
end
while energyLeft
    if mod(round,1/P) == 0 && round ~= 0  %��1/p�ֺ����нڵ��ٴο��Ա�ѡΪ��ͷ
        for i = 1 : num
            nodes(i).wasElected = 0;
        end
    end
    
    T = P/(1-P*mod(round,1/P));
    headnodes = [];
    nothaednodes = [];
    for i = 1 : num  %ÿһ�ֿ�ʼʱ�����һ�ֵĴ�ͷ��¼���������²��������
        nodes(i).reSet();
    end
    for i = 1 : num  %ѡ�ٴ�ͷ
        nodes(i).elect(T);
        if nodes(i).ishead
            headnodes = [headnodes nodes(i)];
        else
            nothaednodes = [nothaednodes nodes(i)];
        end
    end
    for i = 1 : length(headnodes)  %��ͷ�㲥
        headnodes(i).send(broadcastCost);
    end
    for i = 1 : num  %���ڵ���չ㲥�źţ��ҵ�������ͷ
        nodes(i).findhead(headnodes, range, receiveCost)
    end
    for i = 1 : length(nothaednodes)  %�Ǵ�ͷ�ڵ�֪ͨ���Դ�ͷ������ͷ����
        nothaednodes(i).send(sendCost);
        nothaednodes(i).head.recive(receiveCost);
    end
    for i = 1 : times  %���һ�ֵ������շ�
        for j = 1 : length(nothaednodes)  %�Ǵ�ͷ�ڵ㷢�ͣ�����ͷ����
            nothaednodes(j).send(sendCost);
            nothaednodes(j).head.recive(receiveCost);
        end
        for j = 1 : length(headnodes)  %��ͷ�ڵ�Զ�̷���
            headnodes(j).send(remoteRransmitCost);
        end
    end
    for i = 1 : num  %�����ڵ�ʣ������
        if nodes(i).power <= 0
            energyLeft = 0;
            break;
        end
    end
    figure();
    for i = 1 : num
        if nodes(i).ishead  %�����ֵĴ�ͷ������ѡ����ͷ�Ľڵ�������ڵ�ֱ��ʾ
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
