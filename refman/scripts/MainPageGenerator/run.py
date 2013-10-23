from MainPageGenerator import *
import os, sys

if len(sys.argv) == 3:
    PATH = sys.argv[1]
    OUTF = sys.argv[2]    
      
    os.system("cp -rf %s/iframes/ %s" % (os.path.split(__file__)[0], PATH))
    
    l = MainPageGenerator(PATH)
    
    l.CreateNewMainPage(OUTF)
else:
    print "parameter error. It must be like this: run.py /doc/html/ output.html"
