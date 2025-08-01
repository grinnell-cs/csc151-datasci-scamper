---
title: Interactivity, Events, and Reactivity
---

In any interactive scenario, our program must _react_ to a variety of _events_, for example:

+   When the user clicks on the screen, we might change the color of an object on the screen.
+   When the user presses the space bar, we might change the shape of the object.
+   We might move an object on the screen periodically according to a timer.

To capture this pattern of programming, we take inspiration from _reactive programming frameworks_ such as the [Elm programming language](https://elm-lang.org) and the [React library](https://react.dev) for user interface development in Javascript.
We provide the `reactive` library for building components that can subscribe and react to events generated by many sources, including timers, user input, and musical compositions.
Ultimately, we can use the `reactive` library to build interactive, multimedia applications in Scamper such as visualizations, user interfaces, or games!

## The Architecture of a Reactive Application

A common way to decompose an interactive program is to break it up into three parts:

+   A _model_ that is the data that the program manipulates.
    The goal of the program is to (a) handle events by updating the model and (b) periodically render the model to the screen.
+   A _view_ function that takes the model and periodically renders it to the screen.
+   An _update_ function that takes an event message and model as input and produces an updated model based on the processed event.

Event messages are the data created by sources of events.
For example, a mouse click event might record the position of the cursor where the click occurred.

This particular decomposition is a _reactive_ program architecture.
Specifically, our decomposition allows our model to react to events by way of the `update` function.
The `view` function allows us to turn our continually evolving model into a component, _e.g._, a canvas, viewable by the user.

## An Example: A Reactive Ball

To demonstrate this reactive architecture in practice using the `reactive` library, we'll walk through the following implementation of a simple interactive application.

<pre class="scamper">
(import canvas)
(import image)
(import reactive)

(struct state (
  shape     ; string?, "circle" or "square"
  color     ; string?, "red" or "blue"
  x         ; number?
  y         ; number?
  direction ; string?, "left" or "right"
))

; The width of the canvas
(define width 300)

; The height of the canvas
(define height 50)

; The length of the shape
(define len 50)

; The velocity of the shape
(define velocity 5)

; The timer interval for updating our simulation (in milliseconds)
(define interval 25)

(define view
  (lambda (st canv)
    (match st
      [(state shape color x y dir)
        (begin
          (canvas-rectangle! canv 0 0
            width height 
            "outline" "black")
          (cond
            [(equal? shape "circle")
            ; N.B., canvas-circle! places the shape at the origin
            ; instead of the upper-level corner.
            (let ([rad (/ len 2)])
              (canvas-circle! canv (+ x rad) (+ y rad) rad "solid" color))]
            [(equal? shape "square")
            (canvas-rectangle! canv x y len len "solid" color)]))])))

(define move-shape
  (lambda (st)
    (match st
      [(state shape color x y dir)
       (if (equal? dir "right")
           (if (> (+ velocity x len) width)
               (state shape color (- width len) y "left")
               (state shape color (+ velocity x) y dir))
           (if (< (- x velocity) 0)
               (state shape color 0 y "right")
               (state shape color (- x velocity) y dir)))])))

(define update
  (lambda (msg st)
    (match st
      [(state shape color x y dir)
       (match msg
         [(event-timer time elapsed)
          (move-shape st)]
         [(event-mouse-click btn cx cy)
          (if (equal? color "red")
              (state shape "blue" x y dir)
              (state shape "red" x y dir))]
         [(event-key-up key)
          (cond 
            [(and (equal? key "c") (equal? shape "circle"))
             (state "square" color x y dir)]
            [(equal? shape "square")
             (state "circle" color x y dir)]
            [else st])])])))

(display
  (reactive-canvas
    width height
    ; The initial model
    (state "circle" "blue" (/ width 2) 0 "right")
    ; The view function
    view
    ; The update function
    update
    ; Event subscriptions
    (on-timer interval)
    (on-mouse-click)
    (on-key-up)))
</pre>

The program uses a timer to simulate a ball moving back and forth in a box.
You can click on the canvas to change the color of the ball.
You can also press `c` to change the shape of the ball to a square and back.

### The Model

<pre class="scamper source-only">
(import canvas)
(import image)
(import reactive)

(struct state (
  shape     ; string?, "circle" or "square"
  color     ; string?, "red" or "blue"
  x         ; number?
  y         ; number?
  direction ; string?, "left" or "right"
))

; The width of the canvas
(define width 300)

; The height of the canvas
(define height 50)

; The length of the shape
(define len 50)

; The velocity of the shape
(define velocity 5)

; The timer interval for updating our simulation (in milliseconds)
(define interval 25)
</pre>

First, we define the model that we will render to the canvas and update based on the events we receive.
We use a `struct` to define this model, calling it `state` to represent the _state of our program_.
The state of the program captures salient characteristics of the shape.
Notably, in order to simulate the shape's movement, we record the `x` and `y` position of the shape and the direction it is moving in.

For simplicity's sake, we have the ball move at a constant velocity relative to the rate at which we update the simulation.
These, along with other constant values, are defined as top-level identifiers used throughout the program.

### The Reactive Canvas

<pre class="scamper source-only">
(display
  (reactive-canvas
    width height
    ; The initial model
    (state "circle" "blue" (/ width 2) 0 "right")
    ; The view function
    view
    ; The update function
    update
    ; Event subscriptions
    (on-timer interval)
    (on-mouse-click)
    (on-key-up)))
</pre>

Next, let's look at the function, `reactive-canvas` which puts together the different parts of our reactive program together.
The function takes the following required parameters as input:

+   The `width` of the canvas.
+   The `height` of the canvas.
+   A `initial` value for our model.
+   A `view` function that renders our model to the canvas.
+   A `update` function that updates the model in response to events.

`reactive-canvas` also takes a number of _subscriptions_ which allow our model to respond to events.
In our particular call to `reactive-canvas`, we subscribe to three events:

+   `(on-timer interval)` subscribes to timer events.
    An event is generated by the timer every `interval` milliseconds.
+   `(on-mouse-click)` subscribes to mouse click events that are generated when the user clicks on the canvas.
+   `(on-key-up)` subscribes to keyboard events when a key is depressed.

We can subscribe to other events as well.
All of these subscription functions are named with the prefix `on-` and can be passed to `reactive-canvas`.
See the `reactive` library documentation for a complete list of these possible subscriptions.

`view` and `update` are functions that capture the other parts of our reactive component that we define below.

### View: Rendering Our Model

<pre class="scamper source-only">
(define view
  (lambda (st canv)
    (match st
      [(state shape color x y dir)
        (begin
          (canvas-rectangle! canv 0 0
            width height 
            "outline" "black")
          (cond
            [(equal? shape "circle")
            ; N.B., canvas-circle! places the shape at the origin
            ; instead of the upper-level corner.
            (let ([rad (/ len 2)])
              (canvas-circle! canv (+ x rad) (+ y rad) rad "solid" color))]
            [(equal? shape "square")
            (canvas-rectangle! canv x y len len "solid" color)]))])))
</pre>

The `view` argument to `reactive-canvas` must be a function that takes two arguments:

+   The current `state` of our model.
+   The `canvas` we should draw our model to.

The purpose of the function is to take this snapshot of the model and render it to our canvas.
Observe how this function works _independently_ of how the model changes through events!
By separating rendering (`view`) from the program's logic (`update`), we greatly simplify our program design!

To render our model, we use the canvas-drawing function found in the `canvas` library.
These functions operate similarly to the shape functions found in the `image` library but allows for precise placement of shapes.
The functions are also effectful—they draw to a canvas a side effect—and, thus, must be sequenced together using `begin`.

### Update: Responding to Events

<pre class="scamper source-only">
(define update
  (lambda (msg st)
    (match st
      [(state shape color x y dir)
       (match msg
         [(event-timer time elapsed)
          (move-shape st)]
         [(event-mouse-click btn cx cy)
          (if (equal? color "red")
              (state shape "blue" x y dir)
              (state shape "red" x y dir))]
         [(event-key-up key)
          (cond 
            [(and (equal? key "c") (equal? shape "circle"))
             (state "square" color x y dir)]
            [(equal? shape "square")
             (state "circle" color x y dir)]
            [else st])])])))
</pre>

The core of our simulation logic rests in the `update` function.
The `update` function receives one of the events we subscribed to in our `reactive-canvas` call and updates the model based on the event.
For each subscription we pass to `reactive-canvas`, the _event message_ takes on a different form, carrying different values depending on the event.
Each of the event messages is a `struct` that we can break apart and analyze with pattern matching:

+   `(on-timer interval)` creates `(event-timer time elapsed)` messages which contain the `time` that the event fired and the time `elapsed` since the last `event-timer` message was sent.
+   `(on-mouse-click)` creates `(event-mouse-click btn cx cy)` messages which contain the mouse button pressed and the location of the click.
+   `(on-key-up)` creates `(event-key-up key)` messages which contain the key that was released. 

The documentation captures, for each subscription, the event message `struct` that `update` will receive to handle that event.

In the cases of mouse clicks (`event-mouse-click`) and key presses (`event-key-up`), we toggle the `color` and `shape` fields of our `state` struct, respectively.
Observe how, in each case, `update` returns a new `state` that consists of the updated fields.
The reactive runtime will then use this updated `state` in future calls of `view`, whenever they are scheduled to occur.

The logic for moving the shape based on our timer event `(event-timer time elapsed)` is a bit more complex, so we factor out the code to a separate function.

<pre class="scamper source-only">
(define move-shape
  (lambda (st)
    (match st
      [(state shape color x y dir)
       (if (equal? dir "right")
           (if (> (+ velocity x len) width)
               (state shape color (- width len) y "left")
               (state shape color (+ velocity x) y dir))
           (if (< (- x velocity) 0)
               (state shape color 0 y "right")
               (state shape color (- x velocity) y dir)))])))
</pre>

`move-shape` updates our model's `x` position based on the velocity.
Every timer event moves the shape by 5 pixels (the current value of `velocity`).
Since our timer interval is `25` milliseconds, that means the shape effectively moves at $\frac{5}{25}$ pixels/millisecond or 1 pixel every 5 milliseconds.
One way we can improve this simple code is to use the `elapsed` value of our time event to move the shape in terms of time elapsed rather than a fixed amount per update.
In addition to moving the shape, we also perform rudimentary _collision detection_, switching the direction of the shape if the shape runs over either side of the canvas.

### Reacting to Musical Compositions

The events we've considered so far are managed by the Scamper runtime and the browser.
However, sometimes our program may generate events that we wish to respond to.
An example of this is reacting to musical compositions we write in Scamper.
In the application below, we create a musical composition that programmatically controls the color of the shape.

<pre class="scamper">
(import canvas)
(import image)
(import music)
(import reactive)

(define mary-had-a-little-lamb
  (seq
    (par (note 58 qn) (note-event "blue"))
    (note 56 qn)
    (note 54 qn)
    (note 56 qn)
    (par (note 58 qn) (note-event "green"))
    (note 58 qn)
    (note 58 hn)
    (par (note 56 qn) (note-event "purple"))
    (note 56 qn)
    (note 56 hn)
    (par (note 58 qn) (note-event "red"))
    (note 58 qn)
    (note 58 hn)

    (par (note 58 qn) (note-event "blue"))
    (note 56 qn)
    (note 54 qn)
    (note 56 qn)
    (par (note 58 qn) (note-event "green"))
    (note 58 qn)
    (note 58 hn)
    (par (note 56 qn) (note-event "purple"))
    (note 56 qn)
    (par (note 58 qn) (note-event "red"))
    (par (note 56 qn) (note-event "green"))
    (par (note 54 hn) (note-event "blue"))))

(define handlers (make-note-handlers))

(reactive-canvas 100 100
  "blue"
  (lambda (st canv)
    (begin
      (canvas-rectangle! canv 0 0 100 100 "outline" "black")
      (canvas-rectangle! canv 10 10 80 80 "solid" st)))
  (lambda (msg st)
    (match msg
      [(event-note color) color]))
  (on-note handlers))

(display
  (mod (note-handlers handlers)
    (mod (tempo qn 240)
        mary-had-a-little-lamb)))
</pre>

We trigger events in a composition with the `note-event` function.
`(note-event v)` will generate a `(event-note v)` event message that we can capture in our `update` function.
Observe that we play a `note-event` in parallel with the triggering note using `par` to ensure that the event is played alongside the given note.

<pre class="scamper source-only">
(define mary-had-a-little-lamb
  (seq
    (par (note 58 qn) (note-event "blue"))
    (note 56 qn)
    (note 54 qn)
    (note 56 qn)
    (par (note 58 qn) (note-event "green"))
    ; ...))
</pre>

In our example, the value `v` carried by each event message will be the color of the shape we track as the state of our reactive program.

We then need to hook up handlers to this composition and then register those handlers with our reactive canvas.
The zero-argument function `make-note-handlers` creates an initially empty set of handlers.

<pre class="scamper source-only">
(define handlers (make-note-handlers))
</pre>

When creating our reactive canvas, we subscribe to these note events with the `on-note` function, passing these `handlers` along.

<pre class="scamper source-only">
(reactive-canvas 100 100
  "blue"
  (lambda (st canv)
    (begin
      (canvas-rectangle! canv 0 0 100 100 "outline" "black")
      (canvas-rectangle! canv 10 10 80 80 "solid" st)))
  (lambda (msg st)
    (match msg
      [(event-note color) color]))
  (on-note handlers))
</pre>

As a side effect, `on-note` will add this new `reactive-canvas` to `handlers`.

Finally, we play our composition _modded to utilize `handlers`_ to handle any events that the composition creates.

<pre class="scamper source-only">
(display
  (mod (note-handlers handlers)
    (mod (tempo qn 240)
        mary-had-a-little-lamb)))
</pre>

### Appendix: Source Code

#### Interactive Shape Example

<pre class="scamper source-only">
(import canvas)
(import image)
(import reactive)

(struct state (
  shape     ; string?, "circle" or "square"
  color     ; string?, "red" or "blue"
  x         ; number?
  y         ; number?
  direction ; string?, "left" or "right"
))

; The width of the canvas
(define width 300)

; The height of the canvas
(define height 50)

; The length of the shape
(define len 50)

; The velocity of the shape
(define velocity 5)

; The timer interval for updating our simulation (in milliseconds)
(define interval 25)

(define view
  (lambda (st canv)
    (match st
      [(state shape color x y dir)
        (begin
          (canvas-rectangle! canv 0 0
            width height 
            "outline" "black")
          (cond
            [(equal? shape "circle")
            ; N.B., canvas-circle! places the shape at the origin
            ; instead of the upper-level corner.
            (let ([rad (/ len 2)])
              (canvas-circle! canv (+ x rad) (+ y rad) rad "solid" color))]
            [(equal? shape "square")
            (canvas-rectangle! canv x y len len "solid" color)]))])))

(define move-shape
  (lambda (st)
    (match st
      [(state shape color x y dir)
       (if (equal? dir "right")
           (if (> (+ velocity x len) width)
               (state shape color (- width len) y "left")
               (state shape color (+ velocity x) y dir))
           (if (< (- x velocity) 0)
               (state shape color 0 y "right")
               (state shape color (- x velocity) y dir)))])))

(define update
  (lambda (msg st)
    (match st
      [(state shape color x y dir)
       (match msg
         [(event-timer time elapsed)
          (move-shape st)]
         [(event-mouse-click btn cx cy)
          (if (equal? color "red")
              (state shape "blue" x y dir)
              (state shape "red" x y dir))]
         [(event-key-up key)
          (cond 
            [(and (equal? key "c") (equal? shape "circle"))
             (state "square" color x y dir)]
            [(equal? shape "square")
             (state "circle" color x y dir)]
            [else st])])])))

(display
  (reactive-canvas
    width height
    ; The initial model
    (state "circle" "blue" (/ width 2) 0 "right")
    ; The view function
    view
    ; The update function
    update
    ; Event subscriptions
    (on-timer interval)
    (on-mouse-click)
    (on-key-up)))
</pre>

### Animated Song Example

<pre class="scamper source-only">
(import canvas)
(import image)
(import music)
(import reactive)

(define mary-had-a-little-lamb
  (seq
    (par (note 58 qn) (note-event "blue"))
    (note 56 qn)
    (note 54 qn)
    (note 56 qn)
    (par (note 58 qn) (note-event "green"))
    (note 58 qn)
    (note 58 hn)
    (par (note 56 qn) (note-event "purple"))
    (note 56 qn)
    (note 56 hn)
    (par (note 58 qn) (note-event "red"))
    (note 58 qn)
    (note 58 hn)

    (par (note 58 qn) (note-event "blue"))
    (note 56 qn)
    (note 54 qn)
    (note 56 qn)
    (par (note 58 qn) (note-event "green"))
    (note 58 qn)
    (note 58 hn)
    (par (note 56 qn) (note-event "purple"))
    (note 56 qn)
    (par (note 58 qn) (note-event "red"))
    (par (note 56 qn) (note-event "green"))
    (par (note 54 hn) (note-event "blue"))))

(define handlers (make-note-handlers))

(reactive-canvas 100 100
  "blue"
  (lambda (st canv)
    (begin
      (canvas-rectangle! canv 0 0 100 100 "outline" "black")
      (canvas-rectangle! canv 10 10 80 80 "solid" st)))
  (lambda (msg st)
    (match msg
      [(event-note color) color]))
  (on-note handlers))

(display
  (mod (note-handlers handlers)
    (mod (tempo qn 240)
        mary-had-a-little-lamb)))
</pre>