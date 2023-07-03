import os

M2 = ['M2x6', 'M2x8', 'M2x10', 'M2x12', 'M2x14', 'M2x16', 'M2x18', 'M2x20']

for i in range(len(M2)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' crl-drawer-labels.scad".format(M2[i], M2[i])
    # need something like
    # ```openscad -o M2x20.stl -D 'param="M2x20"' -D "is_text=false" crl-drawer-labels.scad ```
    # but it keeps fucking up lmao
    print(str_body)
    #os.system(str_body)