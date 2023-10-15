use<stylus.scad>

selected = "body"; // ["body", "head"]

if(selected == "body")
{
    stylus();
}
else
{
    head();
}