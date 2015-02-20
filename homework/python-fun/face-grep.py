import cv2
import os
import sys
from string import Template

# first argument is the haarcascades path
face_cascade_path = sys.argv[1]
face_cascade = cv2.CascadeClassifier(os.path.expanduser(face_cascade_path))

scale_factor = 1.1
min_neighbors = 3
min_size = (30, 30)
flags = cv2.cv.CV_HAAR_SCALE_IMAGE

for filename in sys.argv[2:]:
   image_path = os.path.expanduser(filename)
   image = cv2.imread(image_path)

   faces = face_cascade.detectMultiScale(image, scaleFactor = scale_factor, minNeighbors = min_neighbors,
    minSize = min_size, flags = flags)

   for( x, y, w, h ) in faces:
      print "%s:%d,%d,%d,%d"%(filename.split("/")[-1],x,y,w,h)

