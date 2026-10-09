// Copied from https://github.com/maxdan94/Density-Friendly/blob/master/exactDF.cpp (09/10/26)

/*
Maximilien Danisch
Mai 2016
http://bit.ly/maxdan94
maximilien.danisch@telecom-paristech.fr

Info:
Feel free to use these lines as you wish. This program computes the exact density-friendly decomposition.

To compile:
g++ exactDF.cpp -fopenmp -fpermissive -o exactDF -O3

To execute:
./exactDF ncpu iter net.txt rates.txt pavafit.txt cuts.txt exact.txt

- nthreads is the number of threads to use
- iter is the number of iterations over all edges to perform
- net.txt should contain the graph (one edge on each line: 2 unsigned separated by a space)
- rates.txt will contain the density value for each node
- pavafit.txt will contain the profile given by the PAVA fit, that is the week approximation of the density-friendly ("size density density-upperbound" on each line)
- cuts.txt will contain the profile given by correct cuts, that is the strong approximation of the density-friendly ("size density density-upperbound" on each line)
- exact.txt will contain the exact density-friendly ("size density" on each line (it is not necesarily in decreasing order of density))
Some information will be printed in the terminal.


*/

#include <Rcpp.h>
#include <cstdlib>


//fit data structure:
typedef struct {
	unsigned n;//total number of aggregated points
	unsigned *nag;//nag[i]=number of points aggregated in i
	double *val;//val[i]=value of the aggregated points
} isoreg;

//Pool Adjacent Violators Algorithm. Values to fit in vect and size of vect.
isoreg *_density_friendly_pava(double *vect,unsigned n){
	isoreg *fit=(isoreg*)malloc(sizeof(isoreg));
	unsigned *nag=(unsigned*)malloc(n*sizeof(unsigned));
	double *val=(double*)malloc(n*sizeof(double));
	unsigned i,j;

	nag[0]=1;
	val[0]=vect[0];
	j=0;
	for (i=1;i<n;i++){
		j+=1;
		val[j]=vect[i];
		nag[j]=1;
		while ((j>0) && (val[j]>val[j-1]-1e-10)){//do val[j]>val[j-1] to have a non-increasing monotonic regression.
			val[j-1]=(nag[j]*val[j]+nag[j-1]*val[j-1])/(nag[j]+nag[j-1]);
			nag[j-1]+=nag[j];
			j--;
		}
	}
	fit->n=j+1;
	fit->nag=nag;
	fit->val=val;
	return fit;
}

// JQ: Added for usage in R
// [[Rcpp::export]]
Rcpp::NumericVector density_friendly_pava(Rcpp::NumericVector x) {
  // pava() fits a non-increasing sequence, so negate in and out
  Rcpp::NumericVector neg = -x;
  isoreg *fit = _density_friendly_pava(neg.begin(), neg.size());
  Rcpp::NumericVector out(x.size());
  R_xlen_t k = 0;
  for (unsigned b = 0; b < fit->n; b++)
    for (unsigned i = 0; i < fit->nag[b]; i++) out[k++] = -fit->val[b];
  free(fit->nag); free(fit->val); free(fit);
  return out;
}
