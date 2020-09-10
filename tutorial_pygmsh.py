
from pygmsh.built_in.geometry import Geometry
resolution = 0.01

# Channel parameters
L = 2.2
H = 0.41
c = [0.2, 0.2, 0]
r = 0.05

# Initialize empty geometry and create circular object
geometry = Geometry()
circle = geometry.add_circle(c, r, lcar=resolution)


# Add points with finer resolution on left side
points = [geometry.add_point((0, 0, 0), lcar=resolution),
          geometry.add_point((L, 0, 0), lcar=5*resolution),
          geometry.add_point((L, H, 0), lcar=5*resolution),
          geometry.add_point((0, H, 0), lcar=resolution)]

# Add lines between all points creating the rectangle
channel_lines = [geometry.add_line(points[i], points[i+1])
                 for i in range(-1, len(points)-1)]

# Create a line loop and plane surface for meshing
channel_loop = geometry.add_line_loop(channel_lines)
plane_surface = geometry.add_plane_surface(
    channel_loop, holes=[circle.line_loop])


volume_marker = 6
geometry.add_physical([plane_surface], 6)
inflow = 1
geometry.add_physical([channel_lines[0]], inflow)
outflow = 2
geometry.add_physical([channel_lines[2]], outflow)
walls = 3
geometry.add_physical([channel_lines[1], channel_lines[3]], walls)
obstacle = 4
geometry.add_physical(circle.line_loop.lines, obstacle)


from pygmsh import generate_mesh
mesh = generate_mesh(
        geometry, prune_z_0=True,
        geo_filename="mesh.geo", msh_filename="mesh.msh")
