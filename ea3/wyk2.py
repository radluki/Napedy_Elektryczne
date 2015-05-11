import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

nAC = 'AC182.csv'
ntyr = 'r_tyrystorowy.csv'
nW = 'wyprostowane152.csv'
nazwy = [nAC, nW, ntyr]
# Zależność prędkości obrotowej od napięcia
colors = ['r','b','g']
labels = ['przemienny 182V', 'r. tyrystorowy', 'wyprostowane 152V']
i=0
for filename in nazwy:
	plt.figure(1)
	data = pd.read_csv(filename,' ',decimal = ',')
	plt.xlabel('')
	plt.ylabel('')
	plt.title('')
	P0 = 1.2*data['n']**2*1e-6 + 1.1*data['n']*1e-3
	Pod = data['Up']*data['Ip']
	#print(Pod/Pod)
	Pcu = 26*data['Ip']**2
	Podsil = P0 + Pcu + Pod
	T = Podsil / (2*np.pi/60*data['n'])
	ni = Podsil / data['P']
	plt.scatter(data['n'],ni,color=colors[i],label=labels[i])
	
	#print(data['n'])
	# interpolacja
	q = np.linspace(min(data['n']),max(data['n']),100)
	z = np.polyfit(data['n'],ni,3)
	p = np.poly1d(z)
	plt.plot(q,p(q),color = colors[i])
	plt.figure(2)
	plt.scatter(T,data['n'], color = colors[i], label = labels[i])
	q2 = np.linspace(min(T),max(T),100)
	z2 = np.polyfit(T,data['n'],3)
	p2 = np.poly1d(z2)
	plt.plot(q2,p2(q2),color = colors[i])
	i=i+1
plt.figure(1)
plt.title('Sprawność')
plt.xlabel('prędkość obrotowa n [obr/min]')
plt.ylabel('sprawność $\eta$ [%]')
plt.legend()
plt.savefig('Sprawnosc.eps')
plt.figure(2)
plt.xlabel('T [Nm]')
plt.ylabel('n [obr/min]')
plt.legend()
plt.savefig('Moment.eps')
plt.show()

	
