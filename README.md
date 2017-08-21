This is a simulation of a group of bacteria living on a petri dish. Each bacteria spawns with half a nutrient bar and looks for a direction where it feels it may find more nutrients. Each bacteria has a 'memory' of about three seconds, meaning it'll look for a different direction to go each 3 seconds. <br>
It'll consume nutrients over time to stay alive. If it reaches a full bar it'll devide into two copies of itself. It the bar reaches nothing, it'll die.

COMMANDS:

N - Add N bacteria <br>
n - N == 1  <br>
2 - N == 10 <br>
3 - N == 100 <br>
4 - N == 1000 <br>
5 - N == 10000 <br>
mouseclick - Add food <br>

K - Make bacteria transparent (very useful to vizualize large numbers), <br>
J - Show nutrition bar. <br>
L - Show lines indicanting the destination of the bacteria. <br>
C - clear screen. <br>



The .exe file and related .dlls can be found at the bac-sandbox folder. <br>

The simulation was made with Lua and rendered with Love2D. <br>

