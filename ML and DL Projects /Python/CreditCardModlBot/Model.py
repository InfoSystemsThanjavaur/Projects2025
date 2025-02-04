import pickle
import numpy as np


class Model:

    def __init__(self):
        with open('Models/new_model.pkl', 'rb') as f:
            self.model = pickle.load(f)
    

    def preprocessing(self , data ):
        data = list(data)
        if data[0] and data[1] and (data[2] != -1) and (data[3] != -1) and data[4] :
            data = np.array(data)
            data = data.reshape(-1,1)

            return data , True
        else:
            return 0 ,False
        
    def predict(self ,data):
        li = list(data)
        #p_data  , st  = self. preprocessing(data )

        print(self.model)
        
        data=np.array(li)
        print(type(data[0]))
        data=data.reshape(1,-1)
        print(data)
        res=self.model.predict(data)
        return res[0]

