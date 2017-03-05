方法是对图进行深度优先递归遍历以得到连通性。  
A solution using DFS.  
code: `connection_possibility_traversal.m`  
result: `result.fig`  
2017-2-26<br>
<br>
优化了邻接矩阵的创建。  
2017-3-1<br>
<br>
将图的存储结构从邻接矩阵改为邻接表，使得遍历的复杂度由O(n^2)降低到O(n+a)，a表示图的边数。<br>
2017-3-5
