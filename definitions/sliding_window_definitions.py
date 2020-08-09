from pathlib import Path
import pandas as pd
import os

# Get test dataframe
path = Path(os.path.realpath(__file__))
parent_dir = str(path.parent.parent)
SOM_DUMMY = pd.read_csv(os.path.join(parent_dir, 'bin', 'som_dummy.csv'))
TS_DUMMY = pd.read_csv(os.path.join(parent_dir, 'bin', 'ts_dummy.csv'))
TS_DUMMY['ds'] = pd.to_datetime(TS_DUMMY['ds'])
SOM_CLUSTER_DUMMY = pd.read_csv(os.path.join(parent_dir, 'bin', 'som_cluster_dummy.csv'))
