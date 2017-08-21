This is a simulation of a group of bacteria living on a petri dish. Each bacteria spawns with half a nutrient bar and looks for a direction where it feels it may find more nutrients. Each bacteria has a 'memory' of about three seconds, meaning it'll look for a different direction to go each 3 seconds.
It'll consume nutrients over time to stay alive. If it reaches a full bar it'll devide into two copies of itself. It the bar reaches nothing, it'll die.

COMMANDS:

N - Add N bacteria
n - N == 1
2 - N == 10
3 - N == 100
4 - N == 1000
5 - N == 10000
mouseclick - Add food

K - Make bacteria transparent (very useful to vizualize large numbers),
J - Show nutrition bar.
L - Show lines indicanting the destination of the bacteria.
C - clear screen.

The .exe file and related .dlls can be found at the bac-sandbox folder.

The simulation was made with Lua and rendered with Love2D.

