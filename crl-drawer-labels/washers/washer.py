import os

M2 = [["\\u2B22    ", "  M2", "thin"], ["\\u2B22    ", "  M2", "thick"]]
M2_5= [["\\u2B22       ", "  M2.5", "thin"], ["\\u2B22       ", "  M2.5", "thick"], ["\\u25A0       ", "  M2.5", "square"], ["\\u2B22       ", "  M2.5", "nylock"]]
M3 = [["\\u2B22    ", "  M3", "thin"], ["\\u2B22    ", "  M3", "thick"], ["\\u25A0    ", "  M3", "square"], ["\\u2B22    ", "  M3", "nylock"]]

for m in M2:
    str_body = "openscad -o {}_body.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=false' hex.scad".format(str("M2_" + m[2]), *m)
    str_txt = "openscad -o {}_txt.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=true' hex.scad".format(str("M2_" + m[2]), *m)

    os.system(str_body)
    os.system(str_txt)

for m in M2_5:
    str_body = "openscad -o {}_body.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=false' hex.scad".format(str("M2_5_" + m[2]), *m)
    str_txt = "openscad -o {}_txt.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=true' hex.scad".format(str("M2_5_" + m[2]), *m)

    os.system(str_body)
    os.system(str_txt)

for m in M3:
    str_body = "openscad -o {}_body.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=false' hex.scad".format(str("M3_" + m[2]), *m)
    str_txt = "openscad -o {}_txt.stl -D 'symbol=\"{}\"' -D 'label=\"{}\"'  -D 'spec=\"{}\"' -D 'is_text=true' hex.scad".format(str("M3_" + m[2]), *m)

    os.system(str_body)
    os.system(str_txt)