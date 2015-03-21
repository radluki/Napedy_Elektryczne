// Program usówa zbędne białe znaki
// Przygotowuje plik tekstowy do importu do Calca
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main(int argi, char *argv[])
{
	fstream stream;
	stream.open(argv[1]);
	if(!stream)
		cout<<"\nError: File not open\n";
	ofstream out;
	out.open((string(argv[1])+"2").c_str());
	
	char tmp;
	while(stream.peek()!=EOF)
	{
		tmp=stream.peek();
		if(tmp==' ' || tmp=='\n')
			out<<tmp;
		stream>>tmp;
		out<<tmp;
	}
	return 0;

}
