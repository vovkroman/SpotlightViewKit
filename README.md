# SpotlightViewKit
**SpotlightViewKit** is a framework, which might be considered as part of onboarding process. **SpotlightView** provides a very simple API to generate spotlight effect, and zoom on different parts of UI, and moves from one to onother. Besides, it's pretty customizable (see Andvatages).

### Requirements (Programming language)

Swift 4.2 and upper.

### Support

iOS 10.0 and upper

### Functionality

- [x] **Usability** - 
- [x] **Customizability** - framework provides 2 ways to configure overlay:
1. Blur with default set of parameters (ratio: CGFloat = 1.0, blurRadius: CGFloat = 80.0, blendColor: UIColor? = .gray, blendMode: CGBlendMode = .destinationOver, iterations: Int = 3)
![](Demo/blur_appearence.gif).
2. Color with default set of parameters (color: UIColor = .lightGray, blendMode: CGBlendMode = .darken, alpha: CGFloat = 0.6)
![](Demo/color_appearance.gif).

<sup><sub>Custom overlay might be configured pritty easy, using [Color/Blur-Configurator](https://github.com/vovkroman/SpotlightViewKit/blob/master/SpotlightViewKit/SpotlightViewKit/Sources/SpotlightView/Configurators.swift)</sub></sup>