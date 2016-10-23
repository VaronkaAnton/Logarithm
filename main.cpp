#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;
extern "C" int __cdecl Iterations(double e);
int main() 
{
	double eps = 1;
	for (int i = 1; i < 9; i++)
	{
		eps /= 10;
		cout << i << " correct digits: " << Iterations(eps) << " iterations" << endl;
	}
		cout << log(2) << endl;
	return 0;
}