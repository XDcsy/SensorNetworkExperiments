**About COMPOW:**<br>
在COMPOW策略中所有节点的通信距离都相同，这个通信距离是保证所有节点全连通的最短距离。<br>
The COMPOW protocol ensures that the lowest common power level that ensures maximum network connectivity is selected by all nodes.
<br><br>
**Method:**<br>
首先使所有节点均使用最大的通信距离，建立一幅拓扑图。从图中最长的边开始逐个断开（相当于所有节点均逐渐减少通信功率），
直到断开某条边后图不再全连通，则断开的上一条边的长度即为COMPOW策略中的最短通信距离。<br>
计算覆盖率时使用栅格统计法计算覆盖率，即将目标区域均匀地栅格化，统计被传感器网络覆盖的栅格个数，该个数与总栅格数的比值即为覆盖率。<br>
*一个更优化的算法：几何区域覆盖率算法（Geometric Coverage Algorithm，GCA），在[此文献](http://www.arocmag.com/article/02-2017-08-031.html)中详细的介绍，今后可能会依据此算法进行优化。
