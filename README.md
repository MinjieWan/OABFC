# An optimized additive bias field correction model for infrared image segmentation with intensity non-uniformity

## Abstract
Infrared (IR) images are often affected by the bias field effects, leading to the phenomenon of intensity non-uniformity. This phenomenon can severely degrade image contrast and obscure fine details. In addition, excessive convolution operations are involved to extract features during level set evolution (LSE), which results in long segmentation time. Moreover, the energy functions of most existing ACMs are constructed based solely on either local or global intensity information, which may cause edge leakage or local minima trapping while IR images with intensity non-uniformity. To address these issues, an optimized additive bias field correction (OABFC) model for infrared image segmentation with intensity non-uniformity is proposed. Compared with recently developed ACMs, our OABFC model generates superior segmentation precision (Jaccard Similarity Coefficient (JSC), Dice Similarity Coefficient (DSC), and Mean Hausdorff Distance (MHD)) on average. In addition, it exhibits better bias field correction (BFC) performance on IR images with intensity non-uniformity and shows potential for generalization to the Breast Ultrasound Images (BUSI) dataset.

## Overview of OABFC
![Structure Figure](OABFC_flow.png)

## Publication
```
If you want to use this work, please consider citing the following paper.
@article{ge2026optimized,
  title={An optimized additive bias field correction model for infrared image segmentation with intensity non-uniformity},
  author={Ge, Pengqiang and Wan, Minjie and Qian, Weixian and Kong, Xiaofang and Weng, Guirong and Gu, Guohua and Chen, Qian},
  journal={Expert Systems with Applications},
  pages={131787},
  year={2026},
  publisher={Elsevier}}
```
