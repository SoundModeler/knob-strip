# What is it?
***knob-strip*** is a [GIMP][576da29f] script that can be used to create image strips to be used as animation frames for graphic knobs. This script is an adaptation of `script-fu-rotator-withbg` originally written by Andrew Hayden (which in turn derives from `ani-rotate` by Eric Coutier and `Rotator` by Joacim Breiler).

# Installation
- Check the current Script-Fu folders:
![Set/check script folder path](https://raw.github.com/shaduzlabs/knob-strip/master/docs/configure.png)
- Copy `knob-strip.scm` to one of the existing Script-Fu paths (or just add a new path)
- Close and re-open GIMP

# Usage
Create/open a file with two layers (see `example.xcf`, included in this repo), a background layer, which will be cloned without transformations, and the indicator layer, which will be cloned and rotated according to the parameters you'll specify in the knob-strip dialog.
Now open knob-strip (from the Script-Fu menu -> Transforms), set the rotation angle and the number of steps according to your needs, and hit OK.

![The main knob-strip dialog](https://raw.github.com/shaduzlabs/knob-strip/master/docs/dialog.png)

Depending on the parameters you specified and the size of the image, this might take a while. When the script is done, you'll end up with something like this:

![The main knob-strip dialog](https://raw.github.com/shaduzlabs/knob-strip/master/docs/result.png)

[576da29f]: https://www.gimp.org/ "The GIMP"
