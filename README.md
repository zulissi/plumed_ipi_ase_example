# plumed_ipi_ase_example

Proof of concept for how an ASE potential can be connected to a PLUMED service based on some of the examples from the i-PI repo. 

Instructions:
* Run the i-pi/plumed socket server
  * `docker build -t plumed_ipi_ase_example . && docker run -it --rm plumed_ipi_ase_example`
* While that is running, start the ASE/xtb client calculator
  * Get the container id with `docker ps`
  * `docker exec -it <CONTAINER_ID> python run-ase.py`
