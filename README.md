
## Results

<table>
<tr>
<th></th>
<th>VGG-16</th>
<th>ResNet-18</th>
<th>DenseNet-121</th>
</tr>
<tr>
<td>

|__Pathology__|
|:-|
|COVID-19|
|Lung Opacity|
|Normal|
|Viral Pneumonia|

</td>
<td>

|Accuracy|Precision|Recall|F1-Score|
|-:|-:|-:|-:|
|0.9956|0.9833|1.0000|0.9916|
|0.9582|0.8833|0.9464|0.9138|
|0.9622|0.9667|0.8923|0.9280|
|0.9913|0.9833|0.9833|0.9833|
            
</td>
<td>

|Accuracy|Precision|Recall|F1-Score|
|-:|-:|-:|-:|
|0.9871|0.9667|0.9830|0.9748|
|0.9664|0.8667|1.0000|0.9286|
|0.9664|1.0000|0.8823|0.9375|
|0.9957|1.0000|0.9836|0.9917|
            
</td>
<td>

|Accuracy|Precision|Recall|F1-Score|
|-:|-:|-:|-:|
|0.9957|0.9833|1.0000|0.9916|
|0.9623|0.9167|0.9322|0.9244|
|0.9623|0.9500|0.9047|0.9268|
|0.9957|0.9833|1.0000|0.9916|
            
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
|20362|98.44%|
|229|__95.42%__|

</td>
<td>

|Total Correct Predictions|Total Accuracy|
|-:|-:|
|20639|99.78%|
|230|__95.83%__|

</td>
<td>

|Total Correct Predictions|Total Accuracy|
|-:|-:|
|20540|99.30%|
|230|__95.83%__|

</td>
</tr>
<tr>
<td>Confusion Matrices</td>
<td>

![vgg_confmat](./assets/vgg_confmat.png)

</td>
<td>

![res_confmat](./assets/res_confmat.png)

</td>
<td>

![dense_confmat](./assets/dense_confmat.png)

</td>
</tr>
</table>

- __Localization with Gradient-based Class Activation Maps__
> |![original](./assets/original.jpg)|![vgg_cam](./assets/vgg_cam.jpg)|![res_cam](./assets/res_cam.jpg)|![dense_cam](./assets/dense_cam.jpg)|
> |:-:|:-:|:-:|:-:|
> |<sup>_COVID-19 infected CXR_</sup>|<sup>_VGG-16_</sup>|<sup>_ResNet-18_</sup>|<sup>_DenseNet-121_</sup>|

## Usage
> - Clone the repository
> ```bash
> git clone 'https://github.com/priyavrat-misra/xrays-and-gradcam.git' && cd xrays-and-gradcam/
> ```
> - Install dependencies
> ```bash
> pip install -r requirements.txt
> ```
> - Using `argparse` script for inference
> ```bash
> python overlay_cam.py --help
> ```
> ```
> usage: GradCAM on Chest X-Rays [-h] [-i IMAGE_PATH]
>                                [-l {covid_19,lung_opacity,normal,pneumonia}]
>                                -m {vgg16,resnet18,densenet121}
>                                [-o OUTPUT_PATH]
> 
> Overlays given label's CAM on a given Chest X-Ray.
> 
> optional arguments:
>   -h, --help            show this help message and exit
>   -i IMAGE_PATH, --image-path IMAGE_PATH
>                         Path to chest X-Ray image.
>   -l {covid_19,lung_opacity,normal,pneumonia}, --label {covid_19,lung_opacity,normal,pneumonia}
>                         Choose from covid_19, lung_opacity, normal &
>                         pneumonia, to get the corresponding CAM. If not
>                         mentioned, the highest scoring label is considered.
>   -m {vgg16,resnet18,densenet121}, --model {vgg16,resnet18,densenet121}
>                         Choose from vgg16, resnet18 or densenet121.
>   -o OUTPUT_PATH, --output-path OUTPUT_PATH
>                         Format: "<path> + <file_name> + .jpg"
> ```
> - An example
> ```bash
> python overlay_cam.py --image-path ./assets/original.jpg --label covid_19 --model resnet18 --output-path ./assets/dense_cam.jpg
> ```
> ```
> GradCAM generated for label "covid_19".
> GradCAM masked image saved to "./assets/res_cam.jpg".
> ```

## Conclusions
> - DenseNet-121 having only `7.98 Million` parameters did relatively better than VGG-16 and ResNet-18, with `138 Million` and `11.17 Million` parameters respectively.
> - Increase in model's parameter count doesn’t necessarily achieve better results, but increase in residual connections might.
> - Oversampling helped in dealing with imbalanced data to a great extent.
> - Fine-tuning helped substantially by dealing with the comparatively small dataset and speeding up the training process.
> - GradCAM aided in localizing the areas in CXRs that decides a model's predictions.
> - The models did a good job distinguishing various infectious and inflammatory lung diseases, which is rather hard manually, as mentioned earlier.

## References
> - [1] David L. Smith, John-Paul Grenier, Catherine Batte, and Bradley Spieler. [A Characteristic Chest Radiographic Pattern in the Setting of the COVID-19 Pandemic](https://pubs.rsna.org/doi/10.1148/ryct.2020200280). Radiology: Cardiothoracic Imaging 2020 2:5.
> - [2] Hyun Jung Koo, Soyeoun Lim, Jooae Choe, Sang-Ho Choi, Heungsup Sung, and Kyung-Hyun Do. [Radiographic and CT Features of Viral Pneumonia](https://pubs.rsna.org/doi/10.1148/rg.2018170048). RadioGraphics 2018 38:3, 719-739.
> - [3] Tawsifur Rahman, Muhammad Chowdhury, Amith Khandakar. [COVID-19 Radiography Database](https://www.kaggle.com/tawsifurrahman/covid19-radiography-database). Kaggle.
> - [4] Karen Simonyan, Andrew Zisserman. [Very Deep Convolutional Networks for Large-Scale Image Recognition](https://arxiv.org/abs/1409.1556). arxiv:1409.1556v6.
> - [5] Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun. [Deep Residual Learning for Image Recognition](https://arxiv.org/abs/1512.03385). arxiv:1512.03385v1.
> - [6] Gao Huang, Zhuang Liu, Laurens van der Maaten, Kilian Q. Weinberger. [Densely Connected Convolutional Networks](https://arxiv.org/abs/1608.06993). arxiv:1608.06993v5.
> - [7] Deng, J. et al., 2009. [Imagenet: A large-scale hierarchical image database. In 2009 IEEE conference on computer vision and pattern recognition](http://image-net.org/). pp. 248–255.
> - [8] Ramprasaath R. Selvaraju, Michael Cogswell, Abhishek Das, Ramakrishna Vedantam, Devi Parikh, Dhruv Batra. [Grad-CAM: Visual Explanations from Deep Networks via Gradient-based Localization](https://arxiv.org/abs/1610.02391). arXiv:1610.02391v4.