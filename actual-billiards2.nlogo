
globals [s1 s2 score x3 y3 direction-x direction-y indicator stripecount solidcount eightballcount]
turtles-own [vx vy stripe solid whiteball eightball]

breed [ cues cue]


;creating pool balls and initial velocities and locations etc.
;also indicators for which type of ball: solid, stripe, white, eight


to setup
  resize-world
  -21 21 -11 11
  ca

 crt 1 [
    set shape "circle"
    set color white
    set x3 10
    set y3 0
    set whiteball 1
    setxy x3 y3
    set vx 0
    set vy 0
  ]


   crt 1 [
    set shape "1ball"
    setxy -7 0
    set solid 1
    set vx 0
    set vy 0
  ]

  crt 1 [
    set shape "11ball"
    setxy -8 -0.5
    set heading 0
    set vx 0
    set vy 0
    set stripe 1
  ]

   crt 1 [
    set shape "2ball"
    setxy -8 0.5
    set vx 0
    set vy 0
    set solid 1
  ]

   crt 1 [
    set shape "12ball"
    setxy -9 1
    set vx 0
    set vy 0
    set heading 0
    set stripe 1
  ]


   crt 1 [
    set shape "8ball"
    setxy -9 0
    set vx 0
    set vy 0
    set eightball 1
  ]


   crt 1 [
    set shape "13ball"
    setxy -9 -1
    set vx 0
    set vy 0
    set heading 0
    set stripe 1
  ]


   crt 1 [
    set shape "4ball"
    setxy -10 1.5
    set vx 0
    set vy 0
    set solid 1
  ]

   crt 1 [
    set shape "14ball"
    setxy -10 0.5
    set vx 0
    set vy 0
    set heading 0
    set stripe 1
  ]

   crt 1 [
    set shape "10ball"
    setxy -10 -0.5
    set vx 0
    set vy 0
    set heading 0
    set stripe 1
  ]

   crt 1 [
    set shape "6ball"
    setxy -10 -1.5
    set vx 0
    set vy 0
    set solid 1
  ]


   crt 1 [
    set shape "7ball"
    setxy -11 2
    set vx 0
    set vy 0
    set solid 1
  ]

   crt 1 [
    set shape "15ball"
    setxy -11 1
    set vx 0
    set vy 0
    set heading 0
    set stripe 1
  ]

   crt 1 [
    set shape "3ball"
    setxy -11 0
    set vx 0
    set vy 0
    set solid 1
  ]

   crt 1 [
    set shape "9ball"
    setxy -11 -1
    set vx 0
    set heading 0
    set vy 0
    set stripe 1
  ]

   crt 1 [
    set shape "5ball"
    setxy -11 -2
    set vx 0
    set vy 0
    set solid 1
  ]

  ;pool cue setup
  create-cues 1 [
    set shape "cue"
    set size 5
    setxy x3 y3

  ]






  ask patches [
; board setup/ coloring
    set pcolor green

    if pxcor = -19 or pxcor = 19 or pycor = 9 or pycor = -9
    [set pcolor 52]

    if pxcor = -20 or pxcor = 20 or pycor = 10 or pycor = -10
    [set pcolor brown]

    if pxcor = -21 or pxcor = 21 or pycor = 11 or pycor = -11
    [set pcolor brown]


;holes for pool balls setup
    if pxcor = 0 and pycor = 8
    [set pcolor black]

    if pxcor = 0 and pycor = -8
    [set pcolor black]

    if pxcor = 18 and pycor = -8
    [set pcolor black]

    if pxcor = -18 and pycor = 8
    [set pcolor black]

    if pxcor = 18 and pycor = 8
    [set pcolor black]

    if pxcor = -18 and pycor = -8
    [set pcolor black]











  ]

end

to go

  ;wait 1
  ask turtle 0 [
    set x3 xcor
    set y3 ycor
  ]

  if indicator = True [

  ask turtle 16 [
      ;setting oreintation of pool cue to face mouse
      ;setting location of pool cue to be at the white ball
       show-turtle
       setxy x3 y3

      facexy mouse-xcor mouse-ycor
    ]
      ;make standstill code if statement
      if mouse-down? = True
     [

      ;basically I envisioned 2 triangles here
        ;one that uses power of the slider to calculate theta
        ;and another that uses that theta value to calculate the appropriate vy and vx based on the distance between mouse coordinates and white ball coordinates
      let x4 mouse-xcor
      let y4 mouse-ycor
      set direction-x abs(x4 - x3)
      set direction-y abs(y4 - y3)
      ask turtle 0 [

          ;getting theta
        let theta atan direction-y direction-x
           ;finding appropriate vx vy
          ifelse mouse-xcor < x3
          [set vx (Power * cos(theta)) * -1 ]
          [set vx (Power * cos(theta))]


          ifelse mouse-ycor < y3
          [set vy (Power * sin(theta)) * -1 ]
          [set vy (Power * sin(theta))]


        set indicator False
          ask turtle 16 [ hide-turtle ]
        ]
      ]
    ]





  ;initiates collision with any pool ball
  ask turtles [
  let my-who who
    ask turtles with [who > my-who and who != 16]  [
     let p collide (turtle my-who) (turtle who)

      ]
  ]





; ball into hole + adding to scoreboard depending on pool ball type(solid or stripe)
ask turtles [

    if ((pxcor > -1) and (pxcor < 1)) and ((pycor > 7) and (pycor < 9))
    [ die



    ]
    ;score setting for stripes and solids
    set stripecount (7 - count turtles with [stripe = 1])
    set solidcount  (7 - count turtles with [solid = 1])





    ;intitiates loss for eight ball
    set eightballcount (count turtles with [eightball = 1])
    if eightballcount = 0 and solidcount != 7 and stripecount != 7  [
     ask patch 6 0 [
      set plabel "You lost, humongous L. Press Setup to play again"
      ]
    ]
    ; Win Screen

     if eightballcount = 0 and solidcount = 7
    [ ask patch 6 0 [ set plabel ""
      set plabel "You won! Humongous W. Press Setup to play again"
      ]
    ]
    if eightballcount = 0 and stripecount = 7
    [ ask patch 6 0 [ set plabel ""
      set plabel "You won! Humongous W. Press Setup to play again"
      ]
    ]
    ;reset for white ball
    ask turtle 0 [
    if ((pxcor > -1) and (pxcor < 1)) and ((pycor < -7) and (pycor > -9))
    [ setxy 10 0
       set vx 0
       set vy 0
      ]

       if ((pxcor > -1) and (pxcor < 1)) and ((pycor > 7) and (pycor < 9))
    [ setxy 10 0
       set vx 0
       set vy 0
      ]

    if ((pxcor > 17) and (pxcor < 19)) and ((pycor < -7) and (pycor > -9))
    [ setxy 10 0
    set vx 0
       set vy 0    ]



    if ((pxcor < -17) and (pxcor > -19)) and ((pycor > 7) and (pycor < 9))
    [ setxy 10 0
       set vx 0
       set vy 0

    ]

    if ((pxcor < 19) and (pxcor > 17)) and ((pycor > 7) and (pycor < 9))
    [setxy 10 0
        set vx 0
       set vy 0

    ]

    if ((pxcor > -19 ) and (pxcor < -17)) and ((pycor < -7) and (pycor > -9))
    [ setxy 10 0
        set vx 0
       set vy 0

    ]
    ]
; death for all other balls except for white
         if ((pxcor > -1) and (pxcor < 1)) and ((pycor > 7) and (pycor < 9))
    [ die
      ]
    if ((pxcor > -1) and (pxcor < 1)) and ((pycor < -7) and (pycor > -9))
    [ die ]


    if ((pxcor > 17) and (pxcor < 19)) and ((pycor < -7) and (pycor > -9))
    [ die ]



    if ((pxcor < -17) and (pxcor > -19)) and ((pycor > 7) and (pycor < 9))
    [ die

    ]

    if ((pxcor < 19) and (pxcor > 17)) and ((pycor > 7) and (pycor < 9))
    [die

    ]

    if ((pxcor > -19 ) and (pxcor < -17)) and ((pycor < -7) and (pycor > -9))
    [ die

    ]

  ]
  ;code for slowing the balls down over time
ask turtles [
    if abs(vx) > 0  [
      set vx (vx * 0.97 )]
    if abs(vy) > 0 [
        set vy (vy * 0.97 )]
    if sqrt ((abs(vy) + abs(vx)) / 2) < 0.1
    [set vx 0]
    if sqrt ((abs(vy) + abs(vx)) / 2) < 0.1
    [set vy 0]


;factoring in velocity into coordinates for next position

 setxy ( xcor + vx ) (ycor + vy)






    ;wall bounce code
  if xcor > -19 and xcor < -18

    [set vx ( vx * -1) ]

  if xcor > 18 and xcor < 19

    [set vx ( vx * -1 )
    ]

  if ycor < 9 and ycor > 8
        [set vy ( vy * -1 ) ]

   if ycor > -9 and ycor < -8
    [set vy ( vy * -1) ]



  ]

  wait 0.05
end
to-report collide [t1 t2]
  let answer 0

  ; first check if the turtles overlap, and if not, get out
  ask t1 [
    if distance t2 >= size [ set answer false ]
  ]
  if answer = false [report false]
  ; make turtle positions and velocities into vectors
  let t1x (list ([xcor] of t1) ([ycor] of t1))
  let t1v (list ([vx] of t1) ([vy] of t1))
  let t2x (list ([xcor] of t2) ([ycor] of t2))
  let t2v (list ([vx] of t2) ([vy] of t2))

  ; collision unit vector (from t1's center to t2's center)
  let vcoll v-unit (v-sub t2x t1x)

  ; now find the parallel and perpendiculr components of each turtle's velocity with respect to the collision unit vector
  let t1-parallel v-mult vcoll (v-dot vcoll t1v)
  let t1-perpendicular v-sub t1v t1-parallel
  let t2-parallel v-mult vcoll (v-dot vcoll t2v)
  let t2-perpendicular v-sub t2v t2-parallel

  ; check whether the turtles are going away from each other already, and if so, get out
  if v-dot t1-parallel vcoll < 0 [ report false ]

  ; turtles exchange parallel velocities after the collision (simplification because they have equal mass)
  let t1new-parallel t2-parallel
  let t2new-parallel t1-parallel
  let t1vnew v-add t1new-parallel t1-perpendicular
  let t2vnew v-add t2new-parallel t2-perpendicular

  ; put the velocities back into the turtles
  ask t1 [
    set vx item 0 t1vnew
    set vy item 1 t1vnew
  ]
  ask t2 [
    set vx item 0 t2vnew
    set vy item 1 t2vnew
  ]

  report true

end

;; ----------------- Vector Operations --------------------
; multiply vector by scalar
to-report v-mult [v s]
  let x (item 0 v) * s
  let y (item 1 v) * s
  report (list x y)
end

; add vectors
to-report v-add [v1 v2]
  let x (item 0 v1) + (item 0 v2)
  let y (item 1 v1) + (item 1 v2)
  report (list x y)
end

; subtract vectors
to-report v-sub [v1 v2]
  report v-add v1 (v-mult v2 -1)
end

; dot product of vectors
to-report v-dot [v1 v2]
  report (item 0 v1) * (item 0 v2) + (item 1 v1) * (item 1 v2)
end

; get unit vector
to-report v-unit [v]
  report v-mult v (1 / sqrt (v-dot v v))
end

;; ---------------------- end Vector Operations -------------------

; debugging printer
to pr [msg v]
  let x precision (item 0 v) 2
  let y precision (item 1 v) 2
  print (word msg " (" x "," y ")")
end
@#$#@#$#@
GRAPHICS-WINDOW
282
57
2050
1007
-1
-1
40.930233
1
30
1
1
1
0
0
0
1
-21
21
-11
11
0
0
1
ticks
30.0

BUTTON
72
93
221
126
NIL
Setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
74
148
137
181
NIL
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
27
31
206
64
Billiards!
27
0.0
1

MONITOR
73
332
154
377
Stripe score
stripecount
17
1
11

SLIDER
72
267
244
300
Power
Power
0
1.5
1.5
0.1
1
NIL
HORIZONTAL

BUTTON
74
203
200
236
Ready to shoot? 
set indicator True
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
73
399
145
444
Solid score
solidcount
17
1
11

TEXTBOX
30
67
180
85
By: Tim Goretsky
11
0.0
1

TEXTBOX
73
185
313
213
Click below to indicate you want to shoot...
11
0.0
1

TEXTBOX
74
468
224
486
Click to shoot...
11
0.0
1

@#$#@#$#@
## WHAT IS IT?

Playing the wonderful game of pool on netlogo by yours truly Tim Goretsky



**Usage:**

First click the setup button to generate the board, balls and cue

Then click the go button in order to start all sequences, which then awaits your 
click on "ready-to-shoot?" which indicates your intention to shoot. 

Then change your desired power level with the slider and click anywhere on the board to shoot the ball!

## Known Bugs

Unfortunately sometimes the balls like to clip into eachother, while not often this can be a bit annoying but I have had no luck in fixing it.

And as well, if a ball hits the wall at high power, it can sort of jitter for a bit but this is no big deal

Finally, sometimes if the power level is set too high and the colliding ball is too close, there can be clipping issues. The white ball also sometimes causes an error when it enters a hole too quickly, but this is rare. 

This project was an absolutely debugging nightmare but I can happily say I have seen no actual bugs with performance and the game is absolutely playable!




## CREDITS AND REFERENCES

Tim Goretsky
Stuyvesant High School
2022

Assisted by:
Peter Brooks
2022
Stuyvesant High School

Anton Goretsky
Helper and subject to my frustrated rants regarding "WHY IS IT NOT WORKING?!?!?"

P.S
 Although this project was mentally agonizing I am very glad I stuck with it through the end and this has still been a fantastic learning experience and I even have a cool game to show for it!
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

10ball
true
0
Circle -1 true false -3 -3 306
Rectangle -13345367 true false 0 105 300 210

11ball
true
0
Circle -1 true false -12 -12 324
Rectangle -2674135 true false 0 90 300 210

12ball
true
0
Circle -1 true false -12 -12 324
Rectangle -8630108 true false 0 90 300 225

13ball
true
0
Circle -1 true false 2 2 295
Rectangle -955883 true false 15 105 15 105
Rectangle -955883 true false 0 105 300 210

14ball
true
0
Circle -1 true false -3 -3 306
Rectangle -10899396 true false 0 105 300 210

15ball
true
0
Circle -1 true false -4 -4 309
Rectangle -5825686 true false 0 105 300 210

1ball
true
0
Circle -1184463 true false 0 0 300

2ball
true
0
Circle -13345367 true false -3 -3 306

3ball
true
0
Circle -2674135 true false 2 2 295

4ball
true
0
Circle -8630108 true false -4 -4 309

5ball
true
0
Circle -955883 true false 2 2 295

6ball
true
0
Circle -14835848 true false -4 -4 309

7ball
true
0
Circle -2064490 true false 150 150 0
Circle -5825686 true false 2 2 297

8ball
true
0
Circle -16777216 true false 0 0 300

9ball
true
0
Circle -1 true false -4 -4 309
Rectangle -1184463 true false 0 105 300 210

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cue
true
0
Rectangle -1 true false 195 135 195 135
Rectangle -1 true false 135 195 165 225
Rectangle -6459832 true false 135 225 165 555

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

testball
true
0
Circle -1 true false 135 135 30
Rectangle -11221820 true false 135 150 165 150

testball2
true
0
Circle -1 true false -3 -3 306
Rectangle -11221820 true false 0 105 300 195

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

whiteball
true
0
Circle -1 true false 105 105 90

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
