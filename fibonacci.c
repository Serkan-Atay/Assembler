#define PRINT_FOLGE_MAIN
#include <stdio.h>

unsigned fit(unsigned int a0)
{
// Fibonacci Zahl
// f[0]=0, f[1]=1],
// n>1: f[n]=f[n-1]+f[n-2]
// Iterative Berechnung
unsigned int t0,v0;
if(a0<2) return a0;
t0=0; // f[n-2]
v0=1; // f[n-1]
// p for previous iteration
while(--a0) {
  v0 = v0+t0; // f[n]   = f_p[n-1] + f_p[n-2]
  t0 = v0-t0; // f[n-1] = f_[n]    - f_p[n-2]
  };
return v0;
} 

unsigned fre(unsigned int a0)
{
// Fibonacci Zahl
// f[0]=0, f[1]=1],
// n>1: f[n]=f[n-1]+f[n-2]
// Rekursive Berechnung
// Eigentlich voelliger Unsinn
// Nur zur Demonstration der Rekursion
if(a0<2) return a0;
return fre(a0-1)+fre(a0-2);
} 

//#define FIB fit // iterativ
#define FIB fre // rekursiv
int main()
{
unsigned int i,n;
printf("Berechnung der Fibonacci Zahl f[n] mod 2^32\n");
printf("n>");
scanf("%u",&n);
i=0;
#ifdef PRINT_FOLGE_MAIN
for(;i<n;i++) printf("f[%3d]:%10u\n",i,FIB(i));
#endif /* PRINT_FOLGE_MAIN */
printf("f[%3d]:%10u\n",n,FIB(n));
return 0;
}
