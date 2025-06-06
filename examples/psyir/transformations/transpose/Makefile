.PHONY: all
all: trans trans_tiled trans_omp trans_omp_tiled
	./trans
	@echo
	./trans_tiled
	@echo
	./trans_omp
	@echo
	./trans_omp_tiled

.PHONY: clean
clean:
	rm -f trans trans_tiled trans_omp trans_omp_tiled
	rm -f trans_tiled.f90 trans_omp.f90 trans_omp_tiled.f90

trans_tiled.f90: trans.f90 tile.py
	psyclone -s tile.py trans.f90 -o trans_tiled.f90

trans_omp.f90: trans.f90 omp.py
	psyclone -s omp.py trans.f90 -o trans_omp.f90

trans_omp_tiled.f90: trans.f90 omp-tile.py
	psyclone -s omp-tile.py trans.f90 -o trans_omp_tiled.f90

%: %.f90
	gfortran -O2 -fopenmp $< -o $@
