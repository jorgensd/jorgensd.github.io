def md_to_python(filename):
    infile = open(filename, "r")
    text = infile.read()
    infile.close()
    splitted_text = text.split("```python")[1:]
    python_code = [i.split("```")[0] for i in splitted_text]
    outname = filename.split(".md")[0]
    outfile = open(outname+".py", "w")
    outfile.write("\n".join(python_code))


md_to_python("tutorial_pygmsh.md")