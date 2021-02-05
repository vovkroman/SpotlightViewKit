# SpotlightViewKit
**SpotlightViewKit** is a framework, which might be considered as part of onboarding process. **SpotlightView** provides a very simple API to generate spotlight effect, and zoom on different parts of UI, and moves from one to onother. Besides, it's pretty customizable (see [Functionality]()).

### Requirements (Programming language)

Swift 4.2 and upper.

### Support

iOS 10.0 and upper

### Functionality

- [x] **Usability** - there are 2 appraches how to use SpotlightViewKit:

1. [SpotlightView](https://github.com/vovkroman/SpotlightViewKit/blob/master/SpotlightViewKit/SpotlightViewKit/Sources/SpotlightView/SpotLightView.swift) can be created for itself, implementing delegate methods:

```
var contentView: UIView? { get } // specific View, which overlay is laid on
func numberOfFocusItem() -> Int // number of parts that should be focused on
func focusRect(at index: Int) -> CGRect // return specific CGRect, that should be focused on (keep in mind, slot is being drawed arround the CGRect)
func spotlightView(_ spotlightView: SpotLightView, performActionForItem item: FocusItem) // invoked in parallel with slot moving (a good method to implement custom animation for description)
func spotlightView(_ spotlightView: SpotLightView, animationDidFinishedForItem item: FocusItem) 
func allAnimationsDidFinished() // all animations have been finished and there is nothing to be focused
```

In this approach user manages the view for himself.
<sup><sub>There is a drawback in current approach: user should create the view, when the layout is **relevant**, otherwise, slots won't match with actual view</sub></sup>

2. To use [SpotlightManager](https://github.com/vovkroman/SpotlightViewKit/blob/master/SpotlightViewKit/SpotlightViewKit/Sources/SpotlightViewController/SpotlightManager.swift); it manages when views've been finished layouting for itself. client should run the following code:


```
let manager: SpotlightManager = SpotlightManager(...)
manager.start()
```

- [x] **Customizability** - framework provides 2 ways to configure overlay:

1. To setup overlay with **Blur**, user should configure 5 params (**ratio**, **blurRadius**, **blendColor**, **blendMode**, **iterations**). 
Here is some set of this params and how overlay will look like (listed set is default one):

|**ratio**, (CGFloat)|**blurRadius**, (CGFloat) |**blendColor**, (UIColor) |**blendMode**, (CGBlendMode)|**iterations**, (Int)|
| --------------------------:|:---------------------------------:|:---------------------------------:|:-----------------------------------:|:------------------------------------:|
|           1.0              |                80.0               |                gray               |             destinationOver         |               3                      |

![](Demo/blur_appearence.gif).

2.  To setup overlay with **Color**, user should configure 3 params (**color**, **blendMode**, **alpha**). 
Here is some set of this params and how overlay will look like:

|**color**, (UIColor)|**blendMode**, (CGBlendMode) |**alpha**, (CGFloat) |
| --------------------------- |:------------------------------------:|:----------------------------:|
|            lightGray        |                   darken             |              0.6             |  

![](Demo/color_appearance.gif).