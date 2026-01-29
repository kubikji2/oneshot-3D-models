import os

M5_BOLTS = ["M5\\ stone", "M5x6", "M5x8", "M5x10", "M5x12", "M5x14"]

for i in range(len(M5_BOLTS)):
    str_body = "openscad -o {}_body.stl -D 'label=\"{}\"' -D 'is_text=false' ../screws/crl-drawer-labels.scad".format(M5_BOLTS[i], M5_BOLTS[i])
    str_txt = "openscad -o {}_txt.stl -D 'label=\"{}\"' -D 'is_text=true' ../screws/crl-drawer-labels.scad".format(M5_BOLTS[i], M5_BOLTS[i])

    os.system(str_body)
    os.system(str_txt)


M5_WASHER = [["\\u29BF    ", "  M5", ""]]

for w in M5_WASHER:
    str_body = "openscad -o {}_body.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=false' ../washers/washer.scad".format(str("M5_washer"), *w)
    str_txt = "openscad -o {}_txt.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=true' ../washers/washer.scad".format(str("M5_washer"), *w)

    os.system(str_body)
    os.system(str_txt)

M5_NUT = [["\\u2B22    ", "  M5", "regular"]]

for m in M5_NUT:
    str_body = "openscad -o {}_nut_body.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=false' ../nuts/hex.scad".format(str("M5_" + m[2]), *m)
    str_txt = "openscad -o {}_nut_txt.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=true' ../nuts/hex.scad".format(str("M5_" + m[2]), *m)

    os.system(str_body)
    os.system(str_txt)
