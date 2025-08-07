import pandas as pd
from datetime import datetime

df = pd.DataFrame({"a":[1,2,3]})
path = '/mnt/data/test_min.csv'
df.to_csv(path, index=False)
# {"ok": True, "path": path, "now": str(datetime.now())}
