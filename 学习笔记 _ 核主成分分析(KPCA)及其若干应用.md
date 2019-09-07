
# <center><font face="宋体"> 学习笔记|核主成分分析(KPCA) </font></center>

*<center><font face="Times New Roman" size = 3> Author：[chentianyang](https://github.com/chentianyangWHU) &emsp;&emsp; E-mail：tychen@whu.edu.cn &emsp;&emsp; [Link](https://github.com/chentianyangWHU/KPCA)</center>*

**概要：** <font face="宋体" size = 3> 本文将在前一篇博客[学习笔记|主成分分析(PCA)及其若干应用](https://blog.csdn.net/ctyqy2015301200079/article/details/85325125)的基础上介绍核主成分分析(Kernel Principle Component Analysis, KPCA)。前文提到，PCA只能处理线性数据的降维，对于线性不可分的数据效果很差，因此在PCA中引入了核函数(kernel)的概念，即核主成分分析PCA。KPCA的基本思路是通过核函数将在低维空间中线性不可分的数据通过某种映射函数映射到更高维的空间中去，使其在该高维空间中线性可分，之后再使用使用适用于线性可分数据的相关算法进行后续处理。和函数的思路在很多算法中具有应用，典型的如支持向量机(SVM)等。</font>

**关键字：** <font face="宋体" size = 3 >矩阵分解; 主成分分析; PCA</font>

# <font face="宋体"> 1 算法原理 </font>

&emsp;&emsp; <font face="宋体">KPCA的算法原理和PCA的基本一致，唯一的不同就是先将原数据X映射到高维空间中，再进行求协方差矩阵、求特征向量并排列等后续操作。详细的介绍可以参考博客[KPCA非线性降维与核函数](https://www.jianshu.com/p/708ca9fa3023)，这里不再介绍。</font>

# <font face="宋体"> 2 效果展示 </font>

&emsp;&emsp; <font face="宋体">首先生成线性不可分的三组数据，如图2.1所示，分别用红绿蓝三种颜色标记。</font>

<center><img src="https://img-blog.csdnimg.cn/20190907103618453.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==,size_16,color_FFFFFF,t_70" width="70%">  </center><center><font face="宋体" size=2 > 图2.1 三组线性不可分的数据 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">以上数据经PCA处理后的结果如图2.2所示。</font>

<center><img src="https://img-blog.csdnimg.cn/20190907104025540.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==,size_16,color_FFFFFF,t_70" width="70%">  </center><center><font face="宋体" size=2 > 图2.2 线性不可分数据及其经PCA处理后的结果 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">在图2.2中，右上侧三组数据（三个近似同心圆）是原始数据，左下角的是经过PCA处理后的数据。可见，PCA处理结果仅仅是将原数据整体旋转，并不改变数据之间的相对位置，处理过后仍然线性不可分。</font>

&nbsp;
&emsp;&emsp; <font face="宋体">原始数据经KPCA处理后的结果如图2.3所示。</font>

<center><img src="https://img-blog.csdnimg.cn/20190907173557265.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==,size_16,color_FFFFFF,t_70" width="70%">  </center><center><font face="宋体" size=2 > 图2.3 线性不可分数据经KPCA处理后的结果 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">对比图2.3和图2.1可知，KPCA对原数据进行了非线性处理，改变了原数据的相对关系，打破了数据的原有结构。图2.3中，蓝色数据已经可以和绿色红色数据线性分开，而绿色红色数据也可以同理进行后续处理。从图2.1得到图2.3使的参数如下。</font>

> kernel: Gaussian

> sigma: 8

&emsp;&emsp; <font face="宋体">迄今为止，关于何种场景下采用何种核函数的问题仍然没有很好的解决方法，当前常用的办法还是不断尝试、择优使用。在大量使用中积累的经验表明，首先尝试径向基核函数(Radial Basis Function, RBF)，例如高斯核等，总是一个不错的选择。</font>

# <font face="宋体"> 3 小结 </font>
&emsp;&emsp; <font face="宋体">结合了核函数的PCA有很多花式玩法和应用，这里只介绍了其最基本的概念和应用。</font>

&emsp;&emsp; <font face="宋体">本文为原创文章，转载或引用务必注明来源及作者。</font>











