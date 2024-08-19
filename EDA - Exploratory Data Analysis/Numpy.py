import numpy as np

arr1 = np.array([10,20,30,40,50,60,70,80,90],dtype='int8')  # we can customize dtype
print(arr1)

# Numpy Array In built methods & properties
print(arr1.shape)   # shape returns (rows,cols)
print(type(arr1))
print(arr1.dtype)   # dtype returns data type
print(arr1.itemsize)
print(arr1.size)    # Returns totalsize of array
print(arr1.ndim)    # Dimensionality = 1D
print(arr1.nbytes)  # nbytes = Total size of Numpy Array


# Types of Numpy Array

# Create 1D array
arr2 = np.array([10,15,17,27,35.78,45])

# Create 2D array
arr3 = np.array([[10,11,13,14],
                 [13,14,24,45],
                 [23,24,34,45]])

# shape returns (rows,cols)
print(arr3.shape)
print(arr3.ndim)
print(arr3.itemsize)

# 3D array
arr4 = np.array([[[10,11,13,14],
                 [13,14,24,45],
                 [23,24,34,45]],

                 [[80,18,53,14],
                 [33,34,24,46],
                 [43,25,34,95]]]
                 )

# shape returns (matrics,rows,cols)
print(arr4.shape)
print(arr4.ndim)
print(arr4.itemsize)

# Slicing and indexing in Numpy Array

print(arr3[0]) # Slicing for first row elements
print(arr3[:,:]) # All rows and all columns
print(arr3[:,0]) # slicing elements from all rows and first column index
print(arr3[:,0:2]) # slicing first two columns

print(arr3[1:-1,1:-1]) # start index = 1 , stop index = last index position (which is excluded)

# Slicing 3D Numpy Array
print(arr4[1,1,2])

# Create Numpy Array using functions
arr5 = np.arange(1,51)   # Create 1D array
print(arr5)
arr6 = np.arange(1,51).reshape(5,10)
print(arr6)

# Zero matrix - np.zeros(shape)
arr7 = np.zeros((5,7),dtype='int64')  # default is float
print(arr7)

print(arr7.astype('float16'))       # Typecasting from int to float

# Ones matrix - np.ones(shape)
arr8 = np.ones((5,5))
print(arr8)

#Identity matrix
arr9 = np.identity(7)
print(arr9)


# Empty Matrix
arr10 = np.empty((6,1))
print(arr10)

# fill all position with 2.0 float value
arr10.fill(2.0)
print(arr10)

# full
print(np.full(10,6.1))

# Linspace - (start,stop,elements)
# linspace create an evenly spaced array
arr11= print(np.linspace(10,100,10))
print(arr11)

# logspace - N evenly spaced array elements on a log scale between start and stop 
arr12= np.logspace(0,1,10,base=10)
print(arr12)

# Excercise

# [1 1 1 1 1 1 1 1 1 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]
# [1 0 0 0 0 0 0 0 0 1]

arr13 = np.ones((10,10),dtype='int16')

arr13[1:-1,1:-1].fill(0)
print(arr13)

# [[0 1 0 1 0 1 0 1 0 1]
#  [1 0 1 0 1 0 1 0 1 0]
#  [0 1 0 1 0 1 0 1 0 1]
#  [1 0 1 0 1 0 1 0 1 0]
#  [0 1 0 1 0 1 0 1 0 1]
#  [1 0 1 0 1 0 1 0 1 0]
#  [0 1 0 1 0 1 0 1 0 1]
#  [1 0 1 0 1 0 1 0 1 0]
#  [0 1 0 1 0 1 0 1 0 1]
#  [1 0 1 0 1 0 1 0 1 0]]

arr14 = np.ones((10,10),dtype='int16')
arr14[::2,::2].fill(0)
arr14[1::2,1::2].fill(0)

print(arr14)

# Mathematical Operations on Numpy Array

arr15 = np.array([[[1,3,5],
                  [4,8,7],
                  [9,11,13]],

                  [[2,4,7],
                  [3,1,5],
                  [5,2,8]]])

print(arr15.sum())

# row wise (axis = 0)
print(arr15.sum(axis=0))

# column wise (axis = 1)
print(arr15.sum(axis=1))

# min()
arr15.min()

# max()
arr15.max()

# where() returns index position as per the condition = true
arr16=np.arange(1,21).reshape(5,4)
print(arr16)
print(np.where(arr16 > 8))


# Statistical methods

arr17 = np.arange(1,37).reshape(6,6)
arr17.mean()        # calculate mean
arr17.mean(axis=0)  # calculate mean - Row wise
arr17.mean(axis=1)  # Calculate mean - Col wise

np.std(arr17)      # Standard deviation 
np.var(arr17)      # Variance


# Reversing an array vector

array_3 = np.arange(50)
print(array_3[::-1])
print(arr6)
print(np.flip(arr6))

# flip the rows up and down
print(np.flipud(arr6)) 
# flip the columns left and right
print(np.fliplr(arr6))

# Flatten - To conver nD array to 1D array
array_4 = np.random.randint(10,50,size=(5,3))
print(array_4)
# 2D array to 1D array
print(array_4.flatten())

# ravel() - Flattens N-D array to 1-D array
print(array_4.ravel())

print(np.argmax(array_4))  # In 2D array they return the position
print(np.argmax(array_4,axis=0)) # row wise


# np.argmax() - Returns position of maximum value along the axis
array_5 =  np.array([1,2,8,11,3,6,7,13,5,7])
print(np.argmax(array_5))
