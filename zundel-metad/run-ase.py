from ase.calculators.cp2k import CP2K
from ase.calculators.socketio import SocketClient, SocketIOCalculator
from ase.io import read

# ###### Define geometry from atoms object   ################

atoms = read("h5o2+.xyz")

# Set CP2K calculator #################

workdir = "CP2Ktest"
aux_settings = {"label": workdir}
calc = CP2K(**aux_settings)

port_ase_calc = 12345

# ################# Create Client ############################

port_ipi = 20614 # needs to match the port in input.xml
host_ipi = "localhost"
client = SocketClient(host=host_ipi, port=port_ipi)

# ################# Create ASE SERVER ############################

with SocketIOCalculator(calc, log="socketio.log", port=port_ase_calc) as io_calc:
    atoms.set_calculator(io_calc)
    client.run(atoms)
