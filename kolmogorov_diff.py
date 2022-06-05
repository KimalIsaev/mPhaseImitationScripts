import matplotlib.pyplot as plt
from pathlib import Path
import sys

def consec_sum(l):
    return list(map(sum, list(reversed([list(reversed(list(islice(list(reversed(l)), x, None)))) for x in range(len(l))]))))

def filename_to_numbers(name):
    numbers = []
    with open(Path(name), "r") as f:
        for l in f:
            numbers.append(float(l))
    i = len(numbers) - 1
    while (numbers[i] == 0): i-=1
    numbers = numbers[:i+1]
    return numbers

def normalize(a):
    s = sum(a)
    return [e/s for e in a]

def kolmogorov(a1, a2):
    return max([abs(x1-x2) for (x1, x2) in zip(a1, a2)])

min_numbers1 = filename_to_numbers(sys.argv[1])
min_numbers2 = filename_to_numbers(sys.argv[2])

max_length = max(len(min_numbers1), len(min_numbers2))
pre_numbers1 = normalize(min_numbers1 + [0]*(max_length - len(min_numbers1) + 1))
pre_numbers2 = normalize(min_numbers2 + [0]*(max_length - len(min_numbers2) + 1))
numbers1 = consec_sum(pre_numbers1)
numbers2 = consec_sum(pre_numbers2)
print(kolmogorov(numbers1, numbers2))


plt.plot(numbers2, label='P2(i)')
plt.plot(numbers1, linestyle = '--', label='P(i)')
plt.xlabel('i')
plt.ylabel('P2(i), P(i)')
plt.legend()
plt.grid(True)
plt.savefig(Path(sys.argv[3]))

