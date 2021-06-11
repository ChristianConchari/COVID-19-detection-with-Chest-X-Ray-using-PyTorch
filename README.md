## Introduction
Nowadays,  we  are  living  in  the  COVID-19  pandemic,  atypical  COVID-19  infection  case  will  damage  the  walls  andlinings  of  the  air  sacs  in  human  lungs.  As  the  human  bodytries to fight it, the lungs become more inflamed and fill withfluid.  In many cases, it is possible to perform imaging teststo support the diagnosis, determine the severity of the diseaseand  assess  therapeutic  response.  In  this  way,  chest  X-ray  isusually  the  first  imaging  test  in  patients  with  suspected  orconfirmed  COVID-19  because  of  its  usefulness,  availabilityand low cost. As visual artificial learners we will generate a tool to support health professionals in the  diagnosis  of  COVID-19  employing  chest  X-ray  imaging tests.
There must be a high aplicability in the project and an app where it is connnected to the trained neural network and where a user can upload a X-Ray image of the lungs and get a prediction will be implemented. This will be developed in a Flutter framwork on the Dart programming language.

## Background
In order to setup a neural network adaptable to this project the Resnet networks are the most situable ones. With a 4 class data-set we chose the Resnet18 network. 

## Data Acquisitiion and Pre-procesing
The dataset was obtained from [Kaggle](https://www.kaggle.com/tawsifurrahman/covid19-radiography-database).

For the implementation of this project, the following 4-classdataset was used. A test set with 30 images of each classwas  set  aside,  in  addition  to  a  train  set  with  21045  imagesdistributed as follows:
<p align="center">
  <img  src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/distribution.png">
  
</p>

Subsequently,   a   contrast   stretch   was   performed   for   allimages  before  training  the  model,  this  in  order  to  obtain  abetter visualization of features in images with low contrast.
<p align="center">
  <img  src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/COVID-23.png">
  <img src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/COVID-23-1.png">
</p>
Image from dataset before per-forming contrast stretching and Image  from  dataset  after  per-forming contrast stretching

### Transfer Learning and Model Training
Once  the  data  acquisition  and  preprocessing  stage  wascarried out, several transformations were applied to the dataset,such  as  a  Resize,  a  RandomHorizontalFlip  and  a  normaliza-tion. This was done using Pytorch dependencies.Subsequently,   based   on   a   transfer   learning   model,   aResNet18  neural  network  was  implemented  starting  from  apre-trained model within Pytorch dependencies. By evaluatingthe  predictions  made  by  the  model  during  the  training,  thisprocess was continued until an accuracy of __0.95_ was obtained.

### Model Compiling for Mobile Implementation
Once  we  have  trained  the  model,  our  next  step  will  be  toobtain a TorchScript capable of being loaded and used to makeinferences,  either  in  a  desktop  Python  environment  or  in  amobile  environment  with  Dart  and  the  Flutter  framework  asis  being  done  in  the  present  project.

## Results
In  order  to  evaluate  the  project  some  metrics  must  beobtained,  these  will  be  the  most  important  feedback  to  the
project and may be applied to the training or data augmentationpart. In order to obtain the required metrics a data extractionmust be made, the model on __.pt__ and __.pth__ format will be loadedand the important characteristics will be extracted from it. Therelevant metrics for a ResNet-18 neural network are:
<table>
<tr>
<th></th>
<th>ResNet-18</th>
</tr>
<tr>
<td>

|__Pathology__|
|:-|
|Normal|
|Lung Opacity|
|Viral Pneumonia|
|COVID-19|
||
|Accuracy|
|Macro avg|
|Weighted avg
</td>
<td style="text-align: center;">

|Precision|Recall|F1-Score|Support|
|-:|-:|-:|-:|
|0.91|0.77|0.83|26|
|0.89|0.1.00|0.94|33|
|1.00|0.78|0.88|36|
|0.70|0.92|0.79|25|
|||||
|||0.86|120|
|0.87|0.85|0.85|120|
|0.88|0.86|0.85|120|

</td>

</tr>
<tr>
<td>

|TL;DR|
|:-|
|Train set|
|Test set|

</td>
<td>

|Total Correct Predictions|Total Accuracy|
|-:|-:|
|21045|86.49%|
|105|__83.33%__|

</td>

</tr>
<tr>
<td>Confusion Matrix</td>
<td>

![vgg_confmat](./Result_images/Test_confussion.png)

</td>

</tr>
</table>

- __Localization with Gradient-based Class Activation Maps__
<p align="center">
  <img  src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/bw_grad_cam.png">
</p>
<p align="center">
  <img  src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/grad_cam.png">
</p>

The gradient shows where the neural network model is looking and shows a concentration in the lungs.

- __Flutter App Implementation__

A  mobile  interface  has  been  created  using  theFlutter  framework,  for  this  purpose  we  made  use  of  thepytorchmobile  library,  which  allows  us  to  work  loading  thePytorch  script  generated  with  the  information  of  the  trainedmodel, to make inferences taking as input images entered bythe user and giving as output the corresponding classification label.
<p align="center">
  <img  src="https://github.com/ChristianConchari/COVID-19-detection-with-Chest-X-Ray-using-PyTorch/blob/master/Result_images/app_results.png">
</p>
This figure shows a gradient prediction of the model


## Conclussions
In  this  project  we  have  presented  an  implementation  ofa  Convolutional  Neural  Network  (CNN)  model  generatedwith Transfer Learning techniques, modifying the pre-trainedResNet18  network  to  classify  chest  X-ray  images  into  fourclasses:  normal  lungs,  lungs  infected  with  COVID-  19,  withviral pneumonia and pulmonary opacity. The current sceneryin  which  we  find  ourselves  requires  us  to  contribute  throughnew  solutions,  in  our  case  applying  artificial  intelligence  tosupport the medical diagnosis of respiratory diseases such as COVID-19.

## References
<a id="1">[1]</a> 
Shuzhan Fan (Nov 2,2018), M. Dietz, "Understand Deep Residual Networks — a simple, modular learning framework that has redefined…", Medium, 2021. [Online]. Available: (https://medium.com/@waya.ai/deep-residual-learning-9610bb62c355). [Accessed: 11- Jun- 2021]

<a id="2">[2]</a> 
. Feng, "An Overview of ResNet and its Variants", Medium, 2021. [Online]. Available: https://towardsdatascience.com/an-overview-of-resnet-and-its-variants-5281e2f56035. [Accessed: 11- Jun- 2021]

<a id="3">[3]</a> 
J. Prakash, "Understanding and Implementing Architectures of ResNet and ResNeXt for state-of-the-art Image…", Medium, 2021. [Online]. Available: 
    https://medium.com/@14prakash. [Accessed: 11- Jun- 2021]
    
<a id="4">[4]</a> 
M. Hussain, "What is Resnet or Residual Network | How Resnet Helps?", GreatLearning Blog: Free Resources what Matters to shape your Career!, 2021. [Online]. Available: https://www.mygreatlearning.com/blog/resnet/#:~:text=ResNet%2C%20short%20for%20Residual%20Network,Residual%20Learning%20for%20Image%20Recognition%E2%80%9D. [Accessed: 11- Jun- 2021]

<a id="5">[5]</a> 
He, K., Zhang, X., Ren, S., \& Sun, J. (2016). Deep residual learning for image recognition. In Proceedings of the IEEE conference on computer vision and pattern recognition (pp. 770-778).

<a id="6">[6]</a> 
M. E. H. Chowdhury et al., "Can AI Help in Screening Viral and COVID-19 Pneumonia?," in IEEE Access, vol. 8, pp. 132665-132676, 2020, doi: 10.1109/ACCESS.2020.3010287.
