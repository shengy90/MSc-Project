from pathlib import Path
import pandas as pd
import os

# Get test dataframe
path = Path(os.path.realpath(__file__))
parent_dir = str(path.parent.parent)
CLUSTER_DUMMY_DF = pd.read_csv(os.path.join(parent_dir, 'bin', 'cluster_dummy.csv'))
