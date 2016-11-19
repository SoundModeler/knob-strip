; knob-strip
;   Works on a two-layer image (background layer + indicator layer) and creates a vertical strip rotating the current layer by a given angle in the defined number of steps. The background layer is cloned for each step.
;   Based on script-fu-rotator-withbg (Andrew Hayden), ani-rotate (Eric Coutier) and Rotator (Joacim Breiler)

(define (script-fu-knobstrip img inLayer inTotAngle inIncCount)
  (let*
    (
      (pi 3.141592654)

      ;duplicate the original image
      (img (car (gimp-channel-ops-duplicate img)))
      (width (car (gimp-image-width img)))
      (height (car (gimp-image-height img)))
      (totHeight(* height inIncCount))
      (srcLayer (car (gimp-image-get-active-layer img)))
      (layers (car(cdr (gimp-image-get-layers img))))
      (nLayers (car (gimp-image-get-layers img)))
        (i 0)
      (layer 0)
      (counter 0)
      (a 0)
      (inc (/ inTotAngle inIncCount))
      (aRad 0)
      (newLayer 0)
      (srcLayerClone 0)
        (whiteLayer 0)
        (resLayer 0)
    )

    ;begin
    (gimp-undo-push-group-start img)
    (gimp-image-resize img width totHeight 0 0)


    ;hide all layers
    (set! layers (car(cdr (gimp-image-get-layers img))))
    (set! nLayers (car (gimp-image-get-layers img)))
    (set! i 0)
    (set! layer 0)
    (while (< i nLayers)
      (set! layer (aref layers i))
      (if(not(= layer srcLayer))
        (plug-in-tile 1 img layer width totHeight 0)
        (gimp-layer-set-visible layer 0)
      )
      (set! i (+ i 1))
    )


    ;build the frames
    (set! counter 0)
    (while (< counter inIncCount)
      (set! aRad (* (/ a 180) pi))
      (set! newLayer (car (gimp-layer-copy srcLayer FALSE)))
      (gimp-image-add-layer img newLayer 0)
      (gimp-layer-set-visible newLayer TRUE)
      (gimp-layer-set-offsets newLayer 0 (* height counter))

      ;rotate the new layer
      (gimp-rotate newLayer TRUE aRad)

      ;add background
      (set! whiteLayer (car (gimp-layer-new img width height 1 "rotation layer" 100 0)))
      (gimp-image-add-layer img whiteLayer 0)
      (gimp-layer-set-visible whiteLayer TRUE)
      (gimp-selection-all img)
      (gimp-edit-clear whiteLayer)
      (gimp-selection-none img)

      (set! resLayer (car (gimp-image-merge-visible-layers img 1)))
      (gimp-layer-set-visible resLayer FALSE)

      (set! a (+ a inc))
      (set! counter (+ counter 1))
    )

    (gimp-image-remove-layer img srcLayer)

    ;show all layers
    (set! layers (car(cdr (gimp-image-get-layers img))))
    (set! nLayers (car (gimp-image-get-layers img)))
    (set! i 0)
    (set! layer 0)
    (while (< i nLayers)
      (set! layer (aref layers i))
      (gimp-layer-set-visible layer 1)
      (set! i (+ i 1))
    )

    ;end
    (gimp-undo-push-group-end img)
    (gimp-display-new img)
  )
)

(script-fu-register "script-fu-knobstrip"
  "<Image>/Script-Fu/Transforms/knob-strip"
  "Rotates the selected layer with a given angle, creating new layers for each step"
  "Vincenzo Pacella (based on script-fu-rotator-withbg by Andrew Hayden)"
  ""
  "October 26, 2013"
  ""
  SF-IMAGE "image" 0
  SF-DRAWABLE "drawable" 0
  SF-ADJUSTMENT "Rotation angle" '(270 0 360 1 10  0 0)
  SF-ADJUSTMENT "N. of steps" '(128 2 360 1 2  0 1)
  ;SF-TOGGLE "vertical" FALSE
  ;SF-TOGGLE "add background to each frame" TRUE
  ;SF-TOGGLE "flatten before anim" TRUE
)
