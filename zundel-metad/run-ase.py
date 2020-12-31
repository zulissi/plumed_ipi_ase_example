from ase.calculators.socketio import SocketClient, SocketIOCalculator
from ase.io import read
from xtb.ase.calculator import XTB

# ###### Define geometry from atoms object   ################

atoms = read("h5o2+.xyz")

# Set CP2K calculator #################

calc = XTB(method='GFN0-xTB')
atoms.set_calculator(calc)

# ################# Create Client ############################

port_ipi = 20614 # needs to match the port in input.xml
host_ipi = "localhost"
client = SocketClient(host=host_ipi, port=port_ipi)

# ################# Create ASE SERVER ############################

client.run(atoms)
