Reference: The LEACH Algorithm presented in: [Energy-efficient communication protocol for wireless microsensor networks](http://ieeexplore.ieee.org/abstract/document/926982/)<br>
<br>
**About LEACH:**<br>
LEACH是一个自组织、自适应的分簇协议，通过随机化来均衡分配网络中结点间的能量负载。在LEACH中，结点将自身组织成局部簇，簇中有一个结点作为本地基站或者簇头。LEACH包括高能量簇头位置的随机轮替机制，簇头的位置在多个结点间轮替，从而不会耗尽单个结点的电池。<br>
LEACH is a self-organizing, adaptive clustering protocol that uses randomization to distribute the energy load evenly among the sensors in the network. In LEACH, the nodes organize themselves into local clusters, with one node acting as the local base station or cluster-head.LEACH includes randomized rotation of the high-energy cluster-head position such that it rotates among the various sensors in order to not drain the battery of a single sensor.<br>
这个程序没有模拟节点传输信息的时间表。<br>
The schedule for the nodes in a cluster is not implemented in this program.<br>
