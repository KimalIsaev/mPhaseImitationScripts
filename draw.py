import matplotlib.pyplot as plt
from pathlib import Path
import sys
numbers = []
with open(Path(sys.argv[1]), "r") as f:
    for l in f:
        numbers.append(float(l))

i = len(numbers) - 1
while (numbers[i] == 0): i-=1
numbers = numbers[:i+1]

plt.plot(numbers)
plt.savefig(Path(sys.argv[2]))
