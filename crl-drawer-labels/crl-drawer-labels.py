import os

M2 = ['M2x6', 'M2x8', 'M2x10', 'M2x12', 'M2x16']
M2_5= ['M2.5x5', 'M2.5x6', 'M2.5x8', 'M2.5x10', 'M2.5x12', 'M2.5x16','M2.5x20']
M3 = ['M3x4', 'M3x5', 'M3x6', 'M3x8', 'M3x19' 'M3x12', 'M3x18', 'M3x20', 'M3x25', 'M3x30', 'M3x35', 'M3x40',
      'M3x45', 'M3x50']

for i in range(len(M2)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' crl-drawer-labels.scad".format(M2[i], M2[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' crl-drawer-labels.scad".format(M2[i], M2[i])

    os.system(str_body)
    os.system(str_txt)

for i in range(len(M2_5)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' crl-drawer-labels.scad".format(M2_5[i], M2_5[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' crl-drawer-labels.scad".format(M2_5[i], M2_5[i])

    os.system(str_body)
    os.system(str_txt)

for i in range(len(M2)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' crl-drawer-labels.scad".format(M3[i], M3[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' crl-drawer-labels.scad".format(M3[i], M3[i])

    os.system(str_body)
    os.system(str_txt)