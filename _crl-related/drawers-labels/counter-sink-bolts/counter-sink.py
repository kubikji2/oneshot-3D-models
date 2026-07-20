import os


M3_COUNTERSINK = ["M3x5", "M3x8", "M3x10", "M3x12", "M3x14", "M3x16", "M3x20"]

for i in range(len(M3_COUNTERSINK)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' ../screws/crl-drawer-labels.scad".format(M3_COUNTERSINK[i], M3_COUNTERSINK[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' ../screws/crl-drawer-labels.scad".format(M3_COUNTERSINK[i], M3_COUNTERSINK[i])

    os.system(str_body)
    os.system(str_txt)


M2P5_COUNTERSINK = ["M2.5x4", "M2.5x5"]

for i in range(len(M2P5_COUNTERSINK)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' ../screws/crl-drawer-labels.scad".format(M2P5_COUNTERSINK[i], M2P5_COUNTERSINK[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' ../screws/crl-drawer-labels.scad".format(M2P5_COUNTERSINK[i], M2P5_COUNTERSINK[i])

    os.system(str_body)
    os.system(str_txt)

