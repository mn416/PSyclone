.PHONY: all
all: matmul matmul_tiled matmul_omp matmul_omp_tiled \
     matmul_omp_tiled_reordered
	./matmul
	@echo
	./matmul_tiled
	@echo
	./matmul_omp
	@echo
	./matmul_omp_tiled
	@echo
	./matmul_omp_tiled_reordered

.PHONY: clean
clean:
	rm -f matmul matmul_tiled matmul_omp matmul_omp_tiled
	rm -f matmul_omp_tiled_reordered
	rm -f matmul_tiled.f90 matmul_omp.f90 matmul_omp_tiled.f90
	rm -f matmul_omp_tiled_reordered.f90

matmul_tiled.f90: matmul.f90 tile.py
	psyclone -s tile.py matmul.f90 -o matmul_tiled.f90

matmul_omp.f90: matmul.f90 omp.py
	psyclone -s omp.py matmul.f90 -o matmul_omp.f90

matmul_omp_tiled.f90: matmul.f90 omp-tile.py
	psyclone -s omp-tile.py matmul.f90 -o matmul_omp_tiled.f90

matmul_omp_tiled_reordered.f90: matmul.f90 omp-tile-reorder.py
	psyclone -s omp-tile-reorder.py matmul.f90 \
          -o matmul_omp_tiled_reordered.f90

%: %.f90
	gfortran -O2 -fopenmp $< -o $@
