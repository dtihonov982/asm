#include <stdio.h>
#include <string.h>

extern int rarea(int, int);
extern int rcircum(int, int);
#if 0
extern double carea(double);
extern double ccircum(double);
extern void sreverse(char *, int);
extern void adouble(double [], int);
extern double asum(double [], int);
#endif

int main() 
{
    char rstring[64];
    int side1, side2, r_area, r_circum;
    double radius, c_area, c_circum;
    double darray[] = {70.0, 83.2, 91.5, 72.1, 55.5};
    long int len;
    double sum;
    //area and circum
    scanf("%d", &side1);
    scanf("%d", &side2);
    r_area = rarea(side1, side2);
    r_circum = rcircum(side1, side2);
    printf("%d %d\n", r_area, r_circum);
    
    return 0;
}
