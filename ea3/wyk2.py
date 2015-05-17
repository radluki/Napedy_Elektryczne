import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

nAC = 'AC182.csv'
ntyr = 'r_tyrystorowy.csv'
nW = 'wyprostowane152.csv'
nazwy = [nAC, ntyr, nW]
# Zależność prędkości obrotowej od napięcia
colors = ['r','b','g']
labels = ['przemienny', 'r. tyrystorowy', 'wyprostowane']
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
	ni = Podsil / data['P']*100
	plt.scatter(Podsil,ni,color=colors[i],label=labels[i])
	
	#print(data['n'])
	# interpolacja
	q = np.linspace(min(Podsil),max(Podsil),100)
	z = np.polyfit(Podsil,ni,1)
	p = np.poly1d(z)
	plt.plot(q,p(q),color = colors[i])
	plt.figure(2)
	plt.scatter(data['n'],T, color = colors[i], label = labels[i])
	q2 = np.linspace(min(data['n']),max(data['n']),100)
	z2 = np.polyfit(data['n'],T,1)
	p2 = np.poly1d(z2)
	plt.plot(q2,p2(q2),color = colors[i])
	i=i+1
plt.figure(1)
plt.title('Sprawność')
plt.xlabel('P_{odsil} [W]')
plt.ylabel('sprawność $\eta$ [%]')
plt.legend(loc = 'lower right')
plt.savefig('Sprawnosc.eps')
plt.savefig('Sprawnosc.png')
plt.figure(2)
plt.title('Moment')
plt.ylabel('T [Nm]')
plt.xlabel('n [obr/min]')
plt.legend()
x1,x2,y1,y2 = plt.axis()
plt.ylim((0,y2))
plt.savefig('Moment.eps')
plt.savefig('Moment.png')
plt.show()

	
